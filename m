From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Sat, 20 Sep 2008 22:26:05 +0400
Message-ID: <48D5403D.3020100@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <200809181645.10410.bzolnier@gmail.com> <48D37025.2030501@ru.mvista.com> <200809191010.09457.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46675 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbYITS0N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 14:26:13 -0400
In-Reply-To: <200809191010.09457.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>> This is the driver for the Toshiba TX4939 SoC ATA controller.
>>>>
>>>> This controller has standard ATA taskfile registers and DMA
>>>> command/status registers, but the register layout is swapped on big
>>>> endian.  There are some other endian issue and some special registers
>>>> which requires many custom dma_ops/port_ops routines.
>>>>
>>>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>>> ---
>>>> This patch is against linux-next 20080916.
>>>>
>>>> Changes since v1:
>>>> * rework IO accessors
>>>> * rework pio/dma timing setup
>>>> * use ide_get_pair_dev
>>>> * do not do ATA hard reset
>>>> * and so on  (Many thanks to Sergei)
>>>>     
>>>>         
>>> Sergei, are you OK with this version?
>>>   
>>>       
>>    I didn't have tome to look at it.
>>     
>
> I didn't mean to rush you.  I just prefer to have it in pata tree
>   

   Looking at it now... Unfortunately, it doesn't look compilable. :-/

MBR, Sergei


