From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add parameter to disable ahci driver on Promise
 	PDC42819
Date: Mon, 16 Nov 2009 22:11:33 -0500
Message-ID: <4B021465.2030500@garzik.org>
References: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51218 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbZKQDLp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 22:11:45 -0500
In-Reply-To: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11/11/2009 04:54 AM, Mark Nelson wrote:
> ahci can drive the Promise PDC42819, but obviously it can only use SATA
> disks connected to this controller. The controller can actually support
> SAS disks as well, but at the moment only with Promise's own binary
> t3sas driver.
>
> To allow users to use both the ahci and the t3sas drivers in the same
> system (with t3sas controlling the PDC42819) we add a parameter,
> promise_enable that can be used to disable ahci on the Promise chip (by
> setting it to 0). This way even if the ahci driver is loaded first the
> t3sas driver can grab the Promise chip and the user's SAS disks will be
> operational.
>
> By default the parameter is 1 so ahci drives the controller.
>
> While we're at it, add a message letting users know that with ahci
> driving their Promise chip they won't be able to use their SAS disks.
>
> Signed-off-by: Mark Nelson<mdnelson8@gmail.com>
> ---
>   drivers/ata/ahci.c |   23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> Index: linux-2.6/drivers/ata/ahci.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/ahci.c
> +++ linux-2.6/drivers/ata/ahci.c
> @@ -700,6 +700,9 @@ static int marvell_enable = 1;
>   module_param(marvell_enable, int, 0644);
>   MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
>
> +static int promise_enable = 1;
> +module_param(promise_enable, int, 0644);
> +MODULE_PARM_DESC(promise_enable, "Promise PDC42819 via AHCI (1 = enabled)");
>
>   static inline int ahci_nr_ports(u32 cap)
>   {
> @@ -2988,6 +2991,26 @@ static int ahci_init_one(struct pci_dev
>   	if (pdev->vendor == PCI_VENDOR_ID_MARVELL&&  !marvell_enable)
>   		return -ENODEV;
>
> +	/* Promise's PDC42819 is a SAS/SATA controller that has an AHCI mode.
> +	 * At the moment, Promise's t3sas driver is required for SAS
> +	 * functionality. Disable ahci on this device if the user asked for
> +	 * it.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_PROMISE) {
> +		if (promise_enable) {
> +			dev_printk(KERN_INFO,&pdev->dev, "Promise PDC42819 "
> +							  "support enabled\n");
> +			dev_printk(KERN_INFO,&pdev->dev, "Only SATA devices "
> +							  "will function with"
> +							  " this driver\n");
> +
> +		} else {
> +			dev_printk(KERN_INFO,&pdev->dev, "Promise PDC42819 "
> +							  "support disabled\n");
> +			return -ENODEV;

I don't mind adding a warning "only SATA devices will function with this 
driver."

The promise_enable is not something we do with closed-source drivers, 
though, so that code logic is NAK'd

	Jeff




