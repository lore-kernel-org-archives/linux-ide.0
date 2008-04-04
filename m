From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstrema-fixes] libata: fix IDENTIFY order in ata_bus_probe()
Date: Fri, 04 Apr 2008 02:46:48 -0400
Message-ID: <47F5CED8.6010900@garzik.org>
References: <47F2E2D3.6050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55808 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbYDDGrO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:47:14 -0400
In-Reply-To: <47F2E2D3.6050100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Tejun Heo wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Commit f58229f8060055b08b34008ea08f31de1e2f003c accidentally made
> ata_bus_probe() not use reverse order probing.  Fix it.
> 
> There currently isn't any PATA driver which uses obsolete
> ata_bus_probe() path, so this patch is mainly for correctness.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> drivers/ata/libata-core.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4851988..2db5c9c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2660,7 +2660,7 @@ int ata_bus_probe(struct ata_port *ap)
>        specific sequence bass-ackwards so that PDIAG- is released by
>        the slave device */
> 
> -    ata_link_for_each_dev(dev, &ap->link) {
> +    ata_link_for_each_dev_reverse(dev, &ap->link) {
>         if (tries[dev->devno])
>             dev->class = classes[dev->devno];
> 

applied


