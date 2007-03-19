From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 09:31:04 -0700
Message-ID: <20070319093104.0f38ed2e@freebird>
References: <20070319075321.444c241e@freebird>
	<45FEA5D1.20101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40753 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030351AbXCSQcg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 12:32:36 -0400
In-Reply-To: <45FEA5D1.20101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Mon, 19 Mar 2007 11:01:37 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephen Hemminger wrote:
> > This is a new drive, so I suspect some driver incompatibility between the
> > driver (AHCI) and the hard drive (WD Raptor 10K 74G).
> 
> Driver incompatibilities between the driver (LLDD or libata-core) and a 
> hard drive are extremely rare.
> 
> The most common problem on modern SATA drives is drive firmware bugs, at 
> the moment.
> 
> 
> > [  841.645699] ata1.00: exception Emask 0x10 SAct 0x2 SErr 0x400100 action 0x2 frozen
> > [  841.645708] ata1.00: (irq_stat 0x08000000, interface fatal error)
> > [  841.645719] ata1.00: cmd 61/00:08:17:31:f1/04:00:03:00:00/40 tag 1 cdb 0x0 data 524288 out
> > [  841.645721]          res 40/00:18:5f:fa:b9/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> > [  841.947855] ata1: soft resetting port
> > [  842.447515] ata1: softreset failed (1st FIS failed)
> > [  842.447526] ata1: softreset failed, retrying in 5 secs
> > [  847.445028] ata1: hard resetting port
> > [  854.938851] ata1: port is slow to respond, please be patient (Status 0x80)
> > [  877.923808] ata1: port failed to respond (30 secs, Status 0x80)
> > [  877.923816] ata1: COMRESET failed (device not ready)
> > [  877.923822] ata1: hardreset failed, retrying in 5 secs
> > [  882.921328] ata1: hard resetting port
> > [  883.377028] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [  883.391971] ata1.00: configured for UDMA/133
> > [  883.391992] ata1: EH complete
> > [  883.392186] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
> > [  883.392381] sda: Write Protect is off
> > [  883.392387] sda: Mode Sense: 00 3a 00 00
> > [  883.392594] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > [  970.422983] ata1.00: exception Emask 0x10 SAct 0x7 SErr 0x400100 action 0x2 frozen
> > [  970.422993] ata1.00: (irq_stat 0x08000000, interface fatal error)
> > [  970.423005] ata1.00: cmd 61/a8:00:0f:1d:cb/02:00:01:00:00/40 tag 0 cdb 0x0 data 348160 out
> > [  970.423008]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> > [  970.423018] ata1.00: cmd 61/a8:08:bf:24:cb/00:00:01:00:00/40 tag 1 cdb 0x0 data 86016 out
> > [  970.423021]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> > [  970.423031] ata1.00: cmd 61/08:10:97:41:c5/00:00:03:00:00/40 tag 2 cdb 0x0 data 4096 out
> > [  970.423034]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> 
> The PHY is crapping itself.  The port headers may be damaged on the 
> drive or motherboard, or (most likely) you need a new cable.  SATA 
> cables in particular are known to be lame.
> 
> Try different ports and cables.
> 
> You can also see what happens if you disable NCQ 
> (http://linux-ata.org/faq.html#ncq).  Though given the interface errors, 
> if disabling NCQ solves problems, it /may/ just be that you slowed 
> things down enough to work, not that the drive firmware is bad.
>

Switched ports and cables and get these errors (looks the same):

[ 1903.410837] ata3.00: exception Emask 0x10 SAct 0x2 SErr 0x400100 action 0x2 frozen
[ 1903.410848] ata3.00: (irq_stat 0x08000000, interface fatal error)
[ 1903.410861] ata3.00: cmd 61/a0:08:e7:40:f3/03:00:03:00:00/40 tag 1 cdb 0x0 data 475136 out
[ 1903.410863]          res 40/00:08:e7:40:f3/00:00:03:00:00/40 Emask 0x10 (ATA bus error)
[ 1903.713203] ata3: soft resetting port
[ 1904.212843] ata3: softreset failed (1st FIS failed)
[ 1904.212851] ata3: softreset failed, retrying in 5 secs
[ 1909.210271] ata3: hard resetting port
[ 1916.702946] ata3: port is slow to respond, please be patient (Status 0x80)
[ 1939.687476] ata3: port failed to respond (30 secs, Status 0x80)
[ 1939.687483] ata3: COMRESET failed (device not ready)
[ 1939.687490] ata3: hardreset failed, retrying in 5 secs
[ 1944.684903] ata3: hard resetting port
[ 1945.140596] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1945.155581] ata3.00: configured for UDMA/133
[ 1945.155596] ata3: EH complete
[ 1945.155794] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[ 1945.155989] sda: Write Protect is off
[ 1945.155995] sda: Mode Sense: 00 3a 00 00
[ 1945.156231] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2020.315838] ata3.00: qc timeout (cmd 0x2f)
[ 2020.315847] ata3: failed to read log page 10h (errno=-5)
[ 2020.315859] ata3.00: exception Emask 0x1 SAct 0xf SErr 0x0 action 0x2 frozen
[ 2020.315863] ata3.00: (irq_stat 0x40000008)
[ 2020.315873] ata3.00: cmd 61/00:00:5f:7a:f3/02:00:03:00:00/40 tag 0 cdb 0x0 data 262144 out
[ 2020.315878]          res 40/00:08:5f:7e:f3/00:00:03:00:00/40 Emask 0x1 (device error)
[ 2020.315891] ata3.00: cmd 61/e0:08:5f:7e:f3/01:00:03:00:00/40 tag 1 cdb 0x0 data 245760 out
[ 2020.315896]          res 40/00:08:5f:7e:f3/00:00:03:00:00/40 Emask 0x1 (device error)
[ 2020.315908] ata3.00: cmd 61/80:10:3f:83:f3/00:00:03:00:00/40 tag 2 cdb 0x0 data 65536 out
[ 2020.315913]          res 40/00:08:5f:7e:f3/00:00:03:00:00/40 Emask 0x1 (device error)
[ 2020.315925] ata3.00: cmd 61/00:18:c7:83:f3/04:00:03:00:00/40 tag 3 cdb 0x0 data 524288 out
[ 2020.315930]          res 40/00:08:5f:7e:f3/00:00:03:00:00/40 Emask 0x1 (device error)
[ 2020.618605] ata3: soft resetting port
[ 2020.773508] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2020.788490] ata3.00: configured for UDMA/133
[ 2020.788502] ata3: EH pending after completion, repeating EH (cnt=4)
[ 2020.788513] ata3: exception Emask 0x1 SAct 0x0 SErr 0x0 action 0x1
[ 2020.788519] ata3: (irq_stat 0x40000001)
[ 2020.804222] ata3.00: configured for UDMA/133
[ 2020.804240] ata3: EH complete
[ 2020.804453] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[ 2020.804657] sda: Write Protect is off
[ 2020.804663] sda: Mode Sense: 00 3a 00 00
[ 2020.804870] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2020.805107] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[ 2020.805276] sda: Write Protect is off
[ 2020.805281] sda: Mode Sense: 00 3a 00 00
[ 2020.805494] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2025.458771] ata3.00: exception Emask 0x10 SAct 0xc SErr 0x400100 action 0x2 frozen
[ 2025.458781] ata3.00: (irq_stat 0x08000000, interface fatal error)
[ 2025.458793] ata3.00: cmd 61/00:10:c7:f2:f3/04:00:03:00:00/40 tag 2 cdb 0x0 data 524288 out
[ 2025.458796]          res 40/00:18:c7:f6:f3/00:00:03:00:00/40 Emask 0x10 (ATA bus error)
[ 2025.458809] ata3.00: cmd 61/00:18:c7:f6:f3/04:00:03:00:00/40 tag 3 cdb 0x0 data 524288 out
[ 2025.458814]          res 40/00:18:c7:f6:f3/00:00:03:00:00/40 Emask 0x10 (ATA bus error)
[ 2025.760930] ata3: soft resetting port
[ 2026.260583] ata3: softreset failed (1st FIS failed)
[ 2026.260592] ata3: softreset failed, retrying in 5 secs
[ 2031.258000] ata3: hard resetting port
[ 2038.749670] ata3: port is slow to respond, please be patient (Status 0x80)
[ 2061.734216] ata3: port failed to respond (30 secs, Status 0x80)
[ 2061.734223] ata3: COMRESET failed (device not ready)
[ 2061.734229] ata3: hardreset failed, retrying in 5 secs
[ 2066.731632] ata3: hard resetting port
[ 2067.187333] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2067.202311] ata3.00: configured for UDMA/133
[ 2067.202327] ata3: EH complete
[ 2067.202528] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[ 2067.202720] sda: Write Protect is off
[ 2067.202726] sda: Mode Sense: 00 3a 00 00
[ 2067.202931] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 
