From: Russell Howe <rhowe@wiss.co.uk>
Subject: Poor IDE cable causing a kernel lockup (PIIX)?
Date: Tue, 23 Mar 2004 22:37:36 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040323223735.GA30677@xiao.rsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.nildram.co.uk ([195.112.4.54]:41988 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S262890AbUCWWlZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2004 17:41:25 -0500
Received: from doufu (doufu.siksai.co.uk [82.133.8.9])
	by smtp.nildram.co.uk (Postfix) with ESMTP id D3E7D250687
	for <linux-ide@vger.kernel.org>; Tue, 23 Mar 2004 22:37:32 +0000 (GMT)
Received: from xiao.rsnet ([192.168.1.2] ident=mail)
	by doufu with esmtp (Exim 4.30)
	id 1B5uWe-0007zh-EZ
	for linux-ide@vger.kernel.org; Tue, 23 Mar 2004 22:37:36 +0000
Received: from rhowe by xiao.rsnet with local (Exim 3.36 #1 (Debian))
	id 1B5uWe-0007z3-00
	for <linux-ide@vger.kernel.org>; Tue, 23 Mar 2004 22:37:36 +0000
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Before you go and read all of the following, I should probably
ask: Is the kernel/IDE driver expected to cope with CRC errors caused
by what appears to be bad cabling?

After getting a few (~70) entries like the following from the kernel,
the NMI watchdog takes over and locks the system up with a backtrace:

Mar 17 20:54:12 xiao kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Mar 17 20:54:12 xiao kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

I'm quite willing to blame the rather long, rounded cable this drive is
attached to (although no complaints about hdd, also on the same cable)

The drive itself is a Seagate:
hdc: ST380021A, ATA DISK drive

The controller is the onboard 440BX on an Abit BP6, running two Celeron
300A's with all clock speeds set to what they should be.

A copy of the bootup log is at:
http://siksai.co.uk/~rhowe/bootup.txt

Output of smartctl -a /dev/hdc is at:
http://siksai.co.uk/~rhowe/smart-hdc.txt

(currently running a SMART self test to see if the drive thinks it has
problems)

I have two slightly different kernel traces which I had to copy down
onto paper, so if they will be of any use, I can type them in. I'll be
hooking this box up with a serial console pretty soon, although I'll
need a new kernel build for that (note the broken serial support :)

The machine is just my home NFS server, so reboots and new kernels
aren't a problem.

-- 
Russell Howe     | Why be just another cog in the machine,
rhowe@wiss.co.uk | when you can be the spanner in the works?
