From: Lars Michael Jogback <lm@jogback.se>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Mon, 10 Nov 2008 19:26:28 +0100
Message-ID: <20081110182628.GA6281@cleopatra.jogback.se>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se> <49056F2C.20101@kernel.org> <49056FEA.4070405@kernel.org> <20081027194038.GA7004@cleopatra.jogback.se> <4917D8F6.4020305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:38457 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941AbYKJSd3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 13:33:29 -0500
Content-Disposition: inline
In-Reply-To: <4917D8F6.4020305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

* Tejun Heo <tj@kernel.org> [2008-11-10 15:47:18]:

> Lars Michael Jogback wrote:
> > * Tejun Heo <tj@kernel.org> [2008-10-27 16:38:18]:
> > 
> >> Oh.. one more thing.  Can you please try the attached patch and post the
> >> failing log?
> > 
> > Yank the drive:
> > [  423.185630] ata7: XXX error_intr irq_stat=0x8040800
> > [  423.200853] ata7.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
> > [  423.200930] ata7: SError: { PHYRdyChg CommWake DevExch }
> 
> I bought harddrive of the same generation but of lower capacity and
> tested it with two 3726s but can't reproduce the problem you're
> seeing.  :-(

Bummer.

> Can you please try the attached patch and see whether anything is
> different?
> 

Yes, it made it working.

[  158.852022] ata7.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  158.852135] ata7: SError: { PHYRdyChg CommWake DevExch }
[  158.852456] ata7.02: hard resetting link
[  160.095980] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  160.111927] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  160.112034] ata7.15: hard resetting link
[  162.240274] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  162.241087] ata7.00: hard resetting link
[  163.080382] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  163.080490] ata7.01: hard resetting link
[  163.920030] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  163.920137] ata7.02: hard resetting link
[  164.759924] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  164.760031] ata7.03: hard resetting link
[  165.599951] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  165.600057] ata7.04: hard resetting link
[  166.440288] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  166.440395] ata7.05: hard resetting link
[  167.280368] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  167.314762] ata7.00: configured for UDMA/100
[  167.327704] ata7.01: configured for UDMA/100
[  167.342455] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  167.342705] ata7.15: hard resetting link
[  169.472805] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  169.473169] ata7.00: hard resetting link
[  170.312834] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  170.312941] ata7.01: hard resetting link
[  171.152772] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  171.152879] ata7.02: hard resetting link
[  171.993505] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  171.993622] ata7.03: hard resetting link
[  172.834758] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  172.834865] ata7.04: hard resetting link
[  173.675984] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  173.676109] ata7.05: hard resetting link
[  174.517356] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  174.530205] ata7.00: configured for UDMA/100
[  174.543188] ata7.01: configured for UDMA/100
[  174.549525] ata7.02: FORCE: horkage modified (noncq)
[  174.549751] ata7.02: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[  174.549860] ata7.02: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[  174.556383] ata7.02: configured for UDMA/100
[  174.569329] ata7.03: configured for UDMA/100
[  174.582199] ata7.04: configured for UDMA/100
[  174.597407] ata7: EH complete

You don't think it has something todo with the spin-up time?

The spin-up time on these disks is quite long:
smartctl -a /dev/sdn | grep Spin_Up_Time
  3 Spin_Up_Time            0x0007   068   068   011    Pre-fail  Always       -       10240

Best Regards,
/LM

