From: sampei02@tiscali.it
Subject: UDMA modes
Date: Tue, 16 Aug 2005 09:02:42 +0200
Message-ID: <42D7AAA0000490E9@mail-2.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout1.tiscali.it ([195.130.225.11]:23482 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S932608AbVHPHCw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 03:02:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have motherboard which supports DMA ATA 66/100/133 and I connect HD w=
ith
new 80-wire cable.
I have FC3 with Kernel 2.6.9
With hdparm -i /dev/hda I get:

DMA modes: udma0 udma1 udma2
UDMA modes: udma0 udma1 *udma2

Why udma is 2 and not udma 5 ?

__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tele=
com
a partire da 19,95 Euro/mese.
Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



