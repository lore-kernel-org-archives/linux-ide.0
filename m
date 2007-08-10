From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Fri, 10 Aug 2007 19:34:51 +0400
Message-ID: <46BC859B.6080606@ru.mvista.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com> <200708092248.44675.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55447 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757855AbXHJPcm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 11:32:42 -0400
In-Reply-To: <200708092248.44675.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rah@bash.sh

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Index: linux-2.6/drivers/ata/pata_hpt37x.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
>>+++ linux-2.6/drivers/ata/pata_hpt37x.c
>>@@ -8,12 +8,10 @@

> this driver is lacking author/maintainer info:

    Why I'm seeing it there then? :-O

> /*
>  * Libata driver for the highpoint 37x and 30x UDMA66 ATA controllers.

    They're actually not UDMA66, they are UDMA100/133.

MBR, Sergei
