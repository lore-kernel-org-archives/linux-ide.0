From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 14:06:34 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4067223A.1040006@pobox.com>
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35293 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262356AbUC1TGs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 14:06:48 -0500
In-Reply-To: <20040328181502.GO24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> Yep it sure does, but try and find a drive attached to a SATA controller
> that cannot do 40MiB/sec (or something like that). Storage doesn't move
> _that_ fast, you can keep up.

Nanosecond latencies and disturbingly high throughput are already 
possibly today :)  Consider the battery-backed RAM gadgets that present 
themselves as ATA devices, or nbd over 10gige network.

In fact I'm about to strip down drivers/scsi/sata_promise.c to a driver 
that just talks to the DIMM, and another else:  drivers/block/pdc_mem.c. 
  At that point you're really just looking at the PCI bus and RAM limits...

	Jeff



