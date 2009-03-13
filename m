From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes, -stable] ata_piix: add workaround for
 Samsung DB-P70
Date: Fri, 13 Mar 2009 14:58:09 -0400
Message-ID: <49BAACC1.8090800@garzik.org>
References: <49ACB780.1070604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51697 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbZCMS6O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Mar 2009 14:58:14 -0400
In-Reply-To: <49ACB780.1070604@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, josephjang@gmail.com, mrsohn@gmail.com

Tejun Heo wrote:
> Samsung DB-P70 somehow botched the first ICH9 SATA port.  The board
> doesn't expose the first port but somehow SStatus reports link online
> while failing SRST protocol leading to repeated probe failures and
> thus long boot delay.
> 
> Because the BIOS doesn't carry any identifying DMI information, the
> port can't be blacklisted safely.  Fortunately, the controller does
> have subsystem vendor and ID set.  It's unclear whether the subsystem
> IDs are used only for the board but it can be safely worked around by
> disabling SIDPR access and just using SRST works around the problem.
> Even when the workaround is triggered on an unaffected board the only
> side effect will be missing SCR access.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Joseph Jang <josephjang@gmail.com>
> Reported-by: Jonghyon Sohn <mrsohn@gmail.com>
> ---
>  drivers/ata/ata_piix.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 54961c0..ef8b30d 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1289,6 +1289,39 @@ static const int *__devinit piix_init_sata_map(struct pci_dev *pdev,
>  	return map;
>  }
>  
> +static bool piix_no_sidpr(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +
> +	/*
> +	 * Samsung DB-P70 only has three ATA ports exposed and
> +	 * curiously the unconnected first port reports link online
> +	 * while not responding to SRST protocol causing excessive
> +	 * detection delay.
> +	 *
> +	 * Unfortunately, the system doesn't carry enough DMI
> +	 * information to identify the machine but does have subsystem
> +	 * vendor and device set.  As it's unclear whether the
> +	 * subsystem vendor/device is used only for this specific
> +	 * board, the port can't be disabled solely with the
> +	 * information; however, turning off SIDPR access works around
> +	 * the problem.  Turn it off.
> +	 *
> +	 * This problem is reported in bnc#441240.
> +	 *
> +	 * https://bugzilla.novell.com/show_bug.cgi?id=441420
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x2920 &&
> +	    pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG &&
> +	    pdev->subsystem_device == 0xb049) {
> +		dev_printk(KERN_WARNING, host->dev,
> +			   "Samsung DB-P70 detected, disabling SIDPR\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int __devinit piix_init_sidpr(struct ata_host *host)
>  {
>  	struct pci_dev *pdev = to_pci_dev(host->dev);
> @@ -1302,6 +1335,10 @@ static int __devinit piix_init_sidpr(struct ata_host *host)
>  		if (hpriv->map[i] == IDE)
>  			return 0;
>  
> +	/* is it blacklisted? */
> +	if (piix_no_sidpr(host))
> +		return 0;

applied


