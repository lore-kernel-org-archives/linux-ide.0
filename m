From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: handle SEMB signature better
Date: Tue, 14 Apr 2009 08:12:47 -0400
Message-ID: <49E47DBF.9060502@garzik.org>
References: <49E466DE.7020701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35223 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbZDNMMw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 08:12:52 -0400
In-Reply-To: <49E466DE.7020701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Haun <drhaun88@gmail.com>, liw@liw.fi, jmcarranza@gmail.com

Tejun Heo wrote:
> WDC WD1600JS-62MHB5 successfully hits the window between ATA/ATAPI-7
> and Serial ATA II standards and reports 3c/c3 signature which now is
> assigned to SEMB.  Make ata_dev_classify() report ATA_DEV_SEMB on the
> sig and let ata_dev_read_id() work around it by trying IDENTIFY once.
> 
> This fixes bko#11579.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: David Haun <drhaun88@gmail.com>
> Reported-by: Lars Wirzenius <liw@liw.fi>
> Reported-by: Juan Manuel <jmcarranza@gmail.com>
> --
>  drivers/ata/libata-core.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 065507c..8f7d217 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1231,6 +1231,9 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>  	 *
>  	 * We follow the current spec and consider that 0x69/0x96
>  	 * identifies a port multiplier and 0x3c/0xc3 a SEMB device.
> +	 * Unfortunately, WDC WD1600JS-62MHB5 (a hard drive) reports
> +	 * SEMB signature.  This is worked around in
> +	 * ata_dev_read_id().
>  	 */
>  	if ((tf->lbam == 0) && (tf->lbah == 0)) {
>  		DPRINTK("found ATA device by sig\n");
> @@ -1248,8 +1251,8 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>  	}
>  
>  	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
> -		printk(KERN_INFO "ata: SEMB device ignored\n");
> -		return ATA_DEV_SEMB_UNSUP; /* not yet */
> +		DPRINTK("found SEMB device by sig (could be ATA device)\n");
> +		return ATA_DEV_SEMB;
>  	}
>  
>  	DPRINTK("unknown device\n");
> @@ -2080,6 +2083,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  	struct ata_taskfile tf;
>  	unsigned int err_mask = 0;
>  	const char *reason;
> +	bool is_semb = class == ATA_DEV_SEMB;
>  	int may_fallback = 1, tried_spinup = 0;
>  	int rc;
>  
> @@ -2090,6 +2094,8 @@ retry:
>  	ata_tf_init(dev, &tf);
>  
>  	switch (class) {
> +	case ATA_DEV_SEMB:
> +		class = ATA_DEV_ATA;	/* some hard drives report SEMB sig */
>  	case ATA_DEV_ATA:
>  		tf.command = ATA_CMD_ID_ATA;
>  		break;

Why assign class now, as opposed to after IDENTIFY DEVICE succeeds / fails?


> @@ -2119,6 +2125,7 @@ retry:
>  	else
>  		err_mask = ata_do_dev_read_id(dev, &tf, id);
>  
> +	err_mask |= AC_ERR_DEV;
>  	if (err_mask) {
>  		if (err_mask & AC_ERR_NODEV_HINT) {
>  			ata_dev_printk(dev, KERN_DEBUG,

Why is err_mask being unconditionally set?

I would think this would make more sense:

	if (!err_mask && class == ATA_DEV_SEMB)
		class = ATA_DEV_ATA;
	else if (err_mask) {
		if (err_mask & AC_ERR_NODEV_HINT) {
		...

Thanks,

	Jeff



