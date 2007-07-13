From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] ide-pmac: PIO fixes
Date: Fri, 13 Jul 2007 20:12:47 +0400
Message-ID: <4697A47F.8060704@ru.mvista.com>
References: <200707110204.07540.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44724 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754061AbXGMQKp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 12:10:45 -0400
In-Reply-To: <200707110204.07540.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add { 0, 0 } entry to {kauai,shasta}_pio_timings[] so kauai_lookup_timing()
>   always returns a valid PIO timing (fixes PIO timing not being set for devices
>   with minimum PIO cycle <= 120ns).

    Ugh... the way those tables are following each other, the driver should be 
programming MWDMA2 timings instead. :-/

> * Add setting transfer mode on the device to pmac_ide_set_pio_mode().

> * Fix pmac_ide_set_pio() to always program chipset for given PIO timing instead
>   of only when the device we want to program PIO timing for is the currently
>   selected one.

    Hm, why this was necessary?
    AFAIU, pmac_ide_do_setfeature() will cause selectproc() to be called 
anyway, via SELECT_DRIVE()...

> * Now that pmac_ide_set_pio() is fixed there is no need to set transfer mode
>   on the device and program chipset for PIO in pmac_ide_tune_chipset()

    BTW, I'm also not seeing much sense in calling 
pmac_ide_do_update_timings() from there as well since pmac_ide_do_setfeature() 
is called before that anyway.

>   (returning 0 == success is not entirely correct but is OK for now since
>   the upper layers are only checking ->speedproc return value for DMA modes).

> This patch should have no effect on the default kernel behavior because
> IDE pmac driver doesn't enable ->autotune (this would also explain why some
> of the above bugs remained unfixed for so long).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
