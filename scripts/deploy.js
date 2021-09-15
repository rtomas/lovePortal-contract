async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contacts with the account; ", deployer.address);
    console.log("Account Balance:", (await deployer.getBalance()).toString());

    const Token = await hre.ethers.getContractFactory("LovePortal");
    const token = await Token.deploy();

    console.log("LovePortal Address: ", token.address);
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });