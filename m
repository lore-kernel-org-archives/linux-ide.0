From: Marc MERLIN <marc@merlins.org>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Tue, 2 Oct 2007 19:28:57 -0700
Message-ID: <20071003022857.GA19430@merlins.org>
References: <20071002170445.GB2902@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:41976 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbXJCC27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 22:28:59 -0400
Content-Disposition: inline
In-Reply-To: <20071002170445.GB2902@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

On Tue, Oct 02, 2007 at 10:04:45AM -0700, Marc MERLIN wrote:
> Howdy,
> 
> I've had a system with 2.6.22.1 for a while, running 10 drives
> behind a PMP on a sil24 card with no problems.
> 
> Recently, I swapped 5 250GB drives with 5 TB drives.
> The 5 TB drives eventually get detected, but do not work reliably.
> 
> Details are below.
> 
> This is all on 2.6.22.1-libata-tj-20070803. 
> I noticed that 20070808 is out, but it says it fixed NCQ over PMP,
> and NCQ was working fine with my 500GB drives, so I'm not sure it's that.

I tried with 20070808. Boot was better, so it seems to have helped.
I guess the NCQ fix was relevant for my TB drives but not needed for the 500GB ones.

I still got this when the array was built, but it didn't seem to prevent it from
being built and from working:

ata3.04: exception Emask 0x0 SAct 0xff SErr 0x0 action 0x2 frozen
ata3.04: cmd 61/c0:00:7f:94:04/00:00:71:00:00/40 tag 0 cdb 0x0 data 98304 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/00:08:3f:95:04/01:00:71:00:00/40 tag 1 cdb 0x0 data 131072 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/08:10:77:94:04/00:00:71:00:00/40 tag 2 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/90:18:3f:96:04/00:00:71:00:00/40 tag 3 cdb 0x0 data 73728 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/20:20:57:93:04/01:00:71:00:00/40 tag 4 cdb 0x0 data 147456 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/70:28:cf:96:04/00:00:71:00:00/40 tag 5 cdb 0x0 data 57344 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/00:30:3f:97:04/01:00:71:00:00/40 tag 6 cdb 0x0 data 131072 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/20:38:3f:98:04/01:00:71:00:00/40 tag 7 cdb 0x0 data 147456 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link
ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.01: hard resetting link
ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.02: hard resetting link
ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.03: hard resetting link
ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.04: hard resetting link
ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3.01: configured for UDMA/100
ata3.02: configured for UDMA/100
ata3.03: configured for UDMA/100
ata3.04: configured for UDMA/100
ata3: EH complete
sd 3:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:1:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:1:0:0: [sdd] Write Protect is off
sd 3:1:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:2:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:2:0:0: [sde] Write Protect is off
sd 3:2:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:3:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:3:0:0: [sdf] Write Protect is off
sd 3:3:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:4:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:4:0:0: [sdg] Write Protect is off
sd 3:4:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:1:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:1:0:0: [sdd] Write Protect is off
sd 3:1:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:2:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:2:0:0: [sde] Write Protect is off
sd 3:2:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:3:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:3:0:0: [sdf] Write Protect is off
sd 3:3:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:4:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:4:0:0: [sdg] Write Protect is off
sd 3:4:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
