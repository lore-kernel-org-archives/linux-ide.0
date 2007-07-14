From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] ide-pmac: PIO fixes
Date: Sat, 14 Jul 2007 20:29:10 +0400
Message-ID: <4698F9D6.6020205@ru.mvista.com>
References: <200707110204.07540.bzolnier@gmail.com> <4697A47F.8060704@ru.mvista.com> <200707132203.16470.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50437 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755046AbXGNQ1H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 12:27:07 -0400
In-Reply-To: <200707132203.16470.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>* Add setting transfer mode on the device to pmac_ide_set_pio_mode().

>>>* Fix pmac_ide_set_pio() to always program chipset for given PIO timing instead
>>>  of only when the device we want to program PIO timing for is the currently
>>>  selected one.

>>    Hm, why this was necessary?

> No idea...

    I may understand why this was needed beore the patch but why keep it?

> ...(mis)optimization? :)

>>    AFAIU, pmac_ide_do_setfeature() will cause selectproc() to be called 
>>anyway, via SELECT_DRIVE()...

> Yes, but pmac_ide_do_setfeature() wasn't called et all in the old version
> of pmac_ide_set_pio().

    But now it is.

>>>* Now that pmac_ide_set_pio() is fixed there is no need to set transfer mode
>>>  on the device and program chipset for PIO in pmac_ide_tune_chipset()

>>    BTW, I'm also not seeing much sense in calling 
>>pmac_ide_do_update_timings() from there as well since pmac_ide_do_setfeature() 
>>is called before that anyway.

> The patch only intended to make pmac_ide_set_pio() match the code in
> pmac_ide_tune_chipset().  Thanks to your analysis I see now that more
> fixups/cleanups are possible in this driver but I'm not up to it...

    :-)

MBR, Sergei
