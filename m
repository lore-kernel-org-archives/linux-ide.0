From: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?=
	<taneli.vahakangas@welho.com>
Subject: pata_ali complains at boot
Date: Sat, 16 Dec 2006 18:22:16 +0200
Message-ID: <20061216162216.GA28405@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:36833 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161181AbWLPQrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 11:47:33 -0500
Received: from newer.loc (cs181167086.pp.htv.fi [82.181.167.86])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 8AACC5BC0BA
	for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 18:22:16 +0200 (EET)
Received: from taneli by newer.loc with local (Exim 4.63)
	(envelope-from <taneli@welho.com>)
	id 1GvcIi-0007Sk-PR
	for linux-ide@vger.kernel.org; Sat, 16 Dec 2006 18:22:16 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm using pata_ali with ULi M1697, which has this:
00:16.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c7)


IDE works with either pata_ali or alim15x3, but pata_ali complains
at boot like this:
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: (BMDMA stat 0x24)
ata2.00: cmd c8/00:58:30:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 45056 in
         res 51/84:00:87:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2: soft resetting port
ata2.00: configured for UDMA/100
ata2: EH complete

This is repeated a few times, only with different UDMA levels.
Is this normal? Or at least not dangerous ...


I'm running libata-dev git tree as of tuesday plus a patch to
libata-core.c:ata_exec_internal from Tejun Heo, without which
it just oopses. ata2 port has only one drive:
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFF08 irq 15
ata2.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16


(Please copy responses, I'm not on the list.)

	Taneli

