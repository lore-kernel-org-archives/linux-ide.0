From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/4] libata: beef up iterators
Date: Mon, 27 Oct 2008 19:17:21 +0900
Message-ID: <49059531.8030903@kernel.org>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org>	<87tzaz77ix.fsf@denkblock.local> <490584A6.3020005@kernel.org> <87abcqtm0c.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41924 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYJ0KRd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 06:17:33 -0400
In-Reply-To: <87abcqtm0c.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Elias Oltmanns wrote:
> Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> Elias Oltmanns wrote:
>>>> -		ata_port_for_each_link(link, ap) {
>>>> -			ata_link_for_each_dev(dev, link)
>>>> +		ata_for_each_link(link, ap, EDGE) {
>>>> +			ata_for_each_dev(dev, link, ALL)
>>> Where did these short forms (EDGE, ALL) spring from? Does this code even
>>> compile?
>> +#define ata_for_each_link(link, ap, mode) \
>> +	for ((link) = ata_link_next(NULL, (ap), ATA_LITER_##mode); (link); \
>> +	     (link) = ata_link_next((link), (ap), ATA_LITER_##mode))
>> +
>> +#define ata_for_each_dev(dev, link, mode) \
>> +	for ((dev) = ata_dev_next(NULL, (link), ATA_DITER_##mode); (dev); \
>> +	     (dev) = ata_dev_next((dev), (link), ATA_DITER_##mode))
> 
> Sorry, I should have been more explicit. I was referring to EDGE and ALL
> as opposed to ATA_LITER_EDGE and ATA_DITER_ALL. Unless I've missed
> something, the former aren't defined anywhere in your patch.

I seriously can't be more explicit.  Please take a shower and read my
reply again, especially, the "ATA_[LD]ITER_##mode" part.  :-)

-- 
tejun
