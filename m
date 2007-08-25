From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sun, 26 Aug 2007 00:49:11 +0400
Message-ID: <46D095C7.9020000@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <46BDD989.6060202@ru.mvista.com> <46BE0726.1080609@ru.mvista.com> <200708182118.45356.bzolnier@gmail.com> <46C85207.6030401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50973 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750912AbXHYUqe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Aug 2007 16:46:34 -0400
In-Reply-To: <46C85207.6030401@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

>>>    When are you planning to push out to Linus the 
>>> ide-mode-limiting-fixes-for-user-requested-speed-changes.patch? I'd 
>>> like my HPT37x SATA mode filtering stuff to be atop of this one, 
>>> after looking at it.

>> Preferably 2.6.24 material and ide_rate_filter() FIXME (respecting 
>> device PIO
>> limits) still needs to be addressed before pushing all mode limiting 
>> patches
>> upstream.

>    Maybe I'll look into this...

    PIO stuff seems done.

>>>>> ide_rate_filter() happily uses ide_find_dma_mode() nowadays 
>>>>> (however this
>>>>> hpt366 patch is for vanilla kernel which doesn't have the needed 
>>>>> changes).

>>>    Yeah, it keeps being in the same vein (same bug rather :-) as the 
>>> old code, i.e. not looking at hwif->mwdma_mask when falling back in 
>>> ide_rate_filter()...

>> Worth fixing but deserves a separate patch.

    Fixed (I hope).

>    It does. Unfortunately, after you said that this issue has been already
> dealt width, I've dropped (and lost) the code fixing this -- will have 
> to redo
> it now. :-/
>    I'm now envisioning the HPT37[24] SATA filtering work as series of n 
> patches:

> [1/4] introduce drive_is_sata() helper + minor fix to eighty_ninty_three()
> [2/4] hpt366: UltraDMA mode filter for SATA cards
> [3/4] fix ide_rate_filter() to respect hwif->mwdma_mask
> [4/4] introduce mwdma_filter() method and use it for HPT37x-based SATA 
> cards

    Looks like I'm done with [3/4] and almost done with [4/4]...
    "I have no more whiskey, I have to go home" %-)

>> Bart

MBR, Sergei
