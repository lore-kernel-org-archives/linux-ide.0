From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Fri, 17 Aug 2007 19:41:47 +0400
Message-ID: <46C5C1BB.5020802@ru.mvista.com>
References: <20070808143320.0de8c5d9@the-village.bc.nu> <46BE1452.4010603@ru.mvista.com> <200708112337.48458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49916 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756313AbXHQPjY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 11:39:24 -0400
In-Reply-To: <200708112337.48458.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>@@ -117,8 +118,9 @@
>>> 	int arttim = arttim_port[ap->port_no][adev->devno];
>>> 	int drwtim = drwtim_port[ap->port_no][adev->devno];
>>> 
>>>-
>>>-	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
>>>+	/* ata_timing_compute is smart and will produce timings for MWDMA
>>>+	   that don't violate the drives PIO capabilities. */
>>>+	if (ata_timing_compute(adev, mode, &t, T, 0) < 0) {
>>> 		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
>>> 		return;
>>> 	}

>>    That function rocks (except I didn't get what the address setup timings 
>>mean to SW/MW DMA)...

> JFYI: this function was "borrowed" from drivers/ide/ide-timing.h,
> you can use it in IDE host drivers as well... ;)

    Heh, I know.  What I don't know is where to borrow the time for doing 
this... :-/

> Bart

MBR, Sergei
