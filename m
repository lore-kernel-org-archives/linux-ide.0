From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: Intel 82801EB/82801ER SATA controller's Combined mode does not op
	erate
Date: Sun, 22 Aug 2004 09:09:47 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <7076215DFAA4574099E5CD59FE42226204F23275@pcssrv42.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:46740 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S266825AbUHVXqC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Aug 2004 19:46:02 -0400
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>

Dear Jeff,

It seems that combined mode does not operate at 2.4.28-pre1/2.6.8.1
about the ata_piix driver of the Intel 82801EB/82801ER SATA controller
of Intel 82801EB/82801ER.
Combined mode operated in the version 1.00 of ata_piix.
Is the driver for combine modes ata_piix? Or is it piix?
--
Haruo

