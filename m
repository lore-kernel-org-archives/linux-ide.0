From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520	SATA
 (HPT372N)
Date: Mon, 03 Apr 2006 20:58:17 +0400
Message-ID: <44315429.5090602@ru.mvista.com>
References: <436FB350.6020309@inap.se> <1131467876.25192.51.camel@localhost.localdomain> <43750851.1080306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:6365 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932310AbWDCQ75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 12:59:57 -0400
In-Reply-To: <43750851.1080306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello.

Sergei Shtylylov wrote:

> Alan Cox wrote:

>> I've got the correct timing tables and PLL tune information for the 302N
>> now which appears to be very similar if not identical for these needs so
>> if someone wants to hack the old drivers/ide/pci driver a bit I can
>> provide reasonably accurate chip id and chip pll base information to
>> enable a fix.

>    I'm currently working on the old driver to bring in the HPT371N 
> support and fix HPT371 clock setup (and make the other chip's clock 
> setups correct along the way). Unfortunately I can test only on 371N and 
> 370A, the board with 371 soldered in has PCI contreoller fried.

    The driver rewrite is almost complete (after being preempted several 
times), I'm awaiting it to also be tested on HPT302. The changes are HUGE, the 
patch is about 70 KB in size...
    Meanwhile, I've noticed (just now :-) a bug in HPT372N clock turnaround 
code (it accesses extra DMA ports relative to dma_base, not dma_master which 
would make it do BAD things if called on a secondary channel) -- guess I 
should post them in a separate patch?

WBR, Sergei

