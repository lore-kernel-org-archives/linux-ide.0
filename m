From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Best way to segments/requests
Date: Thu, 13 Dec 2007 22:59:31 +0000
Message-ID: <8b67d60712131459q35c3ef0dpe1347028112343fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15454 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbXLMW7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 17:59:37 -0500
Received: by py-out-1112.google.com with SMTP id u77so530273pyb.16
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 14:59:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am working on a driver for the CD Rom drive on the Sega Dreamcast
(the so-called "GD Rom" drive). This device is electorically
compatible with IDE-3 devices and has a pretty good match in terms of
the control block registers but it implements its own packet command
interface.

I now have a working driver but the performance is lousy.

The driver reads data off the disk using DMA and the target for the
DMA has to be a contiguous. Therefore I have set:

	/* using DMA so memory will need to be contiguous */
	blk_queue_max_hw_segments(gd.gdrom_rq, 1);
	/* set a large max size to get most from DMA */
	blk_queue_max_segment_size(gd.gdrom_rq, 0x40000);

ie only one segment per request but a big (for a small device) maximum
size for the segment.

A priori I can see no performance advantage in allowing each request
to include multiple segments because then I'd only have to reshake
them so they went in one at a time. But from the looks of it if I do
set the maximum number of segments to 1 then each request is limited
to the smallest size - ie what I set in blk_queue_hardsect_size.

Is that right? What is the best way to go here?
