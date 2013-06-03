From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RESEND v2 3/3] i2c-piix4: add AMD CZ SMBus device ID
Date: Mon, 03 Jun 2013 14:05:31 +0400
Message-ID: <51AC6A6B.3090808@cogentembedded.com>
References: <1370255095-2525-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1370255095-2525-1-git-send-email-shane.huang@amd.com>
Sender: stable-owner@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 03-06-2013 14:24, Shane Huang wrote:

> To add AMD CZ SMBus controller device ID.

> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Reviewed-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@vger.kernel.org
[...]

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 22449c1..b10a5b4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -571,6 +571,7 @@
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>   #define PCI_DEVICE_ID_AMD_CZ_SATA_IDE	0x7900
> +#define PCI_DEVICE_ID_AMD_CZ_SMBUS	0x790b

    We don't add the device IDs here anymore.

MBR, Sergei
