From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Serial ATA SIS 964
Date: Mon, 23 Feb 2004 11:20:02 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1077531578.681.21.camel@uk2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:15341 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261903AbUBWKTf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2004 05:19:35 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

i have written a driver for the SIS 180 Controller (included into SIS964
Southbridge), Motherboard is K7S8XE+.
The Driver is libata-based, running under Kernel 2.6.3

The driver works with programmed IO without problems.
My Problem:
The busmuster dma does not works. I think i must do some special
initialization like the SIS 5513 driver, but i dont have any information
about this chip.

any idea?

with best regards

Uwe Koziolek





