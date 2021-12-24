const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal')
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'), // funds wallet with 0.1 eth from connected wallet
  })
  await waveContract.deployed()

  console.log('Contract deployed to:', waveContract.address)

  // get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  )
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  )

  // send wave
  let waveTxn = await waveContract.wave('This is wave #1')
  await waveTxn.wait() // wait for the transaction to be mined

  let waveTxn2 = await waveContract.wave('This is wave #2')
  await waveTxn.wait() // wait for the transaction to be mined

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  )

  let allWaves = await waveContract.getAllWaves()
  console.log(allWaves)
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}

runMain()
