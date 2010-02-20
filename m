From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Sat, 20 Feb 2010 12:35:00 -0600
Message-ID: <4B802B54.1080009@gmail.com>
References: <20100220142826.62dd5989@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:57170 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab0BTSfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Feb 2010 13:35:04 -0500
Received: by yxe38 with SMTP id 38so1185641yxe.4
        for <linux-ide@vger.kernel.org>; Sat, 20 Feb 2010 10:35:03 -0800 (PST)
In-Reply-To: <20100220142826.62dd5989@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 02/20/2010 07:28 AM, Benjamin S. wrote:
>
> Hello list,
>
> I have a Super Talent Ultradrive GX MLC 64GB SSD and an Intel
> DH55HC board with H55 chipset. Processor is an Intel Core i5-661.
>
> Since 2.6.32 the sequentiell read performance of the ssd is bad:
>
> # dd if=/dev/sda of=/dev/zero bs=1M count=300
> 300+0 records in
> 300+0 records out
> 314572800 bytes (315 MB) copied, 4.61777 s, 68.1 MB/s
>
> Same results with other blocksizes (e.g tested with 4K).
>
>
> With 2.6.31.7 the same hardware is able to read with about
> 190MB/s.
>
>
> The normal hard drive reads with both kernel versions with about 100MB/s.
>
>
> Does somebody have an idea what I can test before I have to bisect
> it?

Could be some kind of block layer or IO scheduler behavior change.. you 
could try testing after doing:

echo noop > /sys/block/sda/queue/scheduler

or

echo deadline > /sys/block/sda/queue/scheduler

and see if that affects the speed..
