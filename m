From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/13] libata: use PIO for misc ATAPI commands
Date: Wed, 28 Nov 2007 08:01:54 +0900
Message-ID: <474CA1E2.1060008@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>	<11961764413291-git-send-email-htejun@gmail.com> <20071127165600.39b8c383@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.238]:6920 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbXK0XCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 18:02:22 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1321078hue
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 15:02:20 -0800 (PST)
In-Reply-To: <20071127165600.39b8c383@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Hello, Alan.

Alan Cox wrote:
> On Wed, 28 Nov 2007 00:13:59 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> ATAPI devices come with plethora of bugs and many ATA controllers have
>> trouble dealing with odd byte DMA transfers.  The problem is currently
>> somewhat masked by not allowing DMA transfers if the transfer size
>> isn't aligned to 16 bytes plus partial masking in problematic LLDs.
> 
> NAK. Same complaint I had originally and which is not addressed.

Heh, yeah, I expected NACK from you and my argument is the same.  I'll
just repeat one more time for the record as the other thread didn't cc
linux-ide.  :-)

> The whole approach being used here is fundamentally in the wrong place.
> Its also horribly damaging because of our PIO behaviour currently.
> 
> - Until our PIO works without IRQ masking you can't take this approach for
> arbitary devices without hurting users badly.

That definitely is on to do list.  I wonder Jeff is still against
turning off IRQ from the IRQ controller?

Also, even if it's being done from interrupt handler, the data transfer
is usually very short (tens of bytes).  I hardly feel any difference.
Also, let's not forget there are already drivers which do things this
way and yet others for which PIO or DMA doesn't matter at all.

> - I still see no evidence in the drives I've looked at that all of this
> is drive side (or indeed that most of it is)

Of the ten drives I tested, only two were problematic but then again I
didn't try with the 16 byte alignment test lifted.  What I'm worried
about is test coverage.  The 16 byte alignment made us avoid some
problem cases (Albert, do you recall which?) but the condition itself is
problematic because it partially masks actual problems (dumb luck (tm)).
 Plus, different drivers use different masking rules, so debugging
becomes difficult as the behavior depends on the combination of drive
and controller.

Because we can't use DMA uniformly, I went the other way and tried to
use PIO uniformly.  Another important point is that the other OS which
is probably the only platform most ATAPI device vendors test against use
PIO for these commands.

> - Control over the DMA/PIO strategy belongs with the driver. If we mess
> that up it will cost us dearly later.

And I don't get what we'll lose.  Care to deliberate?

> What we should be doing IMHO is
> 
> -	Fix the PIO IRQ masking
> -	Creating ata_std_check_atapi_dma()
> -	Let drivers select between the std_check_atapi_dma() and their
> own rules
> 
> Finally ata_std_check_atapi_dma should be blacklist based for all but the
> really generic issues (%15 etc), otherwise we punish the 99.999% of
> systems that work perfectly well for the sake of a tiny number that are
> problematic.

My argument is... Yes, we punish other systems, but the amount of
punishment is not substantial and definitely negotiable with gained
behavior uniformity between drivers and with the other OS.

Note1: If anybody can show me what we'll actually lose by forcing PIO,
I'm sold.

Note2: Let's say we fixed PIO IRQ masking.  Would that change your opinion?

Thanks.

-- 
tejun
