From: Otto Meier <gf435@gmx.net>
Subject: Driver for sata adapter promise sata300 tx4
Date: Mon, 01 Aug 2005 16:14:20 +0200
Message-ID: <42EE2E3C.5060008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53205 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262086AbVHAOO1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 10:14:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

This card use the sata chip pdc 40718 (as of my card)
the lastest sata_promise kernel with sata promise patch driver doesn't 
recognise
this card.

I added the following line to static struct pci_device_id 
pdc_ata_pci_tbl[]  in sata_promise.c:

       { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
         board_20319 },

and the card was recognised and seam to work without errors so far.

bilding a soft raid5 on it and moving data doesn't broke it.

It would be interesting to hear from the guru's if this is ok to do?.

Otto


