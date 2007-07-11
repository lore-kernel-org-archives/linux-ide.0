From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported
 modes
Date: Thu, 12 Jul 2007 00:15:46 +0400
Message-ID: <46953A72.6070204@ru.mvista.com>
References: <200707110200.37607.bzolnier@gmail.com> <46952A87.6010005@ru.mvista.com> <20070711195641.GA2301@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:27672 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796AbXGKUNp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 16:13:45 -0400
In-Reply-To: <20070711195641.GA2301@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Russell King wrote:

>>>icside_set_speed() happily accepts unsupported transfer modes which
>>>results in drive->drive_data being set to the maximum value (480)
>>>and drive->current_speed being set to the unsupported transfer mode.

>>>Fix it.

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> I wonder why Sergei's acking this patch - do you have the hardware to
> test it on?  Are you somehow involved in this driver?  I think the
> answer to both is most likely no.

    This just signified my positive review (as for any other IDE patch).

> Moreover, I think the patch is quite broken.  If an invalid DMA mode

    In what way I wonder?

> is passed, currently the driver sets the cycle time to 480ns (stored
> in drive_data) since both cycle_time and use_dma_info will be zero.

    Why bother doing this?  The speedproc() method shouldn't even try to 
handle an unsupopoted mode, to begin with.,,

> Moreover, 'on' will be zero, causing icside_set_speed() to return zero

    It means just the opposite for the speedproc() -- i.e. success.

> which means the DMA setting was not successful (iow, use PIO).

    You're mixing with the ide_dma_check() method.

> This causes icside_dma_check() to return -1 to the IDE layer which
> should fail the setting.

    Then the speedproc() method's return value and the ide_dma_check() method 
must be fixed too -- NAK the patch. I haven't noticed so far that this driver 
is more broken than the others, sorry. :-)

> With your patch, you make icside_set_speed() return '1' meaning DMA
> was succesfully configured.  That then causes icside_dma_check() to

    The return value was wrong from the very start -- any non-zero result 
should mean error.

> return success to the IDE layer, so we now allow invalid speeds.

    What it does *now* is returning bad result to ide_tune_dma() and the 
possible userspace callers.

> Ergo, what wasn't broken before is now broken.  So the patch is
> completely wrong and was trying to fix a problem which didn't exist in
> the first place.

    More like incomplete fix to an existing problem.

> BIG NAK.

    Indeed. It needs a bigger hammer. ;-)

MBR, Sergei
