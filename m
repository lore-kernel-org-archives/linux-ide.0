From: Elad Lahav <elahav@uwaterloo.ca>
Subject: Kernel 2.6.27: Problems with DVD drive/nVidia MCP51
Date: Fri, 31 Oct 2008 10:02:15 -0400
Message-ID: <490B0FE7.1020107@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from services110.cs.uwaterloo.ca ([129.97.152.166]:38872 "EHLO
	services110.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398AbYJaOAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2008 10:00:13 -0400
Received: from [129.97.75.6] (jethro.cs.uwaterloo.ca [129.97.75.6])
	(authenticated bits=0)
	by services110.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id m9VE09V4012447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 31 Oct 2008 10:00:11 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After upgrading from 2.6.26.5 to 2.6.27.4, my DVD drive started having problems during 
boot time. Here is the relevant part from dmesg:

ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: HL-DT-ST DVD+/-RW GSA-T11N, A103, max UDMA/33
ata2.00: applying bridge limits
ata2.00: Drive reports diagnostics failure. This may indicate a drive
ata2.00: fault or invalid emulation. Contact drive vendor for information.
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3250820AS      3.AD PQ: 0 ANSI: 5
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: cmd a0/00:00:00:24:00/00:00:00:00:00/a0 tag 0 pio 36 in
          cdb 12 00 00 00 24 00 00 00  00 00 00 00 00 00 00 00
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
[continue ad inifitum....]

The drive is reported as "HL-DT-ST DVD+/-RW GSA-T11N, A103", connected to an nVidia MCP51 
controller. Googling around, I found similar complaints in the past for other nVidia 
controllers using the sata_nv driver (though I couldn't find anything about the MCP51). I 
tried compiling the version of sata_nv that comes with 2.6.26.5, but that did not solve my 
problems.

I can provide further details if necessary.

--Elad
