From: Tejun Heo <tj@kernel.org>
Subject: Re: JMicron Technology JMB362 JMB363 SError: { DevExch }
 ExpressCard, sometimes fails to boot
Date: Sun, 30 Oct 2011 14:12:40 -0700
Message-ID: <20111030211240.GE7696@google.com>
References: <4E930916.6050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34774 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab1J3VMq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2011 17:12:46 -0400
Received: by ywf7 with SMTP id 7so433329ywf.19
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2011 14:12:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E930916.6050503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Orson <orson.wellies@gmail.com>
Cc: linux-ide@vger.kernel.org, arieslee@jmicron.com

Hello,

(cc'ing Aries of jmicron)

On Mon, Oct 10, 2011 at 06:02:46PM +0300, Orson wrote:
> I tried my xpress54 card JMB362/363 on Debian Wheezy testing, with
> kernel 3.0.0-1-amd64 (Debian 3.0.0.-3).
> 
> The card was inserted into the express slot without any external
> disk attached and I experienced the same problems I had been having
> with debian squeeze, perhaps even more consistently.
> 
> I am now only using single port JMB 360 cards which operate flawlessly.
> 
> I am attaching a kernel log with the said card inserted.

Hmmm.... it looks like the controller is continuously raising
connection status changed state and libata is faithfully trying to
probe whether new device appeared on the port.  Does it work if you
plug an actual hard drive into the port?  Looks more like wrong wiring
than anything else.  Aries, any ideas?

 ahci 0000:10:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
 ahci 0000:10:00.0: flags: 64bit ncq pm led clo pmp pio slum part
 ahci 0000:10:00.0: setting latency timer to 64
 scsi1 : ahci
 ata1: SATA max UDMA/133 abar m8192@0xd0000000 port 0xd0000100 irq 16
 ata2: SATA max UDMA/133 abar m8192@0xd0000000 port 0xd0000180 irq 16
 ata1: SATA link down (SStatus 0 SControOct  9 23:45:46 hp-laptop kernel: [    1.414084] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
 ata1: irq_stat 0x00000040, connection status changed
 ata1: SError: { PHYInt CommWake DevExch }
 ata1: hard resetting link
 ata1: COMRESET failed (errno=-32)
 ata1: reset failed (errno=-32), retrying in 8 secs
 ata1: limiting SATA link speed to 1.5 Gbps
 ata1: hard resetting link
 ata1: SATA link down (SStatus 0 SControl 310)
 ata1: EH complete
 ata1: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
 ata1: irq_stat 0x00000040, connection status changed
 ata1: SError: { PHYInt CommWake DevExch }
 ata1: hard resetting link
 ata1: COMRESET failed (errno=-32)
 ata1: reset failed (errno=-32), retrying in 8 secs
 ata1: hard resetting link
 ata1: SATA link down (SStatus 0 SControl 310)
 ata1: EH complete
 ata1: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
 ata1: irq_stat 0x00000040, connection status changed
 ata1: SError: { PHYInt CommWake DevExch }
 ata1: limiting SATA link speed to 1.5 Gbps
 ata1: hard resetting link
 ata1: SATA link down (SStatus 0 SControl 310)
 ata1: EH complete
 ata1: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
 ata1: irq_stat 0x00000040, connection status changed
 ata1: SError: { PHYInt CommWake DevExch }
 ata1: limiting SATA link speed to 1.5 Gbps
 ata1: hard resetting link
 ata1: SATA link down (SStatus 0 SControl 310)
 ata1: EH complete
 ata1: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
 ata1: irq_stat 0x00000040, connection status changed
 ata1: SError: { PHYInt CommWake DevExch }
 ata1: limiting SATA link speed to 1.5 Gbps
 ata1: hard resetting link
 ata1: SATA link down (SStatus 0 SControl 310)
 ata1: EH complete
 (repeat...)

-- 
tejun
