From: Kumar Gala <kumar.gala@freescale.com>
Subject: pata error messages?
Date: Thu, 9 Aug 2007 10:59:12 -0500
Message-ID: <5E26159C-2122-4FE3-9CBF-F50644B7EE5C@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:40619 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762075AbXHIP5p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 11:57:45 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l79Fvd48006315
	for <linux-ide@vger.kernel.org>; Thu, 9 Aug 2007 08:57:39 -0700 (MST)
Received: from [10.82.244.181] ([10.82.244.181])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l79FvdH6027418
	for <linux-ide@vger.kernel.org>; Thu, 9 Aug 2007 10:57:39 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to figure out what could cause the following error  
messages.  This is on a PPC host using a ULI 1575 southbridge:

- k

ata5: PATA max UDMA/133 cmd 0xfdfee300 ctl 0xfdfee30a bmdma  
0xfdfee320 irq 6
ata6: PATA max UDMA/133 cmd 0xfdfee310 ctl 0xfdfee31a bmdma  
0xfdfee328 irq 6
ata5.00: ATAPI: SONY    DVD RW AW-Q170A, 1.72, max UDMA/66
ata5.00: configured for UDMA/66
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44:PIO4
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata5.00: limiting speed to UDMA/33:PIO4
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data  
36 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete

