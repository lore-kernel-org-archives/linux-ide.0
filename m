From: Tejun Heo <tj@kernel.org>
Subject: Re: Problems with Silicon Image Port Multiplier Card
Date: Mon, 09 Nov 2009 23:57:09 +0900
Message-ID: <4AF82DC5.50900@kernel.org>
References: <4AF0A1FC.4030106@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54796 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055AbZKIO5J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 09:57:09 -0500
In-Reply-To: <4AF0A1FC.4030106@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

Hello,

Peter Klotz wrote:
> [  622.549794] pciehp 0000:00:1c.2:pcie04: Card present on Slot(0)
> [  622.698856] sata_sil24 0000:03:00.0: enabling device (0100 -> 0103)
> [  622.698873] sata_sil24 0000:03:00.0: PCI INT A -> GSI 18 (level, low)
> -> IRQ 18
> [  622.702334] scsi8 : sata_sil24
> [  622.709268] scsi9 : sata_sil24
> [  622.709409] ata7: SATA max UDMA/100 host m128@0xfd804000 port
> 0xfd800000 irq 18
> [  622.709418] ata8: SATA max UDMA/100 host m128@0xfd804000 port
> 0xfd802000 irq 18
> [  624.800150] ata7: SATA link down (SStatus 0 SControl 0)
> [  626.890131] ata8: SATA link down (SStatus 0 SControl 0)
> 
> 
> Turning on the external box results in lots of errors:
> 
> [  666.030153] ata8: hard resetting link
> [  668.250125] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [  668.250949] ata8.15: Port Multiplier 1.1, 0x1095:0x5744 r33, 3 ports,
> feat 0x1/0x9
> [  668.251251] ata8.15: applying bridge limits
> [  668.251340] ata8.00: hard resetting link
> [  668.720140] ata8.00: failed to read SCR 0 (Emask=0x40)
> [  668.720156] ata8.15: hard resetting link
> [  668.720161] ata8: controller in dubious state, performing PORT_RST
> [  670.980112] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [  673.250164] ata8.00: hard resetting link
> [  673.720114] ata8.00: failed to read SCR 0 (Emask=0x1)

Early 5744 firmwares behaved pretty good but for some reason recent
ones are very peculiar.  Emask=0x40 is happening probably because 5744
is blinking the link between reset completion and SCR accesses.
Emask=0x1 means that 5744 simply failed the read request.  I'm not
quite sure what to do about them at this point.  I'll ask around.  :-(

Thanks.

-- 
tejun
