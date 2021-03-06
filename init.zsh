#####################################################################

######################################################################
#<
#
# Function: p6df::modules::azure::deps()
#
#>
######################################################################
p6df::modules::azure::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::azure::external::brew()
#
#>
######################################################################
p6df::modules::azure::external::brew() {

  brew install azure-cli
  brew install --cask azure-data-studio
  brew install --cask microsoft-azure-storage-explorer
  brew install --cask powershell
}

######################################################################
#<
#
# Function: p6df::modules::azure::langs()
#
#>
######################################################################
p6df::modules::azure::langs() {

  az extension add --name account
  az extension add --name alias
  az extension add --name codespaces
  az extension add --name connectedk8s
  az extension add --name deploy-to-azure
  az extension add --name dev-spaces
  az extension add --name hack
  az extension add --name k8sconfiguration
  az extension add --name portal
  az extension add --name subscription
  az extension add --name vm-repair
}

######################################################################
#<
#
# Function: p6df::modules::azure::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::azure::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/azure" ".azure"
}

######################################################################
#<
#
# Function: p6df::modules::azure::init()
#
#>
######################################################################
p6df::modules::azure::init() {

  p6df::modules::azure::completions::init
  p6df::modules::azure::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::azure::prompt::init()
#
#>
######################################################################
p6df::modules::azure::prompt::init() {

  p6df::core::prompt::line::add "p6df::modules::azure::prompt::line"
}

######################################################################
#<
#
# Function: p6df::modules::azure::completions::init()
#
#>
######################################################################
p6df::modules::azure::completions::init() {

  autoload -U +X bashcompinit && bashcompinit
  source /usr/local/etc/bash_completion.d/az
}

######################################################################
#<
#
# Function: p6df::modules::azure::prompt::line()
#
#>
######################################################################
p6df::modules::azure::prompt::line() {

  p6_azure_prompt_info
}

## XXX: move to p6azure
######################################################################
#<
#
# Function: str str = p6_azure_prompt_info()
#
#  Returns:
#	str - str
#
#  Environment:	 HOME
#>
######################################################################
p6_azure_prompt_info() {

  local str
  if p6_file_exists "$HOME/.azure/accessTokens.json"; then
      local mtime=$(p6_dt_mtime "$HOME/.azure/accessTokens.json")
      local now=$(p6_dt_now_epoch_seconds)
      local diff=$(p6_math_sub "$now" "$mtime")

      if ! p6_math_gt "$diff" "2700"; then
          local subscription=$(cat $HOME/.azure/clouds.config | awk -F= '/subscription/ { print $2 }' | sed -e 's, *,,g')
          local name=$(jq < $HOME/.azure/azureProfile.json | grep -A 12 $subscription | grep name |grep -v '@' | sed -e 's,.*:,,' -e 's/[",]//g' -e 's,^ *,,')
          local user=$(jq < $HOME/.azure/azureProfile.json | grep -A 12 $subscription | grep name |grep '@' | sed -e 's,.*:,,' -e 's/[",]//g' -e 's,^ *,,')

	  local sts
          if p6_math_gt "$diff" "2400"; then
              sts=$(p6_color_ize "red" "black" "sts:$diff")
          elif p6_math_gt "$diff" "2100"; then
              sts=$(p6_color_ize "yellow" "black" "sts:$diff")
          else
              sts="sts:$diff"
          fi

          str="azure:    _active:[$name - $user] [] () ($sts)"
      fi
  fi

  p6_return_str "$str"
}
