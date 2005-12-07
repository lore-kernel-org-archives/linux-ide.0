From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: More PIIX bugs
Date: Wed, 07 Dec 2005 22:38:34 +0000
Message-ID: <1133995114.544.107.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:58527 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751810AbVLGWjQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 17:39:16 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id jB7McYAY008341
	for <linux-ide@vger.kernel.org>; Wed, 7 Dec 2005 22:38:35 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id jB7McYOl008340
	for linux-ide@vger.kernel.org; Wed, 7 Dec 2005 22:38:34 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Been polishing up the new libata driver and found some more apparent
errors in the drivers/ide/pci one.

- Original PIIX is in the PCI table but the driver plays with and
assumes that slave timing registers and control bits are available. On
the PIIX they are not. You have only one timing set and the bits for
seperate slave timing are reserved.

- On pre UDMA chips it writes to the register space that later chips use
for UDMA enable, even though it isn't used for that on the older devices

- On pre ICH chips it writes to the clock selection register even though
it is not actually there.


Alan

