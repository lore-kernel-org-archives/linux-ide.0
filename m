From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v1] pata_via.c:  Patch the behavior of via chipsets.
Date: Thu, 15 Jan 2009 22:54:50 +0900
Message-ID: <496F402A.2090704@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56D@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49335 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbZAONzK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 08:55:10 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56D@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, sshtylyov@ru.mvista.com

Hello, Joseph.

JosephChan@via.com.tw wrote:
> This patch is to patch the behavior of via chipsets, which will reset the DEV 
> register to be reset value after changing the IEN bit on CTL register to cause
> channel reset. For some controllers, the pata_via default processing flow will
> work OK, because the controller will cache the value of the registers until it
> receives a set device operation (write the device register). By following the
> ATA/ATAPI protocol, DEV bit should be set before issuing ATA/ATAPI commands to
> device. And this patch is to set DEV bit after IEN bit is set of VIA chipset
> VX700/CX700, VX800/V820 and VX855 series.
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> --- a/drivers/ata/pata_via.c	2009-01-16 02:36:58.000000000 +0800
> +++ a/drivers/ata/pata_via.c	2009-01-16 02:39:04.000000000 +0800
> @@ -347,12 +347,11 @@
>   */
>  static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  {
> -	struct ata_taskfile tmp_tf;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	if (ap->ctl != ap->last_ctl && !(tf->flags & ATA_TFLAG_DEVICE)) {
> -		tmp_tf = *tf;
> -		tmp_tf.flags |= ATA_TFLAG_DEVICE;
> -		tf = &tmp_tf;
> +	if (tf->ctl != ap->last_ctl) {
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		iowrite8(tf->device, ioaddr->device_addr);

Oh, I see.  So the controller requires that the DEVICE register is
always loaded whenever ctl changes && it should be loaded before the
LBA regs.  Interesting.  Please note that the device select bit is
always loaded before any of these happens.

Can you please add comments to explain it?  Also, it would be nice if
you do ap->ctl = ap->last_ctl and turn off ATA_TFLAG_DEVICE to avoid
loading them yet again.

Thanks.

-- 
tejun
