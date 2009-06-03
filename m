From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pdc202xx_old: fix resetproc() method
Date: Wed, 03 Jun 2009 21:58:43 +0400
Message-ID: <4A26B9D3.90508@ru.mvista.com>
References: <200905300007.13113.sshtylyov@ru.mvista.com> <200905311658.45703.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60107 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751947AbZFCR5W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jun 2009 13:57:22 -0400
In-Reply-To: <200905311658.45703.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>pdc202xx_reset() calls pdc202xx_reset_host() twice, for both channels, while
>>that function actually twiddles the single, shared software reset bit -- the
>>net effect is a duplicated reset and horrendous 4 second delay happening not
>>only on a channel reset but also when dma_lost_irq() and dma_clear() methods
>>are called.  Fold pdc202xx_reset_host() into pdc202xx_reset(), fix printk(),
>>and move it before the actual reset...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>The patch is against the ide-2.6.git master branch...

>>Bart, I know you have the docs... from the now removed source code I was able
>>to figure out that the bit in question most probably drives RST- signal on both
>>channels (it seems to require re-tuning drives on both channels which we are
>>currently not doing). If I'm right, why the hell we're twiddling it on a normal
>>SRST reset, and what's worse on an interrupt timeout conditions? Anyway, it's

> Unfortunately the documentation doesn't say anything more than that the changing
> of the bit value results in SRST on both channels...

    I find it somewhat hard to believe that this bit controls SRST bits in 
the device control registers -- we have them both under our control anyway, 
why would we need such a "shortcut". I'd rather believe that this bit 
controls RESET- signal on both channels, with the neigboring bit 3 setting 
it to tristate mode the same way as it works on HPT37x (where BTW the 
datasheets call RESET- "SRST_") -- all this probably having to do with the 
hotswap support (busproc() method that manipulated bit 3 was removed from 
that driver by me 3 years ago)...

> IIRC from some old discussions this is required by the chipset sometimes..

    If that bit indeed controls SRST bits, I don't see how setting it in 
resetproc() helps (it can only harm, unwittingly resetting another channel). 
If this bit controls RESET-, I again don't see how/why it helps to 
hard-reset the channels in addition to the soft reset just performed. When
pdc202xx_reset() is called as the dma_clear() method, the channel is 
probably going be reset soon due to BSY=1, and when pdc202xx_reset() is 
called from dma_lost_irq() method, it seems a clear overkill...
	
>>hardly a good idea to reset both channels when you only have problem with only
>>one of them, and I don't see any justification to doing that... So maybe this
>>patch should've actually wiped out that whole reset insanity for good?..

> I'm pretty sure that there are valid reasons behind some of this insanity,
> OTOH (per mail from Alan) it completely ignores the fact that the other port
> may be active.. 

> We may try removing it in incremental patch so it is easier to track/revert
> it if things go wrong..

    OK, sounds like a plan...

MBR, Sergei
