From: Ric Wheeler <ric@emc.com>
Subject: Re: error handling - DMA to PIO step down sequence
Date: Thu, 21 Sep 2006 12:26:01 -0400
Message-ID: <4512BD19.5010401@emc.com>
References: <4511907F.1010104@emc.com> <4512AB17.7040907@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:50569 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751311AbWIUQ2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Sep 2006 12:28:45 -0400
In-Reply-To: <4512AB17.7040907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Ric Wheeler wrote:
> [--snipp--]
> 
>> Derating should probably never happen on normal drive errors - even 
>> those that might take 10's of seconds.  Often, drives will try really, 
>> really hard to recover and might eventually respond after internally 
>> giving up after up to 30 seconds.
> 
> 
> We definitely need to improve that part of EH.  It's more of a 
> proof-of-concept code to show that EH can do derating and all the fancy 
> stuff at the moment.
 >
> 
> However, I'm not so sure about being 'too' aggressive.  As long as the 
> error condition from the device indicates proper error condition which 
> is not transmission error, EH doesn't derate the device.  In your test 
> case, libata couldn't determine anything about the error condition other 
> than it has occurred for a known supported IO command, so after enough 
> retries, it starts to lower transmission speed.  I want to note two 
> things here.

That sounds like a reasonable strategy - my purpose here is not just to 
fix the one (I must add artificially injected) error that I saw 
recently, but to validate the general algorithm.  On older (non-libata) 
ATA drives, we will see those get bounced down to PIO mode in the field 
on a not too frequent basis.  We can usually just bump them back to DMA 
mode.

This typically happens after some kind of real error, but if we can keep 
them running at full tilt it makes it easier to offload to another 
device or migrate data to a new disk.

> 
> 1. The reason why EH took so long is not because of derating but 
> _probably_ because libata didn't know and couldn't tell upper layer much 
> about the error condition.  We definitely need to improve this part.  I 
> believe some problems are in libata and some in SCSI midlayer.

yes - SCSI needs this information to do the right thing.

> 
> 2. The derating sequence should be refined.  For example,
>     * if sata
>     * excessive aborts and NCQ on
>         -> turn off NCQ
>     * frequent tx or tons of unknown errs on known supported cmds
>       and 3gbps
>         -> use 1.5gbps

Sounds good to me...

Isn't this transition also done by the target? Maybe we don't need to do 
anything on the hba side, rather let the target bump down the link rate...

Do I understand that we would not drop into the various PIO modes for S-ATA?

>     * if pata
>     * frequent tx or tons of unknown errs on known supported cmds
>       and udma mode
>         -> step down once or twice (the first step is the next
>            lower level, the next UDMA2 if PATA for 40c-cbl case)
> 
>     * commands are failing too often that no meaningful work is done
>       or many DMA errors are reported (note that this often results in
>       timeout)
>     -> fall back to PIO, if still unusable fallback to PIO0, nothing
>        much to lose anyway.
> 
> Above usually results in four maximum derating steps.  Hmmm.. some SATA 
> devices may find one or two UDMA slow down steps useful if they're 
> bridged.  Anyways, the baseline is that the current steps are 
> unnecessarily too many.
> 
> Please note that derating steps isn't the biggest problem.  It just 
> looks prominent because of the first problem.
> 
>> Also, NACK's from unsupported commands or any type of media errors 
>> should not kick off this sequence.
> 
> 
> No, it doesn't.  Only abort or unknown failures on known supported 
> commands (READ/WRITE) or transmission errors cause the sequence.  Again, 
> it's the NQ bit that's offending here.
> 
>> Would this be a reasonable thing for a config option? Better to add 
>> yet another blacklist for devices that might have a justified need for 
>> this derating?
> 
> 
> No, I don't think this justifies a config option or a blacklist.  We 
> just need to improve the default behavior good enough.  For your case, 
> with the sequence outlined above, libata will turn off NCQ after several 
> such errors and then will get media error reported correct.  It will 
> result in some performance loss but if you have a drive with faulty 
> firmware + media error on that device, that's fair price to pay, isn't it?
> 
> Thanks.
> 

I agree - that sounds like a reasonable approach, not having to compile 
it in or blacklist is always preferred.

The one special case here is for RAID boxes where losing a single drive 
is not (usually) the worst thing you could do. Better to promptly report 
up an error than to hang an IO in error handling/recovery for more than 
a few tens of seconds so that the upper layer can correctly fail over. 
I think that we will hit this kind of response time with this scheme, 
right (less than 15-30 seconds worst case)?

On a (slightly) related note, fixing the support to disable NCQ (via 
hdparm or /sys or whatever) for drives that are known to have issues. We 
often see specific issues (like the NCQ impact mentioned above or maybe 
something even more subtle) that present in a specific firmware 
revision/drive model. Being able to just avoid that helps a lot for 
large vendors with a fairly monolithic field population ;-)

thanks!


