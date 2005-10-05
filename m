From: Ian Leonard <ian@smallworld.cx>
Subject: Promise SATA controller TX4
Date: Wed, 05 Oct 2005 14:10:58 +0100
Message-ID: <4343D0E2.7080409@smallworld.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:44850 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965162AbVJENLC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 09:11:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

I have a new Promise Sata controller, marked as a SATA 300iiTX4 with a 
PDC40718-GP chip. It's a 4 port controller. I was unable to load 
sata_promise.o, so modified the driver id list as:

PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, 0, 0, board_20319

The then module loads and identifies my drive. However, many scsi errors 
(error=0x04 {DriverStatusError} and status=0x51 {DriveReady SeekComplete 
Error}) follow.

Kernel version is 2.4.32-rc1.


If you would like to support this card and I can be of any help, please 
let me know.

-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
