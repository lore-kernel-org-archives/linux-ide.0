From: Citroklar <citroklar@amule.org>
Subject: Re: Bug or my setup?
Date: Fri, 29 Oct 2004 02:38:33 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1099010313.3978.13.camel@first>
References: <1098986037.4933.6.camel@first> <418153C8.8080800@developers.dk>
	 <58cb370e041028133252e723c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [82.149.231.169] ([82.149.231.169]:43730 "EHLO
	nsi16.miniserver.de") by vger.kernel.org with ESMTP id S263212AbUJ2AjI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Oct 2004 20:39:08 -0400
Received: from [192.168.0.7] (pd95e6b08.dip.t-dialin.net [217.94.107.8])
	by nsi16.miniserver.de (nsi16.miniserver.de) with ESMTP id 9BDC58AC1FD
	for <linux-ide@vger.kernel.org>; Fri, 29 Oct 2004 02:31:32 +0200 (CEST)
In-Reply-To: <58cb370e041028133252e723c9@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> What bugs are left in 2.6.10-rc1?
> -

I recompiled with #define ATA_ENABLE_ATAPI - and got only this:

ata3: command 0xa0 timeout, stat 0xf8 host_stat 0x0

Drive was not accessible. Then I tried recompiling with #define
ATA_DEBUG and #define ATA_VERBOSE_DEBUG but the only thing I got are
millions of message lines rolling over my screen, and the log entries on
that million lines about ata3 where my DVD is is only one line:

ata_host_intr: ata3: host_stat 0x0

Then, I tried with #define ATA_ENABLE_PATA and #define ATA_ENABLE_DMADIR
which gave the following: the kernel would boot up finding my SATA
harddisks and finding the name of the DVD drive! Something new! but then
it hang with a 0xa0 error on that dvd drive and the kernel didn't boot
further. I'm sorry there are no logs.

If there's anything I can do in particular, please tell me, but I am new
to kernel debugging although I have some experience in making it work
for my setups :)

Tobias.

