From: Marc Singer <elf@buici.com>
Subject: So, is there support for IDE devices that have no IRQ?
Date: Wed, 24 Mar 2004 15:29:05 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040324232905.GA11286@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:28576 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262193AbUCXX3H
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 18:29:07 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm getting the impression that there isn't.  I've got a system with
compact flash and no interrupt line to the device.  Setting the
hwif->irq value to -1 causes the kernel to crash, though there is a
IDE_NO_IRQ constant.  I'm good to make this work, but I want to make
sure that I'm heading in a reasonable direction.

The thing that's confusing me is that I'm not getting an ide0 device
even though I can see the code probing for drives.

Cheers.

