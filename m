From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Tue, 17 Aug 2010 21:41:24 +0400
Message-ID: <4C6AC9C4.3070307@ru.mvista.com>
References: <4C6A7CF6.5090706@kernel.org>	<201008171456.43648.bzolnier@gmail.com>	<4C6AA436.2090003@kernel.org> <20100817163917.58ea1d06@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44222 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0HQRmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 13:42:15 -0400
Received: by eyg5 with SMTP id 5so2138744eyg.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2010 10:42:13 -0700 (PDT)
In-Reply-To: <20100817163917.58ea1d06@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, "\"linux-ide@vger.kernel.org\" st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Milan Kocian <milan.kocian@wq.cz>

Alan Cox wrote:

>> Does it really need to merge the DMA timings too?  If the device can't
>> do certain timing, it's PIO configuration should reflect that so
>> merging PIO part only should be enough for PIO configuration, no?

> The timing code knows about DMA/PIO constraints itself. The whole mucking
> around passing both timings is just bogus.

> Pass pair->dma_mode only and it'll work out the PIO for you. Not that it
> matters - no real hardware has a DMA mode with a slower address setup
> than its PIO mode.

    The address setup timing means *exactly nothing* for DMA modes. I keep 
wondering why it has been added to the libata timing table...

MBR, Sergei

