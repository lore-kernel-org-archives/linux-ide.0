From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 14 Jul 2011 17:37:37 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh484-a.smtproutes.com ([208.70.89.247]:48586 "EHLO
	cal3-mh484-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932169Ab1GNRhv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jul 2011 13:37:51 -0400
In-Reply-To: <20110714071459.GB3455@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi:

Dmesg with second timing value set to 1000 always, hotplugging WD 3TB drive:

[  139.145917] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  139.156180] ata5.00: SError: { PHYRdyChg CommWake DevExch }
[  139.166619] ata5.00: hard resetting link
[  139.166639] ata5.00: XXXX hardreset hotplugged = true
[  139.166646] ata5.00: XXX0 hardreset debounce 25 500 2000
[  139.166651] ata5.00: XXX1 hardreset debounce 25 1000 2000
[  140.430401] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  140.430453] ata5.00: issuing IDENTIFY
[  140.430480] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
[  140.430521] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  140.430532] ata5.15: hard resetting link
[  142.650047] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  145.431276] ata5.00: hard resetting link
[  145.431298] ata5.00: XXXX hardreset hotplugged = false
[  145.431304] ata5.00: XXX0 hardreset debounce 5 100 2000
[  145.431310] ata5.00: XXX1 hardreset debounce 5 1000 2000
[  146.690413] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  146.690461] ata5.01: hard resetting link
[  146.690481] ata5.01: XXXX hardreset hotplugged = false
[  146.690487] ata5.01: XXX0 hardreset debounce 5 100 2000
[  146.690492] ata5.01: XXX1 hardreset debounce 5 1000 2000
[  147.940402] ata5.01: SATA link down (SStatus 0 SControl 320)
[  147.940481] ata5.02: hard resetting link
[  147.940501] ata5.02: XXXX hardreset hotplugged = false
[  147.940507] ata5.02: XXX0 hardreset debounce 5 100 2000
[  147.940513] ata5.02: XXX1 hardreset debounce 5 1000 2000
[  149.190398] ata5.02: SATA link down (SStatus 0 SControl 320)
[  149.190476] ata5.03: hard resetting link
[  149.190497] ata5.03: XXXX hardreset hotplugged = false
[  149.190503] ata5.03: XXX0 hardreset debounce 5 100 2000
[  149.190508] ata5.03: XXX1 hardreset debounce 5 1000 2000
[  150.440399] ata5.03: SATA link down (SStatus 0 SControl 320)
[  150.440478] ata5.04: hard resetting link
[  150.440499] ata5.04: XXXX hardreset hotplugged = false
[  150.440505] ata5.04: XXX0 hardreset debounce 5 100 2000
[  150.440510] ata5.04: XXX1 hardreset debounce 5 1000 2000
[  151.690410] ata5.04: SATA link down (SStatus 0 SControl 320)
[  151.690488] ata5.05: hard resetting link
[  151.690509] ata5.05: XXXX hardreset hotplugged = false
[  151.690515] ata5.05: XXX0 hardreset debounce 5 100 2000
[  151.690520] ata5.05: XXX1 hardreset debounce 5 1000 2000
[  152.940399] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  152.940451] ata5.00: issuing IDENTIFY
[  152.940477] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
[  152.940518] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  152.940529] ata5.15: hard resetting link
[  155.160047] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  155.160327] ata5.00: hard resetting link
[  155.160347] ata5.00: XXXX hardreset hotplugged = false
[  155.160353] ata5.00: XXX0 hardreset debounce 5 100 2000
[  155.160358] ata5.00: XXX1 hardreset debounce 5 1000 2000
[  156.410398] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  157.940026] ata5.05: hard resetting link
[  157.940048] ata5.05: XXXX hardreset hotplugged = false
[  157.940054] ata5.05: XXX0 hardreset debounce 5 100 2000
[  157.940059] ata5.05: XXX1 hardreset debounce 5 1000 2000
[  159.190398] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  159.190450] ata5.00: issuing IDENTIFY
[  159.199553] ata5.00: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
[  159.199560] ata5.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  159.199702] ata5.00: issuing IDENTIFY
[  159.205571] ata5.00: configured for UDMA/100
[  159.205661] ata5: EH complete
[  159.205857] scsi 4:0:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
[  159.206297] sd 4:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  159.206305] sd 4:0:0:0: [sdb] 4096-byte physical blocks
[  159.206319] sd 4:0:0:0: Attached scsi generic sg1 type 0
[  159.206440] sd 4:0:0:0: [sdb] Write Protect is off
[  159.206447] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  159.206519] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  159.206938]  sdb: sdb1 sdb2
[  159.251508] sd 4:0:0:0: [sdb] Attached SCSI disk
[  159.254218] ata5.00: issuing IDENTIFY
[  159.330233] ata5.00: issuing IDENTIFY
[  159.350570] ata5.00: issuing IDENTIFY

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of tj@kernel.org
> Sent: Thursday, July 14, 2011 12:15 AM
> To: Derry Bryson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> Hello,
> 
> On Wed, Jul 13, 2011 at 04:23:27PM +0000, Derry Bryson wrote:
> > [   92.980476] ata1.02: IDENTIFY failed, irq_stat=0x60002 cerr=4
> 
> The controller is saying that it failed to transmit command FIS
> because PHYRDY state changed, so that is PHY flickering.  Can you
> please bump the second debounce timing to 1000 (not only the first one
> but always) and see whether the failure pattern changes?
> 
> Thanks.
> 
> --
> tejun
> 

Derry Bryson
Sr. Software Engineer 

Highly Reliable Systems
www.High-Rely.com
"Making Backup Invisible"

Phone: 775.329.5139 X129
Fax:     775.370.1001

Sales & Support: 877.384.6838

This e-mail and any files transmitted with it are the property of Highly Reliable Systems, Inc. This (email) information is confidential, and is intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender and delete this message immediately from your computer. Any other use, disclosure, retention, dissemination, forwarding, printing, distribution or copying of this e-mail is strictly prohibited.




