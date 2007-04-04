From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 04 Apr 2007 23:42:01 +0400
Message-ID: <4613FF89.8000908@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200703282147.41696.sshtylyov@ru.mvista.com> <460AAEA5.40008@ru.mvista.com> <200704042133.26985.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:49231 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1750882AbXDDTrm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:47:42 -0400
In-Reply-To: <200704042133.26985.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Index: linux-2.6/include/linux/ide.h
>>>===================================================================
>>>--- linux-2.6.orig/include/linux/ide.h
>>>+++ linux-2.6/include/linux/ide.h
>>>@@ -613,7 +613,6 @@ typedef struct ide_drive_s {
>>> 
>>>         u8	quirk_list;	/* considered quirky, set for a specific host */
>>>         u8	init_speed;	/* transfer rate set at boot */
>>>-        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
>>>         u8	current_speed;	/* current transfer rate set */
>>>         u8	dn;		/* now wide spread use */
>>>         u8	wcache;		/* status of write cache */
>>
>>    Oops, forgot to pull the recent kernel before sending out, so this part 
>>won't apply bacause of the desired_speed nuisance. Do I need to resend?

> I was mentally prepared to fix it manually to save time on both sides but...

> Hunk #1 succeeded at 613 with fuzz 2.

    Probably you're using quilt newer that 0.42 then? :-)

> ;)

MBR, Sergei
