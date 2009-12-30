From: Tim Small <tim@seoss.co.uk>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; pata_marvell
 fate?
Date: Wed, 30 Dec 2009 17:16:59 +0000
Message-ID: <4B3B8B0B.2080805@seoss.co.uk>
References: <20090417023949.GA14469@havoc.gtf.org> <loom.20091227T054252-842@post.gmane.org> <4B37D713.4070407@gmail.com> <4B37FB36.1040603@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:53434 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZL3SFi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Dec 2009 13:05:38 -0500
In-Reply-To: <4B37FB36.1040603@fastmail.fm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Raman Gupta wrote:
> However, note that I can make the "exception Emask 0x0 SAct 0x0 SErr 
> 0x0 action 0x6 frozen" happen even with the RAID array stopped and no 
> filesystems mounted. All I have to do is run the smartctl -a /dev/sdd 
> command (sdd is attached to the Marvell controller) repeatedly until 
> this exception occurs:
>
> Dec 27 18:59:30 x kernel: ata6.00: exception Emask 0x0 SAct 0x0 SErr 
> 0x0 action 0x6 frozen
> Dec 27 18:59:30 x kernel: ata6.00: cmd 
> ec/00:01:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
> Dec 27 18:59:30 x kernel:         res 
> 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
> Dec 27 18:59:30 x kernel: ata6.00: status: { DRDY }
> Dec 27 18:59:30 x kernel: ata6: hard resetting link
> Dec 27 18:59:30 x kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Dec 27 18:59:30 x kernel: ata6.00: configured for UDMA/133
> Dec 27 18:59:30 x kernel: ata6: EH complete
>
> Usually 10-15 executions is sufficient to replicate the issue.

Hmm.  I wonder what running this script from this bug:

http://bugzilla.kernel.org/show_bug.cgi?id=14831

against drives attached to other controllers would do?  It doesn't do 
anything particularly special - just runs smartctl in a loop while also 
writing to the same drive (via fs using dd).

Out of interest have you tried drives from other manufacturers?  Would 
also be interested to see what happens if you run the script against the 
same drive, but attached to the ICH7?

Cheers,

Tim.
