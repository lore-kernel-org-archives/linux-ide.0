From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Sat, 11 Aug 2007 21:01:08 +0400
Message-ID: <46BDEB54.6060609@ru.mvista.com>
References: <200708042206.57529.bzolnier@gmail.com> <200708090057.13155.bzolnier@gmail.com> <46BCB86A.1010107@ru.mvista.com> <200708102358.25715.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61251 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752730AbXHKQ64 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 12:58:56 -0400
In-Reply-To: <200708102358.25715.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>   Good, that's what I lacked for hpt366.c!  Were you planning to push it to 
>>>>Linus soon?

>>>Not really but if needed I will extract MWDMA filter part and push it sooner.

>>    Erm, may I just merge it to my patch (mentioning you of course)?

> Sure.

   I guess you want to keep the method's name? :-)

>>>I planned to cc: AU1XXX platform maintainers on this patch but to my
>>>surprise MAINTAINERS lacks AU1XXX entry.

>>    It's been solt out to Raza Microelectronics last year and those guys never
>>sent a single patch to linux-mips...

> Thanks for the info.

    Unfortunately, I don't have direct access to DBAu1200 board (probably 
could get a remote though) and ealier Alchemy SoCs (which we have here) don't 
have the IDE support.

> Bart

MBR, Sergei
