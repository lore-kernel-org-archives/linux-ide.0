From: Richard Scobie <richard@sauce.co.nz>
Subject: PMP performance (was Re: Resets on sil3124 & sil3726 PMP)
Date: Tue, 28 Aug 2007 11:31:02 +1200
Message-ID: <46D35EB6.7070604@sauce.co.nz>
References: <46D28668.3020501@sauce.co.nz> <20070827224942.GB5714@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:42284 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbXH0X2N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2007 19:28:13 -0400
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id A9F09288263
	for <linux-ide@vger.kernel.org>; Tue, 28 Aug 2007 11:28:10 +1200 (NZST)
In-Reply-To: <20070827224942.GB5714@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robin H. Johnson wrote:

> /dev/md2:
>  Timing cached reads:   2334 MB in  2.00 seconds = 1167.20 MB/sec
>  Timing buffered disk reads:  350 MB in  3.01 seconds = 116.32 MB/sec
> 
> It should exceed that speed - if I run hdparm -tT on 3 or more separate drives
> in the array at the same time, their combined speed does not exceed 120Mb/sec
> (a single drive manages 71Mb/sec) - The system does claim it negated at 3Gbit,
> so I've wondering about a firmware bug in the sil24 or sil3726.

Thanks Robin.

I have seen reference to this performance limitation elsewhere:

http://www.barefeats.com/quick.html

and scroll down to the December 23rd 2006 entry.

"This is due to the fact that all current ExpressCard products use the 
Silicon Image 3132 chip set and, for some reason, that's as fast as it 
can go. Actually, the same is true of when the 3132 chipset is used in a 
PCIe SATA host adapter for the Mac Pro."

Looks like bad silicon maybe?

Regards,

Richard
