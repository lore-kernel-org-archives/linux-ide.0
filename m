From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] pata_cmd64x: fix crash on boot with disabled secondary
 port
Date: Wed, 20 Apr 2011 00:48:11 +0400
Message-ID: <4DADF50B.2040101@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site> <1303152323.7167.16.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303152323.7167.16.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

On 18-04-2011 22:45, James Bottomley wrote:

> On non-x86 systems, probing a port which is listed as disabled can
> cause an immediate crash.  Fix the driver not to do this by porting
> the enablebits check from the IDE driver and setting the
> ATA_HOST_SFF_SINGLE_PORT flag if only the primary is enabled.

> Signed-off-by: James Bottomley<James.Bottomley@HansenPartnership.com>
> ---
>   drivers/ata/pata_cmd64x.c |   22 +++++++++++++++++++---
>   1 files changed, 19 insertions(+), 3 deletions(-)

> diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
> index 905ff76..aa71a13 100644
> --- a/drivers/ata/pata_cmd64x.c
> +++ b/drivers/ata/pata_cmd64x.c
> @@ -41,6 +41,9 @@
>   enum {
>   	CFR 		= 0x50,
>   		CFR_INTR_CH0  = 0x04,
> +	ENPORT		= 0x51,

    The register is actually called CNTRL.
    BTW, the PCI-649 specification is available at:
http://gkernel.sourceforge.net/specs/sii/SiI649-DS-0066.pdf.bz2

> +		ENPORT_PRIMARY   = 0x04,
> +		ENPORT_SECONDARY = 0x08,
>   	CMDTIM 		= 0x52,
>   	ARTTIM0 	= 0x53,
>   	DRWTIM0 	= 0x54,
> @@ -329,8 +332,8 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   		}
>   	};
>   	const struct ata_port_info *ppi[] = {&cmd_info[id->driver_data], NULL };
> -	u8 mrdmode;
> -	int rc;
> +	u8 mrdmode, reg;
> +	int rc, hflags = 0;
>
>   	rc = pcim_enable_device(pdev);
>   	if (rc)
> @@ -354,6 +357,19 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mrdmode |= 0x02;	/* Memory read line enable */
>   	pci_write_config_byte(pdev, MRDMODE, mrdmode);
>
> +	/* check for enabled ports */
> +	pci_read_config_byte(pdev, ENPORT, &reg);
> +	/* the cm643 primary port is always enabled */
> +	if (id->driver_data != 0&&  !(reg&  ENPORT_PRIMARY)) {

    That's not quite correct. The original PCI0646 didn't have the primary 
channel enable bit as well as PCI0643; only PCI0646U+ had the bit in question.

> +		dev_printk(KERN_ERR, &pdev->dev, "Primary port is disabled; detaching\n");
> +		return -ENODEV;

    Why? It's perfectly valid to have only secondary port enabled.

WBR, Sergei

