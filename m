From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Date: Wed, 5 Sep 2018 22:15:59 +0200
Message-ID: <e865f801-dc68-7583-62a0-40579c324e84@redhat.com>
References: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Tripathi <stripathi@amperecomputing.com>, axboe@kernel.dk, tj@kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: patches@amperecomputing.com, Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On 05-09-18 22:12, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support
> AHCI ALPM feature. This patch disables the AHCI ALPM feature for
> eMAG SATA.
> 
> Changes for v2:
> 
> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
> * Include this object for eMAG SATA inside the acpi match table.
> * Retrieve the ata_port_info from the acpi match table.
> 
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
> ---
>   drivers/ata/ahci_platform.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 99f9a89..c3043f6 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -33,6 +33,13 @@
>   	.port_ops	= &ahci_platform_ops,
>   };
>   
> +static const struct ata_port_info ahci_port_info_nolpm = {
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_platform_ops,
> +};
> +
>   static struct scsi_host_template ahci_platform_sht = {
>   	AHCI_SHT(DRV_NAME),
>   };
> @@ -41,7 +48,8 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
> -	int rc;
> +	const struct ata_port_info *port;
> +        int rc;

You are accidentally changing the indentation of rc here.

Please fix this and run scripts/checkpatch.pl on the patch before
submitting v3. Otherwise v2 looks good.

Regards,

Hans






>   
>   	hpriv = ahci_platform_get_resources(pdev);
>   	if (IS_ERR(hpriv))
> @@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>   
> -	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
> +	port = acpi_device_get_match_data(dev);
> +	if (!port)
> +		port = &ahci_port_info;
> +
> +	rc = ahci_platform_init_host(pdev, hpriv, port,
>   				     &ahci_platform_sht);
>   	if (rc)
>   		goto disable_resources;
> @@ -85,6 +97,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>   
>   static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
>   	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>   	{},
>   };
> 
