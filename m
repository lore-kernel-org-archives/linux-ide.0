From: Tejun Heo <tj@kernel.org>
Subject: Re: Kernel Bug in ATA or SMART area
Date: Sat, 20 Feb 2010 12:50:42 +0900
Message-ID: <4B7F5C12.5080201@kernel.org>
References: <4B72941A.7060704@gmx.de>	<4B74BDCF.1010805@kernel.org>	<4B74F263.1060709@gmx.de>	<4B7505CA.60409@kernel.org>	<4B75154B.8030507@gmx.de>	<4B7B548B.4040606@kernel.org>	<4B7C5696.7030609@gmx.de> <19325.7006.892019.748974@pilspetsen.it.uu.se> <4B7EDE2F.8030107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48527 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab0BTMIR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2010 07:08:17 -0500
In-Reply-To: <4B7EDE2F.8030107@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Uhl <axel.uhl@gmx.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 02/20/2010 03:53 AM, Axel Uhl wrote:
> I now enabled IO/APIC in my kernel. See attached .config. I also enabled
> pata_via but was unsure which IDE driver to disable. The kernel
> rebooted fine. The following appeared in my syslog when the smartctl
> command spinned up the disk:
> 
> Feb 19 18:57:09 homemp3 kernel: ata5.00: exception Emask 0x0 SAct 0x0
> SErr 0x0 action 0x6 frozen
> Feb 19 18:57:09 homemp3 kernel: ata5.00: failed command: SMART
> Feb 19 18:57:09 homemp3 kernel: ata5.00: cmd
> b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0
> Feb 19 18:57:09 homemp3 kernel:          res
> 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Feb 19 18:57:09 homemp3 kernel: ata5.00: status: { DRDY }
> Feb 19 18:57:09 homemp3 kernel: ata5: soft resetting link
> Feb 19 18:57:09 homemp3 kernel: ata5.00: configured for UDMA/133
> Feb 19 18:57:09 homemp3 kernel: ata5: EH complete
> 
> At least it seems that the kernel recovered better from this exception
> than before. In particular, IRQ10 didn't get disabled and so I/O
> continued to work fine. Thanks for the hint.

The SMART error isn't likely to be related to the nobody cared.
Neither is the switch to libata driver.  One possibility is that the
IRQ line is shared with yet another device which the corresponding
driver didn't take care of (there was an i2c controller raising
interrupt behind the driver's back).

> Would you consider the exception above a serious problem that should be
> taken care of somehow?

In itself, it's not dangerous at all although repeated occurrences
could be annoying.

Thanks.

-- 
tejun
