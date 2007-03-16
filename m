From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 14:17:33 +0900
Message-ID: <45FA286D.8050705@gmail.com>
References: <20070315182005.944.qmail@web812.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:41816 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXCPFRk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 01:17:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so589469uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 22:17:39 -0700 (PDT)
In-Reply-To: <20070315182005.944.qmail@web812.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
> 
>> The driver is seriously broken regarding LBA48 support.  The timeout
>> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.  But
>> both the reading and writing are seriously broken.  I can't tell whether
>> they end up in the wrong sectors or garbage is transferred to/from the
>> right sectors.
> 
> I couldn't figure it out, either.  There were some times early on that I
> failed it all the way down to PIO4 and it worked just fine.  But, with DMA
> forget it.  

Hmmm... I played a bit with POLLING LBA48 but no luck.  I always got HSM
violation.

>> I'm really close to marking this device broken or we'll need to
>> implement a mechanism to veto LBA48 device from LLD (may be negative
>> return from ->dev_config).
> 
> Are you sure it's an LBA48 issue?  I was never sure how to check
> this but in my banging around, I never saw anything in the HOB fields.

Pretty sure.  If I write sequentially, the first sector out of LBA28
range gives me timeout (with 256 sector requests).  If I make a
filesystem insider LBA28 range proper, I can fsck it using another
controller and vice versa but if I do it outside of LBA48 range (using
255 sector requests), nothing gets written or read properly.

>> Reading the sunix driver, I can't find any relevant workaround.  It
>> never seems to initialize ctl address.  I'm curious whether the sunix
>> driver can do LBA48.  Bob, are you interested in testing this?
> 
> Sure.  I'll need to reorganize hardware again, but it'll give me something
> to do till the steelhead start their spring run.  :)

Have no idea what the steelhead is but thanks.  :-)

-- 
tejun
