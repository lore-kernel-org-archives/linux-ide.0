From: "Maarten Vanraes" <maarten.vanraes@gmail.com>
Subject: [PATCH] new VIA AHCI SATA chipset
Date: Mon, 2 Apr 2007 22:27:11 +0200
Message-ID: <6f61137b0704021327r29739526g359a94567f123a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:41124 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965769AbXDBU1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2007 16:27:13 -0400
Received: by nz-out-0506.google.com with SMTP id s1so993369nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Apr 2007 13:27:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

last week i bought the new Medion from ALDI and I found that the SATA
isn't supported.

today i tried to recompile my kernel and added the id to the driver
(via8251 function) and it just worked... ( drivers/scsi/ahci.c )


         { PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_ahci }, /* ATI SB600 raid */
         { PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_ahci_vt8251 }, /* VIA VT8251 */
+        { PCI_VENDOR_ID_VIA, 0x6287, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+          board_ahci_vt8251 }, /* VIA VT8251 */
         { PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_ahci }, /* SiS 966 */
         { PCI_VENDOR_ID_SI, 0x1185, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_ahci }, /* SiS 966 */


i also submitted the info to the pci.ids project.

can you submit this as well?

Sincerly,

Maarten Vanraes
-- 
Alien is my name and head-biting is my game
