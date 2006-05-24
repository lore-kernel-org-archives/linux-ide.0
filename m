From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Problems with 1GB SimpleTech CF Card
Date: Wed, 24 May 2006 12:34:27 +0200
Message-ID: <447436B3.4090906@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4360 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932671AbWEXKeb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 06:34:31 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 27C562F023
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 12:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 1BA031E20EC
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 12:34:30 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 3F9491213E
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 12:34:29 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I get repeatable erros when accessing a 1GB SimpleTech CF Flash Card (SLCF1GBJ).

I tested on three different systems (i86, arm, ppc) with three different
kernel versions (2.6.13, 2.6.14, 2.4.20). On ARM and PPC I tested pcmcia
mode _and_ TrueATA mode. Other, smaller (!) CF Cards are working fine.

So here we go:

~ # hdparm -i /dev/hda
Model=STI Flash 7.0.0, FwRev=05/03/04, SerialNo=STI J107004201112846
 Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
 RawCHS=2006/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=1, MultSect=off
 CurCHS=2006/16/63, CurSects=2022048, LBA=yes, LBAsects=2022048
 IORDY=no, tPIO={min:120,w/IORDY:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 AdvancedPM=no WriteCache=enabled

When doing "mke2fs /dev/hda1" after 30 seconds I get

	hda: irq timeout: status=0xd0 { Busy }
	ide: failed opcode was: unknown
	ide0: reset: master: error (0x00?)

and then after a long time loads of

	end_request: I/O error, dev hda, sector 786495
	Buffer I/O error on device hda1, logical block 786432
	lost page write due to I/O error on hda1

messages.

Has anyone else seen this before? Is it related to the size of the CF card?
The smaller, working cards use
	CurCHS=980/8/32, CurSects=250880, LBA=yes, LBAsects=250880
	CurCHS=980/16/32, CurSects=501760, LBA=yes, LBAsects=501760

Thanks a million!

--
Steven

