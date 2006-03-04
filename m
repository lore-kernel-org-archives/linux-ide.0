From: Glenn English <ghe@slsware.com>
Subject: terminal SATA troubles
Date: Sat, 4 Mar 2006 13:46:18 -0700
Message-ID: <200603041346.18449.ghe@slsware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.slsware.com ([207.189.192.218]:52386 "EHLO
	server.slsware.dmz") by vger.kernel.org with ESMTP id S1752015AbWCDUq3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Mar 2006 15:46:29 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I see from the source that you are the maintainer of the Silicon Graphics SATA 
driver. I don't think my prob really has anything to do with that driver, but 
I'm hoping you might be able to answer a couple questions for me.

Situation:
Debian distro, 2.6.15 kernel, one P4 system, one AMD64

Problem:
These machines have a SCSI drive and a SATA. I want the SCSI to be the system 
drive and use the SATA for mass storage. My BIOS has the SCSI as the first in 
the list of bootable hard drives; grub installed on (hd0); the boot partition 
is #1 on the SCSI. Grub hits the SCSI for the initial stage, but when it goes 
to the line in menu.lst that says the kernel is on sda, sda is the SATA. 
Things degenerate quickly from there.

Is there an way to control the assignment in /dev? What is doing this? 

And most important, where in the source does this assignment happen, and where 
is it documented? I can read (English and C), but I can't find it (i've tried 
google and grep'ed the source as best I know how).

-- 
Glenn English
ghe@slsware.com
GPG ID: D0D7FF20
  
