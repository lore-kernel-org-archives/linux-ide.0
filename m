From: Tim Small <tim@seoss.co.uk>
Subject: ahci timeouts, retries etc.
Date: Wed, 14 Oct 2009 17:51:32 +0100
Message-ID: <4AD60194.8030106@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:59201 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934963AbZJNQvr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 12:51:47 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay1.allsecurenet.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <tim@seoss.co.uk>)
	id 1My74A-0001ZW-PU
	for linux-ide@vger.kernel.org; Wed, 14 Oct 2009 16:51:10 +0000
Received: from [91.208.163.30] (ermintrude [91.208.163.30])
	by zebedee.buttersideup.com (Postfix) with ESMTP id 51996639C1
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2009 17:51:08 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a Tyan S5375 (BIOS v1.03) ICH9 which periodically (approx twice a 
week) logs timeouts like this:

[6475755.652262] ata2.00: exception Emask 0x0 SAct 0x3832 SErr 0x0 action 0x6 frozen
[6475755.652262] ata2.00: cmd 60/18:08:2a:90:ee/00:00:12:00:00/40 tag 1 ncq 12288 in
[6475755.652262]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[6475755.652262] ata2.00: status: { DRDY }
[6475755.652262] ata2.00: cmd 61/60:20:6a:8c:ee/00:00:12:00:00/40 tag 4 ncq 49152 out
[6475755.652262]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
...
[6475755.652262] ata2.00: cmd 60/10:68:6a:65:ee/00:00:12:00:00/40 tag 13 ncq 8192 in
[6475755.652262]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[6475755.652262] ata2.00: status: { DRDY }
[6475755.652262] ata2: hard resetting link
[6475756.009863] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[6475756.040731] ata2.00: configured for UDMA/133
[6475756.040731] sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
[6475756.040731] sd 1:0:0:0: [sdb] Write Protect is off
[6475756.040731] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[6475756.040731] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


A look at the libata wiki suggests interrupt delivery problems as a 
possible explanation, but is this likely to be the case here?  I'm 
guessing that multiple interrupts must have been dropped by the time 
this error has occurred, as multiple requests are queued for the drive?

I'm assuming that the kernel will retry these requests after the sata 
link has been reset?

The errors appear to be randomly distributed over the four drives on 
this machine - all are Seagate ST31000340NS with either firmware version 
SN05 or SN16...

Cheers,

Tim.


-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

