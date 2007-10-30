From: Robert Hancock <hancockr@shaw.ca>
Subject: sata_nv and dynamically changing DMA mask?
Date: Mon, 29 Oct 2007 22:17:40 -0600
Message-ID: <4726B064.3000906@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:36824 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbXJ3EQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 00:16:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

In the sata_nv driver, when running in ADMA mode, we can do 64-bit DMA. 
However, when an ATAPI device like a DVD drive is connected, we can't 
use ADMA mode, and so we have to abide by the restrictions of a normal 
SFF ATA controller and can only do 32-bit DMA. We detect this and try to 
set the blk_queue_bounce_limit, blk_queue_segment_boundary and 
blk_queue_max_hw_segments to the values corresponding to a normal SFF 
controller.

However, we have this bug report:

https://bugzilla.redhat.com/show_bug.cgi?id=351451

that their DVD drive doesn't work properly on a computer with 4GB of RAM 
unless they either disable ADMA (thus resulting in the DMA parameters 
being initialized to the SFF ones from the start) or pass mem=3000M to 
the kernel to keep the memory above the 4GB mark from being used. Thus I 
suspect that what we're trying to do with the DMA parameters is not taking.

Question is: is setting blk_queue_bounce_limit enough to prevent 
addresses outside that mask from showing up, or does the device DMA mask 
also need to be updated? Is there anything wrong with just changing the 
DMA mask at runtime? Keep in mind, ATAPI and non-ATAPI devices can 
potentially be switched out on the port, so the mask might need to be 
updated at runtime..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

