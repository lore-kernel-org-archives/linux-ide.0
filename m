From: "Bradley Baetz" <bbaetz@acm.org>
Subject: Limiting SATA port speed to 1.5Gbs
Date: Mon, 13 Nov 2006 23:30:29 +1100
Message-ID: <99435f5b0611130430q67127d40ndc93d107fa19ee55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:43041 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754550AbWKMMab (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 07:30:31 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1051499ugc
        for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 04:30:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got a bunch of SATA hotswap bays that don't seem to support
3.0Gbps properly. The symptom is that just doing a dd off the drive to
/dev/null, I get:

Nov 13 09:43:15 foo kernel: ata13: error interrupt on port0
Nov 13 09:43:15 foo kernel:   stat=0x80000001 irq=0x3020002 cmd_err=1
sstatus=0x123 serror=0x280000
Nov 13 09:43:15 foo kernel: ata13: translated ATA stat/err 0x51/84 to
SCSI SK/ASC/ASCQ 0xb/47/00
Nov 13 09:43:15 foo kernel: ata13: status=0x51 { DriveReady SeekComplete Error }
Nov 13 09:43:15 foo kernel: ata13: error=0x84 { DriveStatusError BadCRC }

in the logs, and READ DMA errors in the drive's SMART logs. I'm not
sure how they get to the SMART logs, but this happens under the latest
RHEL4 kernel, FC6, and also under windows XP, so its presumably not a
software issue.

Unfortunately we have a bunch of these, but until now they've been
used in internal bays on onboard controllers not supporting 3.0Gbps
and/or presenting the drives to the (windows) OS as PATA.

The Seagate drives have a jumper to limit the speed to 1.5Gb and that
seems to fix the problem, but I can't guarantee that future drives
will have a jumper for that. Is there some way to use a module param
to limit the port speeds to 1.5Gb? Looking at the code it looks like
the newer kernels will try to rate limit after an error, but I'd
rather force limit it up front. Is there a way to do this?

They're attached to a SiI 3124 PCI-X controller with infiniband output
to an external enclosure, using sata_sil24, FWIW.

Thanks,

Bradley
