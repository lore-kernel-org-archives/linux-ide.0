From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Sun, 30 May 2004 06:44:01 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rly-ip04.mx.aol.com ([64.12.138.8]:20935 "EHLO
	rly-ip04.mx.aol.com") by vger.kernel.org with ESMTP id S263614AbUE3Moi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 May 2004 08:44:38 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 > > patch names the repeated five lines without
 > > changing where they are called.

That signal punched thru the noise, I hope, I see a record of it at:

http://marc.theaimsgroup.com/?l=linux-ide&m=108570321913006

 > > ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x12 0x0
 > > ata_tf_load_pio: device 0xA0
 > > ata_exec: cmd 0xA0

I think next I might try inserting step (b) into my attack:

a) 2.6 from kernel.org (now is 2.6.7-rc2)
b) Add an unsolicited ATA op x00 "NOP" after every CDB.
c) Substitute ATA op xA0 "PACKET" to convey SCSI op "REQUEST SENSE".
d) Auto sense only after "CHECK CONDITION", not after "GOOD".

Sorry I progress intermittently.  I only know how to progress rapidly 
in this thread when I happen to be physically adjacent to a desktop PC 
with a SATAPI cable.

Pat LaVarre

