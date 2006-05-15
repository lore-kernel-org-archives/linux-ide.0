From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide_dma_speed() fixes
Date: Mon, 15 May 2006 17:44:30 +0400
Message-ID: <446885BE.4090404@ru.mvista.com>
References: <4463F4C8.9080608@ru.mvista.com> <20060514050548.5399e3f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:19373 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S964909AbWEONpf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:45:35 -0400
In-Reply-To: <20060514050548.5399e3f4.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:

>>    ide_dma_speed() fails to actually honor the IDE drivers' mode support 
>> masks) because of the bogus checks -- thus, selecting the DMA transfer mode 
>> that the driver explicitly refuses to support is possible. Additionally, there 
>> is no check for validity of the UltraDMA mode data in the drive ID, and the 
>> function is misdocumented.

> drivers/ide/ide-lib.c: In function `ide_dma_speed':
> drivers/ide/ide-lib.c:86: warning: `ultra_mask' might be used uninitialized in this function

> Looks like a real bug to me - it depends up on the values of `mode' and
> id->field_value.

> Anyway, I'll drop it, please review and fix.  I assume that warning was
> occurring for you as well - please spend more time over these things. 
> Especially when working on IDE, where bugs are slow to show themselves and
> have particularly bad consequences.

    That's what gcc thinks. The code is 100% correct -- it will never reach 
the switch statement with mode > 0 (in which case ultra_mask isn't used) and 
ultra_mask unitialized. I may add an explicit initializer in the declaration 
if you like...

MBR, Sergei
