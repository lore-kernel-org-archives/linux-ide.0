From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Marvell 88se9123 and 88se9128
Date: Tue, 26 Feb 2013 13:48:26 +0900 (JST)
Message-ID: <76776.35577.qm@web100010.mail.kks.yahoo.co.jp>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100010.mail.kks.yahoo.co.jp ([114.111.98.184]:34083 "HELO
	web100010.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754288Ab3BZEzJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2013 23:55:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

File ahci.c contains the following definitions:

389         /* Marvell */
390         { PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },        /* 6145 */
391         { PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },        /* 6121 */
392         { PCI_DEVICE(0x1b4b, 0x9123),
393           .class = PCI_CLASS_STORAGE_SATA_AHCI,
394           .class_mask = 0xffffff,
395           .driver_data = board_ahci_yes_fbs },                  /* 88se9128 */
396         { PCI_DEVICE(0x1b4b, 0x9125),
397           .driver_data = board_ahci_yes_fbs },                  /* 88se9125 */
398         { PCI_DEVICE(0x1b4b, 0x917a),
399           .driver_data = board_ahci_yes_fbs },                  /* 88se9172 */
400         { PCI_DEVICE(0x1b4b, 0x9192),
401           .driver_data = board_ahci_yes_fbs },                  /* 88se9172 on some Gigabyte */
402         { PCI_DEVICE(0x1b4b, 0x91a3),
403           .driver_data = board_ahci_yes_fbs },

As far as I can tell from reading, 88se9123 and 88se9128 are each numbered to match their names.  This suggests replacing one declaration with an incorrect comment by two new declarations:

            { PCI_DEVICE(0x1b4b, 0x9123),
              .class = PCI_CLASS_STORAGE_SATA_AHCI,
              .class_mask = 0xffffff,
              .driver_data = board_ahci_yes_fbs },                  /* 88se9123 */
            { PCI_DEVICE(0x1b4b, 0x9128),
              .class = PCI_CLASS_STORAGE_SATA_AHCI,
              .class_mask = 0xffffff,
              .driver_data = board_ahci_yes_fbs },                  /* 88se9128 */

A separate question is:  Does anyone know if the ahci driver would work with the RocketRaid 644's 88se9128 chip?  (For comparison, someone added the RocketRaid 2722's identifiers to the mvsas driver but the driver never recognized my SATA HDDs.)

