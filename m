From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH #upstream-fixes 2/4] libata: beef up iterators
Date: Sun, 26 Oct 2008 15:31:02 +0100
Message-ID: <87tzaz77ix.fsf@denkblock.local>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:59795 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617AbYJZObf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 10:31:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo <tj@kernel.org> wrote:
> There currently are the following loop constructs.
>
> * __ata_port_for_each_link() for all available links
> * ata_port_for_each_link() for edge links
> * ata_link_for_each_dev() for all devices
> * ata_link_for_each_dev_reverse() for all devices in reverse order
>
> Now there's a need for loop construct which is similar to
> __ata_port_for_each_link() but iterates over PMP links before the host
> link.  Instead of adding another one with long name, do the following
> cleanup.
>
> * Implement and export ata_link_next() and ata_dev_next() which take
>   @mode parameter and can be used to build custom loop.
> * Implement ata_for_each_link() and ata_for_each_dev() which take
>   looping mode explicitly.
>
> The following iteration modes are implemented.
>
> * ATA_LITER_EDGE		: loop over edge links
> * ATA_LITER_HOST_FIRST		: loop over all links, host link first
> * ATA_LITER_PMP_FIRST		: loop over all links, PMP links first
>
> * ATA_DITER_ENABLED		: loop over enabled devices
> * ATA_DITER_ENABLED_REVERSE	: loop over enabled devices in reverse order
> * ATA_DITER_ALL			: loop over all devices
> * ATA_DITER_ALL_REVERSE		: loop over all devices in reverse order
>
> This change removes exlicit device enabledness checks from many loops
> and makes it clear which ones are iterated over in which direction.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
[...]
> Index: work/drivers/ata/libata-core.c
> ===================================================================
> --- work.orig/drivers/ata/libata-core.c
> +++ work/drivers/ata/libata-core.c
[...]
> @@ -1107,8 +1183,8 @@ static void ata_lpm_enable(struct ata_ho
>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		ap = host->ports[i];
> -		ata_port_for_each_link(link, ap) {
> -			ata_link_for_each_dev(dev, link)
> +		ata_for_each_link(link, ap, EDGE) {
> +			ata_for_each_dev(dev, link, ALL)

Where did these short forms (EDGE, ALL) spring from? Does this code even
compile?

[...]
> Index: work/drivers/ata/libata-eh.c
> ===================================================================
> --- work.orig/drivers/ata/libata-eh.c
> +++ work/drivers/ata/libata-eh.c
[...]
> @@ -2880,9 +2871,8 @@ static int ata_link_nr_enabled(struct at
>  	struct ata_device *dev;
>  	int cnt = 0;
>  
> -	ata_link_for_each_dev(dev, link)
> -		if (ata_dev_enabled(dev))
> -			cnt++;
> +	ata_for_each_dev(dev, link, ENABLED)
> +		cnt++;
>  	return cnt;
>  }
>  
> @@ -2891,7 +2881,7 @@ static int ata_link_nr_vacant(struct ata
>  	struct ata_device *dev;
>  	int cnt = 0;
>  
> -	ata_link_for_each_dev(dev, link)
> +	ata_for_each_dev(dev, link, ALL)
>  		if (dev->class == ATA_DEV_UNKNOWN)
>  			cnt++;
>  	return cnt;

What about making the two above (ata_link_nr_*()) static inline while
you are at it? Or is this another one of those cases where the compiler
knows best anyway?

[...]
> Index: work/drivers/ata/libata-scsi.c
> ===================================================================
> --- work.orig/drivers/ata/libata-scsi.c
> +++ work/drivers/ata/libata-scsi.c
[...]
> @@ -3254,9 +3254,9 @@ void ata_scsi_scan_host(struct ata_port
>  	 * failure occurred, scan would have failed silently.  Check
>  	 * whether all devices are attached.
>  	 */
> -	ata_port_for_each_link(link, ap) {
> -		ata_link_for_each_dev(dev, link) {
> -			if (ata_dev_enabled(dev) && !dev->sdev)
> +	ata_for_each_link(link, ap, EDGE) {
> +		ata_for_each_dev(dev, link, ENABLED) {
> +			if (!dev->sdev)
>  				goto exit_loop;
>  		}
>  	}

Getting rid of those braces would make things even cleaner in my
opinion. (That's my nit picking since Sergei picked on that comment
formatting issue shortly before I was going to ;-) ).

Regards,

Elias
