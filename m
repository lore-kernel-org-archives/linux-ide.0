From: Steven Gill <smgill75@verizon.net>
Subject: sata_mv
Date: Mon, 11 Aug 2008 18:47:12 -0400
Message-ID: <48A0C170.2000803@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:55891 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbYHKWrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 18:47:16 -0400
Received: from vm.thebtbgroup.com ([72.78.111.7])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K5G00LB6KMBS68E@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 11 Aug 2008 17:47:00 -0500 (CDT)
Received: from [192.168.1.151] (unknown [192.168.1.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by vm.thebtbgroup.com (Postfix)
 with ESMTP id 9C9A476AD1	for <linux-ide@vger.kernel.org>; Mon,
 11 Aug 2008 18:46:59 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi List,

I am having some issues getting my Marvell 6145 working on my Asus P5E 
ws pro motherboard working.  I am using a 3rd party patch to get the 
pata port working, but have not had success with my e-sata ports (on the 
board the 6145 drives 2 sata and 2 e-sata ports.  There are another 6 
sata ports driven by the onboard intel ich9).  When checking dmesg 
output, I see this:

ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
Marvell (S)ATA Controller is found, using IRQ 16.
Interrupt Error: 0x40000000 orgIntStatus: 0x40000001 completeSlot=0x1.

I am willing to help debug any issues, test patches, etc, but most 
importantly wanted to report the issue.  I know this is labelled as 
"highly experimental", but again, wanted to offer assistance in testing.

Regards,

Steve
