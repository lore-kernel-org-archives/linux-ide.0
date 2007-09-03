From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: HSM violation on bootup, ICH7 + ata_piix 2.6.22
Date: Mon, 03 Sep 2007 11:39:19 +0100
Message-ID: <1188815959.24223.18.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:44999 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXICKyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 06:54:43 -0400
Received: from 0599-its-ieg01.mail.saic.com ([139.121.18.36] [139.121.18.36]) by cpmx2.mail.saic.com id BT-MMP-9296312 for linux-ide@vger.kernel.org; Mon, 3 Sep 2007 03:39:35 -0700
Received: from cpmx2.mail.saic.com ([139.121.18.36])
 by 0599-its-ieg01.mail.saic.com (SMSSMTP 4.0.5.66) with SMTP id M2007090303393422319
 for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 03:39:34 -0700
Received: from ukabzc383.uk.saic.com ([10.89.2.37] [10.89.2.37]) by cpmx2.mail.saic.com with ESMTP id BT-MMP-1712634 for linux-ide@vger.kernel.org; Mon, 3 Sep 2007 03:39:34 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ukabzc383.uk.saic.com (Postfix) with ESMTP id ABC832AFE6
	for <linux-ide@vger.kernel.org>; Mon,  3 Sep 2007 11:39:19 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm looking ta a Dell SC440 system for a friend, and it's giving HSM
violations at startup.

The system itself has an ICH7 chipset, with two seagate ST3160812AS
drives attached along with a single ST3400832AS, running kernel 2.6.22
and the ata_piix driver.

I'm guessing this isn't good :(

Anybody gt any suggestions?

The violations are :


ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
123392 in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
126976 in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
ata1: EH complete


Cheers,
Eamonn



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

