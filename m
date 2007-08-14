From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Tue, 14 Aug 2007 19:11:17 +0900
Message-ID: <46C17FC5.8090605@gmail.com>
References: <200708132005.14697.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:52341 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758069AbXHNKLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 06:11:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2137708wah
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 03:11:30 -0700 (PDT)
In-Reply-To: <200708132005.14697.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-ide@vger.kernel.org

Frans Pop wrote:
> Hi,
> 
> I've been running 2.6.23-rc2 without problems. Today I compiled 2.6.23-rc3
> and shortly after boot got the following messages in my logs:
> 
> kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x7ffc7 FIS=005040a1:00000020
> kernel: ata1.00: cmd 61/30:00:73:96:db/00:00:04:00:00/40 tag 0 cdb 0x0 data 24576 out
> kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> [...]
> kernel: ata1: soft resetting port
> kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> kernel: ata1.00: configured for UDMA/133
> kernel: ata1: EH complete
> kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> kernel: sd 0:0:0:0: [sda] Write Protect is off
> kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> A grep in the logs shows that the first error has never occurred before.
> I was doing nothing special at the time (SVN checkout, not even running X).
> 
> Full kern.log for that boot and lsmod attached.
> My system is Debian unstable with 2.6.23 built from Linus' git tree.

How reproducible is the problem?

-- 
tejun
