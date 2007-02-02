From: Ric Wheeler <ric@emc.com>
Subject: Re: asdf
Date: Fri, 02 Feb 2007 11:59:25 -0500
Message-ID: <45C36DED.9020809@emc.com>
References: <11704009502014-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:36552 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945993AbXBBQ7j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 11:59:39 -0500
In-Reply-To: <11704009502014-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, edmudama@gmail.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>



Tejun Heo wrote:
> Hello,
>
> The current EH speed down code is more of a feature demonstration and
> goes through rdiculously many meaningless steps when condition is met.
> This patchset tries to put some intelligence into speed down sequence.
> The goal is to achieve reasonable number of speed down steps
> reasonably spaced from one another and consider NCQ, cable type and
> the current protocol when determining speed down steps, while not
> bloating the code too much with nitty gritty details.
>
> Roughly, the rules are...
>
> 1. If NCQ and protocol/timeout/unknown dev errors occur, turn off NCQ
>
> 2. If excessive transfer errors occur, speed down within the current
>    transfer mode (UDMA/MWDMA/PIO).  If UDMA, it's first adjusted down
>    a step, if error conditions persist, 40c limit is applied.  Speed
>    down is done only twice.
>
> 3. If PATA && used up all DMA speed down steps && a LOT of
>    transmission/unknown errors occur, switch to PIO.  So, we never
>    automatically step down to PIO on SATA.  This is intended.  Some
>    SATA hdd even seems to have problem with PIO data transfer
>    commands.
>
> The last patch makes ahci report HSM violation error on spurious
> completion of NCQ commands, thus causing NCQ off after several such
> incidents.  These drives should be blacklisted for DMA eventually.
>
> This patchset is against...
>
>   upstream (eb0e63cca36a3389f0ccab4584f6d479b983fad5)
> + [1] pata_platform-fix-devres-conversion
> + [2] libata-convert-to-iomap
>
> Ric, I guess this resolves the to-do item from you which has been
> sitting in my mailbox for way too long.  What do you think about the
> rules?
>
> Thanks.
>
>
>   
Thanks, this looks great!

The key here is making sure that we get a really good classification of 
error types and don't go down the step down path when the error does not 
indicate that the drive got the command and just correctly failed it.  
(That behavior, which we hit with one specific issues earlier & you have 
already fixed, reminds me of the American tourist abroad syndrome. If 
someone does not understand what you asked in English, just say it again 
slower and louder until they get it ;-)).

We might still want/need to be able to "lock" specific drives so that 
they do not drop out of DMA mode, not as the default but as a system 
tuning issue. What we see in the set of ATA drives that we have in the 
field  is that dropping out of DMA mode is basically useless (for us at 
least) since it is so slow and we always have other drives to fall back 
on. Clearly not the case for typical end users, but a common case in the 
storage space where we pack as many disk drives into each box as we can.

On that other thread, I mentioned that we need to get some good testing 
done with this kind of thing.  With Mark's error injection fixes (or the 
new ATA spec'ed ability to inject errors that Doug mentioned), along 
with our population of real world flaky drives, I hope to be able to 
beat on this in a realistic way in our labs,

ric

