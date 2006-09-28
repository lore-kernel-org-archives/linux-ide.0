From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCH] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 04:34:30 -0400
Message-ID: <20060928083430.GA18596@jim.sh>
References: <20060927082005.GA14569@jim.sh> <20060928051415.GG25800@htj.dyndns.org> <20060928062357.GA12266@jim.sh> <20060928080442.GJ25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:36540 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1751776AbWI1If3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 04:35:29 -0400
Content-Disposition: inline
In-Reply-To: <20060928080442.GJ25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mail@philipp-wagner.com, linux-ide@vger.kernel.org, jeff@garzik.org, justin@jmicron.com

Tejun Heo wrote:

> Jim, can you please test the following patch?  It only adds
> ATA_FLAG_HRST_TO_RESUME.

Yes, just ATA_FLAG_HRST_TO_RESUME also works fine:

Unplug:
[  220.354520] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
[  220.354591] ata3: hard resetting port
[  221.075828] ata3: SATA link down (SStatus 0 SControl 300)
[  221.075833] ata3: failed to recover some devices, retrying in 5 secs
[  226.080467] ata3: hard resetting port
[  226.804116] ata3: SATA link down (SStatus 0 SControl 300)
[  226.804121] ata3: failed to recover some devices, retrying in 5 secs
[  231.805716] ata3: hard resetting port
[  232.529366] ata3: SATA link down (SStatus 0 SControl 300)
[  232.529373] ata3.00: disabled
[  233.033123] ata3: EH pending after completion, repeating EH (cnt=4)
[  233.033133] ata3: EH complete
[  233.033141] ata3.00: detaching (SCSI 2:0:0:0)

Replug:
[  247.048727] ata3: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0x2 frozen
[  247.048798] ata3: hard resetting port
[  253.867127] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  253.867930] ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
[  253.868982] ata3.00: configured for UDMA/133
[  253.868986] ata3: EH pending after completion, repeating EH (cnt=4)
[  253.868994] ata3: EH complete
[  253.869342]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[  253.869351]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  253.869507] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[  253.869737] sdc: Write Protect is off
[  253.869740] sdc: Mode Sense: 00 3a 00 00
[  253.869931] SCSI device sdc: drive cache: write back
[  253.870082] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[  253.870189] sdc: Write Protect is off
[  253.870192] sdc: Mode Sense: 00 3a 00 00
[  253.870372] SCSI device sdc: drive cache: write back
[  253.870378]  sdc: sdc1
[  253.887285] sd 2:0:0:0: Attached scsi disk sdc

Thanks,
-jim

