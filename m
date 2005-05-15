From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata-2.6: Ignore interrupt before the ATAPI CDB
 is sent to the device
Date: Sun, 15 May 2005 18:49:07 -0400
Message-ID: <4287D1E3.9070606@pobox.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56472 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261329AbVEOWtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 18:49:16 -0400
In-Reply-To: <427200B4.4050308@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Hi Jeff,
> 
> Problem:
>   Sometimes the interrupt handler is invoked before atapi_packet_task() 
> sending CDB to the device.
> The interrupt handler completes the command and later when 
> atapi_packet_task() runs, the command is already gone.
> 
> Changes:
>  - Add 2 PIO states to libata.h.
>  - Prevent the interrupt handler from completing the command before the 
> ATAPI CDB is sent to the device.
> 
> Attached please find the patch against the libata-2.6 tree for your 
> review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

There is an additional complication:

As specified in IDENTIFY PACKET DEVICE Word 0, in some older ATAPI 
devices, the device will assert an interrupt after the CDB has been 
submitted to the device.

Your patch is moving in the right direction...   but I think we should 
check Word 0 and perform actions accordingly, as some ATAPI devices 
appear to expect it.

I wonder if your ATAPI device is one of these?

	Jeff



