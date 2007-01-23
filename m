From: danieljzhang <danieljzhang@hotmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 23 Jan 2007 13:49:38 -0800 (PST)
Message-ID: <8550219.post@talk.nabble.com>
References: <200612111003.39928.kovid@theory.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.nabble.com ([72.21.53.35]:39845 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933171AbXAWWR6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jan 2007 17:17:58 -0500
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H9TWM-0003KL-Bh
	for linux-ide@vger.kernel.org; Tue, 23 Jan 2007 13:49:38 -0800
In-Reply-To: <200612111003.39928.kovid@theory.caltech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Need help to rebuild new kernel:
I dont know if this is the same problem. Please do help. 

I am trying to build kernel
linux-2.6.20-rc2

with patch
gregkh-all-2.6.20-rc2.patch

But system hanged when boot.

The original working kernel is: 2.6.13-15.13-smp. The distribution is SUSE.

According to YaST2, Disk is ST380013AS, Device Name is /dev/sda Driver is
ata_piix.

I used the original .config but add sata as module, usb as kernel build-in.

In /etc/sysconfig/kernel, I add ahci module. Right now INITRD_MODULES="ahci
piix ata_piix reiserfs processor thremal fan"

When booting, there is no FATAL error for loading module. I built in the USB
module as kernel. I still can get keyboard (USB keyboard). 

Then it shows:
"Waiting for device /dev/sda2 to appear: ........ resume device /dev/sda2
not found (ignoring)
Loading reiserfs
Waiting for device /dev/sda3 to appear: ..........not found -- exiting to
/bin/sh

I got shell promt "$" anyway. But just pwd cd works.

But I can not find solution after googling and bothering linux guy around.
Please help!

I was told that there is a new SATA driver that I need to build and load.
Anyone can kindly send me a link?

Help, please!
-- 
View this message in context: http://www.nabble.com/-2.6.18%2C19--SATA-boot-problems-%28ICH6-ICH6W%29-tf2795723.html#a8550219
Sent from the linux-ide mailing list archive at Nabble.com.

