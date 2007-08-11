From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 11 Aug 2007 22:59:50 +0400
Message-ID: <46BE0726.1080609@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com> <46BCAA85.3070905@ru.mvista.com> <200708102316.09960.bzolnier@gmail.com> <46BDD989.6060202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61609 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754405AbXHKS5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 14:57:38 -0400
In-Reply-To: <46BDD989.6060202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

Hello, I wrote:

>>  101 files changed, 1880 insertions(+), 2828 deletions(-)

>> please look at -mm or IDE quilt tree instead. :)

>    Looking...

    When are you planning to push out to Linus the 
ide-mode-limiting-fixes-for-user-requested-speed-changes.patch? I'd like my 
HPT37x SATA mode filtering stuff to be atop of this one, after looking at it.

>> ide_rate_filter() happily uses ide_find_dma_mode() nowadays (however this
>> hpt366 patch is for vanilla kernel which doesn't have the needed 
>> changes).

    Yeah, it keeps being in the same vein (same bug rather :-) as the old 
code, i.e. not looking at hwif->mwdma_mask when falling back in 
ide_rate_filter()...

[...]

>> I wouldn't be surprised if we actually _decrease_ the driver size a bit
>> (in addition to removal of ~35 LOC).

>    Decrasing .init.text section's width doesn't buy you much.

    Ugh, I meant "decreasing", not decraZing (another freudian slip :-) and 
"length", not "width"

>> Thanks,
>> Bart

MBR, Sergei
