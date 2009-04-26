From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Sun, 26 Apr 2009 11:00:28 +0900
Message-ID: <49F3C03C.1090803@kernel.org>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47026 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbZDZB7g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Apr 2009 21:59:36 -0400
In-Reply-To: <49F2E47C.5010803@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

Hello,

Thomas Jackowski wrote:
> some additional information (2.6.26-1) and ata_piix:
> [653158.828848] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
> 0x6 frozen
> [653158.828856] ata3.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
> [653158.828857]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)

Hmmm... that's timeout on CHECK POWER.

> [653158.828860] ata3.00: status: { DRDY }
> [653158.828868] ata3: hard resetting link
> [653159.331110] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [653159.355648] ata3.00: configured for UDMA/133
> [653159.355666] ata3: EH complete
> [653159.371885] sd 2:0:0:0: [sde] 1953523055 512-byte hardware sectors
> (1000204 MB)
> [653159.374081] sd 2:0:0:0: [sde] Write Protect is off
> [653159.374081] sd 2:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [653159.390212] sd 2:0:0:0: [sde] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> 
> I tried 2.6.29 and I had no outputs in kernel.log with AHCI and w/o NCQ.
> But my system still had hiccups (system hangs for a second) so I am not
> sure if there was just no output to kernel.log (due using debian
> unstable kernel with eventually mysterious options).
> 
> I will observe this and report if any error occurs again.

Thanks.

-- 
tejun
