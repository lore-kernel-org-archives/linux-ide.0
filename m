From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: remove broken disk byte-swapping support
Date: Tue, 04 Dec 2007 15:44:40 +0300
Message-ID: <47554BB8.5070803@ru.mvista.com>
References: <200712032253.26766.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:49852 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753357AbXLDMoW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 07:44:22 -0500
In-Reply-To: <200712032253.26766.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove broken disk byte-swapping support:
> - it can cause a data corruption on SMP (or if using PREEMPT on UP)
> - all data coming from disk are byte-swapped by taskfile_*_data() which
>   results in incorrect identify data being reported by /proc/ide/ and IOCTLs
> - "hdx=bswap/byteswap" kernel parameter has been broken on m68k host drivers
>   (including Atari Q40 one) since 2.5.x days (because of 'hwif' zero-ing)
> - byte-swapping is limited to PIO transfers (for working with TiVo disks on
>   x86 machines using user-space solutions or dm-byteswap should result in
>   much better performance because DMA can be used)

> For previous discussions please see:

> http://www.ussg.iu.edu/hypermail/linux/kernel/0201.0/0768.html
> http://lkml.org/lkml/2004/2/28/111

> [ I have dm-byteswap device mapper target if somebody is interested
>   (patch is for 2.6.4 though but I'll dust it off if needed). ]

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
