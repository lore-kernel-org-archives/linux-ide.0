From: P'tit Lu <ptitlu@ptitlu.org>
Subject: sata optical drive, i865 and 2.6.10
Date: Mon, 27 Dec 2004 01:25:33 +0100
Message-ID: <20041227002534.3204436957@irc.ptitlu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ABayonne-102-2-1-3.w217-128.abo.wanadoo.fr ([217.128.71.3]:16769
	"EHLO irc.ptitlu.org") by vger.kernel.org with ESMTP
	id S261360AbUL0AZg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Dec 2004 19:25:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


	Good evening and please excuse my english ;)
I read that you are the libata maintainer.

i supposed it is ok for sata hard disks, but Santa Claus brought me a
serial ata dvd burner. Plextor PX712-SA.
Here are the logs when i boot up :

modprobe ata_piix :

Dec 26 04:07:42 rabbit kernel: ata_piix version 1.03
Dec 26 04:07:42 rabbit kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Dec 26 04:07:42 rabbit kernel: ata1: SATA max UDMA/133 cmd 0xEC00 ctl
0xE802 bmdma 0xDC00 irq 18
Dec 26 04:07:42 rabbit kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl
0xE002 bmdma 0xDC08 irq 18
Dec 26 04:07:42 rabbit kernel: ata1: dev 0 cfg 49:0f00 82:0000 83:0000
84:0000 85:0000 86:0000 87:0000 88:0407
Dec 26 04:07:42 rabbit kernel: ata1: dev 0 ATAPI, max UDMA/33
Dec 26 04:07:42 rabbit kernel: ata1: dev 0 configured for UDMA/33
Dec 26 04:07:42 rabbit kernel: scsi8 : ata_piix
Dec 26 04:07:43 rabbit kernel: ata2: SATA port has no device.
Dec 26 04:07:43 rabbit kernel: scsi9 : ata_piix

And nothing more.

One more info, this is a 2.6.10 kernel and a i865 chipset (ICH5).

It is just a question of time for sata optical drives to be supported ?
Thanks for all

--=20
The only thing necessary for the triumph of evil is for good men to do
nothing
=B7
P'tit Lu <ptitlu@ptitlu.org>
http://ptitlu.org
jabber : P`tit_Lu@jabber.org
clef publique GnuPG : http://ptitlu.org/download/gpg-ptitlu.asc
-=B7-
