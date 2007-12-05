From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 5 Dec 2007 14:01:19 +0000
Message-ID: <20071205140119.532c1eb4@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<4755ABB3.6030907@garzik.org>
	<4755FB90.50505@gmail.com>
	<20071205124713.4d31c5e7@the-village.bc.nu>
	<4756A1AE.4010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:57349 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751847AbXLEOGq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 09:06:46 -0500
In-Reply-To: <4756A1AE.4010205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

> Well, if we change that in #upstream now, -mm will receive it and after
> 2.6.24 is released, it will end up in -rc1.  We can change it back if
> the damage is too grave.

Getting it in -rc is going to mess up other testing. It's perfect for -mm
testing not -rc testing.

> Yeah, ALi seems to be genuine driver problem.  I don't think using PIO
> for misc ATAPI commands is extreme considering Windows is doing it.

Windows does a lot of things that are bad and ugly workarounds for messes
in the past. We have the ability to do a lot better than that.

> Another thing is check_atapi_dma in sata_promise.  It mentions losing
> interrupt which is exactly what happens if the drive tries to transfer
> more data but DMA buffer is short on several controllers.  I wonder
> whether this is unnecessary with DMA draining added.

Is it like the inic where you must do transfers in specific chunk sizes ?
