import ethers from "ethers";

class VanarController {
  provider: ethers.providers.JsonRpcProvider;
  signer: ethers.Wallet | null = null;

  constructor(rpcURL: string) {
    this.provider = new ethers.providers.JsonRpcProvider(rpcURL);
  }

  // Function to connect to a wallet using a private key
  connectWallet(privateKey: string) {
    this.signer = new ethers.Wallet(privateKey, this.provider);
  }

  // Function to send transactions
  async sendTransaction(to: string, amount: ethers.BigNumberish) {
    if (!this.signer) throw new Error("Wallet not connected");
    const tx = await this.signer.sendTransaction({
      to,
      value: ethers.utils.parseEther(amount.toString()),
    });
    return tx;
  }

  // Function to interact with a contract
  // Improved typing and handling for contract interactions
  async callContractMethod<T extends any[]>(
    contractAddress: string,
    abi: any[],
    methodName: string,
    params: T
  ): Promise<any> {
    if (!this.signer) throw new Error("Wallet not connected");
    const contract = new ethers.Contract(contractAddress, abi, this.signer);
    const method = contract[methodName];

    // Assuming the method exists and is callable
    if (typeof method !== 'function') {
      throw new Error(`Method ${methodName} not found on contract`);
    }

    // Example of handling different method types could be more sophisticated
    try {
      return await method(...params);
    } catch (error) {
      console.error('Error calling contract method:', error);
      throw error;
    }
  }
}

export default VanarController;
