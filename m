From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RESEND 2/3] ahci: add AMD CZ SATA device ID
Date: Mon, 03 Jun 2013 14:04:04 +0400
Message-ID: <51AC6A14.2040908@cogentembedded.com>
References: <1370255050-2358-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370255050-2358-1-git-send-email-shane.huang-5C7GfCeVMHo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 03-06-2013 14:24, Shane Huang wrote:

> To add AMD CZ SATA controller device ID of IDE mode.

> Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>   drivers/ata/ahci.c      | 1 +
>   drivers/pci/quirks.c    | 2 ++
>   include/linux/pci_ids.h | 1 +
>   3 files changed, 4 insertions(+)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 751f1ea..548f1c3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -310,6 +310,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>
>   	/* AMD */
>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> +	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>   	/* AMD is using RAID class only for ahci controllers */
>   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
[...]
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e0b5623..22449c1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -570,6 +570,7 @@
>   #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
> +#define PCI_DEVICE_ID_AMD_CZ_SATA_IDE	0x7900

    We don't add the device IDs to this file anymore. And if you added 
it, why didn't you use it in ahci.c?

MBR, Sergei
