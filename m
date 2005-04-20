From: "Laddie Michael C Zarsuelo/adtxp" <lzarsuelo@adtx.com.ph>
Subject: sending commands to the SATA drive
Date: Wed, 20 Apr 2005 09:13:22 +0800
Message-ID: <OFC848C2D3.F3F922F3-ON48256FE8.002B7BD9@adtx.com.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [203.177.98.119] ([203.177.98.119]:49416 "EHLO mail.adtx.com.ph")
	by vger.kernel.org with ESMTP id S261170AbVDTAq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2005 20:46:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Greetings!

I'm quite new to Linux and I need to create a monitoring program for our
SATA hdd's.  I have to be able to send smart status commands to the drive.
Is there a way to do this? I tried the HDIO_DRIVE_CMD in IOCTL but it wont
work.  Is there a library function header file that I can include in my
program so that I can access the libata functions and its variables?

regards,
Laddie Zarsuelo

