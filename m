From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [git patches] IDE update
Date: Mon, 04 Jul 2005 19:38:54 +0200
Message-ID: <42C9742E.8000204@rainbow-software.org>
References: <200507041706.UAA11178@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub3.nextra.sk ([195.168.1.146]:34322 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261433AbVGDRi6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jul 2005 13:38:58 -0400
In-Reply-To: <200507041706.UAA11178@raad.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
Cc: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, 'Linus Torvalds' <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Al Boldi wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> 
>>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
>>Hdparm -tT gives 38mb/s in 2.4.31
>>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
>>
>>Hdparm -tT gives 28mb/s in 2.6.12
>>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
>>
>>It feels like DMA is not being applied properly in 2.6.12.
> 
> 
> Are earlier 2.6.x kernels okay?
> 
> dmesg output?
> }
> 
> Same on 2.6.10,11,12.
> No errors though, only sluggish system.

Something like this http://lkml.org/lkml/2005/6/13/1 ?

-- 
Ondrej Zary
