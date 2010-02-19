From: Asdo <asdo@shiftmail.org>
Subject: How to reread disk size?
Date: Sat, 20 Feb 2010 00:48:31 +0100
Message-ID: <4B7F234F.9000107@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.isti.cnr.it ([194.119.192.4]:2672 "EHLO mx2.isti.cnr.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469Ab0BTCTt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Feb 2010 21:19:49 -0500
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5-b2 #31825) id <01NJV7P6WAW0BF3HYU@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Sat, 20 Feb 2010 00:48:33 +0100
Received: from [10.0.0.61]
 (host-78-12-70-104.cust-adsl.tiscali.it [78.12.70.104])
 by mx.isti.cnr.it (PMDF V6.5-b2 #31826)
 with ESMTPSA id <01NJV7P4QEM4BJSI3Y@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Sat, 20 Feb 2010 00:48:31 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,
I have a system with hot swappable bays but one of the involved 
controllers apparently does not support hot swap:
(I have unfortunately an old kernel: 2.6.24)

00:1f.2 IDE interface: Intel Corporation 631xESB/632xESB/3100 Chipset 
SATA IDE Controller (rev 09) (prog-if 8f [Master SecP SecO PriP PriO])
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 19
        I/O ports at 18c8 [size=8]
        I/O ports at 18ac [size=4]
        I/O ports at 18c0 [size=8]
        I/O ports at 18a8 [size=4]
        I/O ports at 18b0 [size=16]
        Memory at da804400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2


I have swapped the disk with a larger one (750GB -> 1TB) but it blockdev 
--getsize64 still sees the old size. It has not realized I have swapped 
disk.

In the past I was doing:

  blockdev --rereadpt /dev/sdX

and it usually worked on other controllers to reread the size visible 
from "blockdev --getsize" or "blockdev --getsize64". One time I think it 
even worked on exactly *that* controller... but it's not working now, 
it's strange.

Is there a technique, or I am out of luck?
The machine should not be rebooted
I would even enter the size manually if possible: I know how many LBA 
blocks are in that disk.

Thank you
