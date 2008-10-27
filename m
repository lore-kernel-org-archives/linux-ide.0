From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH #upstream-fixes 2/4] libata: beef up iterators
Date: Mon, 27 Oct 2008 10:39:31 +0100
Message-ID: <87abcqtm0c.fsf@denkblock.local>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org>
	<87tzaz77ix.fsf@denkblock.local> <490584A6.3020005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:51589 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYJ0JlB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 05:41:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Elias Oltmanns wrote:
>>> -		ata_port_for_each_link(link, ap) {
>>> -			ata_link_for_each_dev(dev, link)
>>> +		ata_for_each_link(link, ap, EDGE) {
>>> +			ata_for_each_dev(dev, link, ALL)
>> 
>> Where did these short forms (EDGE, ALL) spring from? Does this code even
>> compile?
>
> +#define ata_for_each_link(link, ap, mode) \
> +	for ((link) = ata_link_next(NULL, (ap), ATA_LITER_##mode); (link); \
> +	     (link) = ata_link_next((link), (ap), ATA_LITER_##mode))
> +
> +#define ata_for_each_dev(dev, link, mode) \
> +	for ((dev) = ata_dev_next(NULL, (link), ATA_DITER_##mode); (dev); \
> +	     (dev) = ata_dev_next((dev), (link), ATA_DITER_##mode))

Sorry, I should have been more explicit. I was referring to EDGE and ALL
as opposed to ATA_LITER_EDGE and ATA_DITER_ALL. Unless I've missed
something, the former aren't defined anywhere in your patch.

>
>>> @@ -2891,7 +2881,7 @@ static int ata_link_nr_vacant(struct ata
>>>  	struct ata_device *dev;
>>>  	int cnt = 0;
>>>  
>>> -	ata_link_for_each_dev(dev, link)
>>> +	ata_for_each_dev(dev, link, ALL)
>>>  		if (dev->class == ATA_DEV_UNKNOWN)
>>>  			cnt++;
>>>  	return cnt;
>> 
>> What about making the two above (ata_link_nr_*()) static inline while
>> you are at it? Or is this another one of those cases where the compiler
>> knows best anyway?
>
> Yeah, it's a static function used only in single place.  Should be
> pretty straight forward for the compiler and even if it fails to
> notice it, it doesn't hurt at all.

I should have guessed, I suppose. Probably just was too lazy to check,
sorry.

>
>> [...]
>>> Index: work/drivers/ata/libata-scsi.c
>>> ===================================================================
>>> --- work.orig/drivers/ata/libata-scsi.c
>>> +++ work/drivers/ata/libata-scsi.c
>> [...]
>>> @@ -3254,9 +3254,9 @@ void ata_scsi_scan_host(struct ata_port
>>>  	 * failure occurred, scan would have failed silently.  Check
>>>  	 * whether all devices are attached.
>>>  	 */
>>> -	ata_port_for_each_link(link, ap) {
>>> -		ata_link_for_each_dev(dev, link) {
>>> -			if (ata_dev_enabled(dev) && !dev->sdev)
>>> +	ata_for_each_link(link, ap, EDGE) {
>>> +		ata_for_each_dev(dev, link, ENABLED) {
>>> +			if (!dev->sdev)
>>>  				goto exit_loop;
>>>  		}
>>>  	}
>> 
>> Getting rid of those braces would make things even cleaner in my
>> opinion. (That's my nit picking since Sergei picked on that comment
>> formatting issue shortly before I was going to ;-) ).
>
> Yeah, maybe.  I don't know.  The reason why I added braces there in
> the first place was because emacs has some problem dealing with nested
> non-standard looping constructs.

Right, I seem to remember having trouble with that myself. So I'm all in
favour of keeping them after all ;-).

Regards,

Elias
