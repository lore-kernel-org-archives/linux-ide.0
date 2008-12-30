From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: 2.6.28: Is there a way to disable sata probing for certain ports?
Date: Tue, 30 Dec 2008 07:24:47 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812300605250.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:35146 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbYL3MYs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 07:24:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

When I boot from an Intel X25-E SSD, it takes roughly a few seconds; 
however, items such as:

$ dmesg|grep link\ down
[    2.447030] ata4: SATA link down (SStatus 0 SControl 300)
[    4.481288] ata5: SATA link down (SStatus 0 SControl 0)
[    6.501288] ata6: SATA link down (SStatus 0 SControl 0)
[    8.522038] ata7: SATA link down (SStatus 0 SControl 0)
[   10.552288] ata8: SATA link down (SStatus 0 SControl 0)

Scanning for devices on channels that have nothing connected adds to the 
boot time, is there anyway to turn off/disable scanning for certain ports 
to help speed the boot process?


