From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/4] libata: beef up iterators
Date: Mon, 27 Oct 2008 18:06:46 +0900
Message-ID: <490584A6.3020005@kernel.org>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org> <87tzaz77ix.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47649 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYJ0JHC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 05:07:02 -0400
In-Reply-To: <87tzaz77ix.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Elias Oltmanns wrote:
>> -		ata_port_for_each_link(link, ap) {
>> -			ata_link_for_each_dev(dev, link)
>> +		ata_for_each_link(link, ap, EDGE) {
>> +			ata_for_each_dev(dev, link, ALL)
> 
> Where did these short forms (EDGE, ALL) spring from? Does this code even
> compile?

+#define ata_for_each_link(link, ap, mode) \
+	for ((link) = ata_link_next(NULL, (ap), ATA_LITER_##mode); (link); \
+	     (link) = ata_link_next((link), (ap), ATA_LITER_##mode))
+
+#define ata_for_each_dev(dev, link, mode) \
+	for ((dev) = ata_dev_next(NULL, (link), ATA_DITER_##mode); (dev); \
+	     (dev) = ata_dev_next((dev), (link), ATA_DITER_##mode))

>> @@ -2891,7 +2881,7 @@ static int ata_link_nr_vacant(struct ata
>>  	struct ata_device *dev;
>>  	int cnt = 0;
>>  
>> -	ata_link_for_each_dev(dev, link)
>> +	ata_for_each_dev(dev, link, ALL)
>>  		if (dev->class == ATA_DEV_UNKNOWN)
>>  			cnt++;
>>  	return cnt;
> 
> What about making the two above (ata_link_nr_*()) static inline while
> you are at it? Or is this another one of those cases where the compiler
> knows best anyway?

Yeah, it's a static function used only in single place.  Should be
pretty straight forward for the compiler and even if it fails to
notice it, it doesn't hurt at all.

> [...]
>> Index: work/drivers/ata/libata-scsi.c
>> ===================================================================
>> --- work.orig/drivers/ata/libata-scsi.c
>> +++ work/drivers/ata/libata-scsi.c
> [...]
>> @@ -3254,9 +3254,9 @@ void ata_scsi_scan_host(struct ata_port
>>  	 * failure occurred, scan would have failed silently.  Check
>>  	 * whether all devices are attached.
>>  	 */
>> -	ata_port_for_each_link(link, ap) {
>> -		ata_link_for_each_dev(dev, link) {
>> -			if (ata_dev_enabled(dev) && !dev->sdev)
>> +	ata_for_each_link(link, ap, EDGE) {
>> +		ata_for_each_dev(dev, link, ENABLED) {
>> +			if (!dev->sdev)
>>  				goto exit_loop;
>>  		}
>>  	}
> 
> Getting rid of those braces would make things even cleaner in my
> opinion. (That's my nit picking since Sergei picked on that comment
> formatting issue shortly before I was going to ;-) ).

Yeah, maybe.  I don't know.  The reason why I added braces there in
the first place was because emacs has some problem dealing with nested
non-standard looping constructs.

Thanks.

-- 
tejun
