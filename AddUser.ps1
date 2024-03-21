# Define variables
$csvPath = "C:\Users\Administrator\Desktop\exchange_users.csv"

#Import Active Directory module
Import-Module ActiveDirectory


#Check if the CSV file exists
if (Test-Path $csvPath) {
    # Import CSV file
    $users = Import-Csv -Path $csvPath

    # Loop through each user in the CSV file
    foreach ($user in $users) {
        $firstName = $user.first_name
        $lastName = $user.last_name

#Create username by concatenating first name and last name
        $username = $firstName + "." + $lastName
        $password = ConvertTo-SecureString -AsPlainText "Password01!" -Force
        # Generate a random password
        # Create user in Active Directory
        New-ADUser -Name "$firstName $lastName" -GivenName $firstName -Surname $lastName -SamAccountName $username -UserPrincipalName "$username@KBSolutions.com" -AccountPassword $password -Enabled $true -PassThru
    }

    Write-Host "User creation completed."
} else {
    Write-Host "CSV file not found at path: $csvPath"
}
