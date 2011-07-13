From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Wed, 13 Jul 2011 16:23:27 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org> <20110713143936.GQ2872@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh481-a.smtproutes.com ([208.70.89.235]:60719 "EHLO
	cal3-mh481-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755811Ab1GMQXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jul 2011 12:23:42 -0400
In-Reply-To: <20110713143936.GQ2872@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi:

Here is the result after the patch of hotplugging WD 3TB drive (only drive):

[   92.201163] ata1.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[   92.210719] ata1.02: SError: { PHYRdyChg CommWake DevExch }
[   92.220365] ata1.02: hard resetting link
[   92.980398] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   92.980449] ata1.02: issuing IDENTIFY
[   92.980476] ata1.02: IDENTIFY failed, irq_stat=0x60002 cerr=4
[   92.980517] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[   92.980526] ata1.15: hard resetting link
[   95.200045] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   95.200327] ata1.00: hard resetting link
[   95.640059] ata1.00: link resume succeeded after 1 retries
[   95.760404] ata1.00: SATA link down (SStatus 0 SControl 310)
[   95.760481] ata1.01: hard resetting link
[   96.110392] ata1.01: SATA link down (SStatus 0 SControl 320)
[   97.980042] ata1.02: hard resetting link
[   98.330391] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   98.330437] ata1.03: hard resetting link
[   98.680386] ata1.03: SATA link down (SStatus 0 SControl 320)
[   98.680461] ata1.04: hard resetting link
[   99.030393] ata1.04: SATA link down (SStatus 0 SControl 320)
[   99.030468] ata1.05: hard resetting link
[   99.390388] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   99.390438] ata1.02: issuing IDENTIFY
[   99.390464] ata1.02: IDENTIFY failed, irq_stat=0x60002 cerr=4
[   99.390506] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[   99.390515] ata1.15: hard resetting link
[  101.610048] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  101.610325] ata1.00: hard resetting link
[  102.050070] ata1.00: link resume succeeded after 1 retries
[  102.170389] ata1.00: SATA link down (SStatus 0 SControl 310)
[  102.170466] ata1.01: hard resetting link
[  102.520390] ata1.01: SATA link down (SStatus 0 SControl 320)
[  103.330025] ata1.02: hard resetting link
[  103.680391] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  104.390026] ata1.05: hard resetting link
[  104.740391] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  104.740442] ata1.02: issuing IDENTIFY
[  104.740468] ata1.02: IDENTIFY failed, irq_stat=0x60002 cerr=4
[  104.740510] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  104.740518] ata1.15: hard resetting link
[  106.960046] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  106.960329] ata1.00: hard resetting link
[  107.400059] ata1.00: link resume succeeded after 1 retries
[  107.520397] ata1.00: SATA link down (SStatus 0 SControl 310)
[  107.520472] ata1.01: hard resetting link
[  107.870392] ata1.01: SATA link down (SStatus 0 SControl 320)
[  108.680021] ata1.02: hard resetting link
[  109.030393] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  109.030439] ata1.03: hard resetting link
[  109.380397] ata1.03: SATA link down (SStatus 0 SControl 320)
[  109.380473] ata1.04: hard resetting link
[  109.730395] ata1.04: SATA link down (SStatus 0 SControl 320)
[  109.741269] ata1.05: hard resetting link
[  110.090393] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  110.090443] ata1.02: issuing IDENTIFY
[  110.118499] ata1.02: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
[  110.118506] ata1.02: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  110.118642] ata1.02: issuing IDENTIFY
[  110.123817] ata1.02: configured for UDMA/100
[  110.123904] ata1: EH complete
[  110.124108] scsi 0:2:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
[  110.124554] sd 0:2:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  110.124578] sd 0:2:0:0: Attached scsi generic sg0 type 0
[  110.124596] sd 0:2:0:0: [sda] 4096-byte physical blocks
[  110.124735] sd 0:2:0:0: [sda] Write Protect is off
[  110.124742] sd 0:2:0:0: [sda] Mode Sense: 00 3a 00 00
[  110.124813] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  110.125220]  sda: sda1 sda2
[  110.170313] sd 0:2:0:0: [sda] Attached SCSI disk
[  110.172439] ata1.02: issuing IDENTIFY
[  110.250997] ata1.02: issuing IDENTIFY
[  110.274885] ata1.02: issuing IDENTIFY

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of tj@kernel.org
> Sent: Wednesday, July 13, 2011 7:40 AM
> To: Derry Bryson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> Hello, again.
> 
> On Wed, Jul 13, 2011 at 03:34:25PM +0200, tj@kernel.org wrote:
> > I see.  Yeah, it doesn't seem to be PHY flickering.  It looks like
> > IDENTIFY is failing before disk finishes spinning up, which isn't the
> > correct behavior.  SRST is supposed to wait for disk spin up
> > completion.  I don't know why sil24 softreset is failing without
> > waiting for spinup.  I'll see whether I can reproduce the problem
> > here.
> 
> I played with it a bit but couldn't reproduce the problem; however,
> PMP EH does lack per-device retry back-off.  On host ports, when
> reset/identification fails for whatever reason, retry is backed off
> such that even if controller/device interaction is faulty during spin
> up, EH always retries after sufficient time is given to the device.
> With PMP EH, this logic is missing partly because PMP EH sometimes
> already takes too long and partly because tracking the timestamps
> seemed a bit complex during the initial implementation.
> 
> So, this definitely contributes to why PMP EH fails to work around the
> misinteraction between the drive and port and should probably be
> improved, but let's also find out why the controller isn't waiting for
> the drive after issuing IDENTIFY.  Can you please apply the following
> patch, reproduce the problem and report the kernel log?
> 
> Thank you.
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 06c564e..cbd3475 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -896,6 +896,9 @@ static unsigned int sil24_qc_issue(struct
> ata_queued_cmd *qc)
>  	dma_addr_t paddr;
>  	void __iomem *activate;
> 
> +	if (qc->tf.command == ATA_CMD_ID_ATA)
> +		ata_dev_printk(qc->dev, KERN_INFO, "issuing IDENTIFY\n");
> +
>  	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
>  	activate = port + PORT_CMD_ACTIVATE + tag * 8;
> 
> @@ -1081,9 +1084,12 @@ static void sil24_error_intr(struct ata_port
> *ap)
>  		}
> 
>  		/* record error info */
> -		if (qc)
> +		if (qc) {
> +			if (qc->tf.command == ATA_CMD_ID_ATA)
> +				ata_dev_printk(qc->dev, KERN_INFO, "IDENTIFY
> failed, irq_stat=%#0x cerr=%u\n",
> +					       irq_stat, cerr);
>  			qc->err_mask |= err_mask;
> -		else
> +		} else
>  			ehi->err_mask |= err_mask;
> 
>  		ehi->action |= action;
> 
> 
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 10.0.1390 / Virus Database: 1516/3761 - Release Date: 07/12/11


Derry Bryson
Sr. Software Engineer 

Highly Reliable Systems
www.High-Rely.com
"Making Backup Invisible"

Phone: 775.329.5139 X129
Fax:     775.370.1001

Sales & Support: 877.384.6838

This e-mail and any files transmitted with it are the property of Highly Reliable Systems, Inc. This (email) information is confidential, and is intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender and delete this message immediately from your computer. Any other use, disclosure, retention, dissemination, forwarding, printing, distribution or copying of this e-mail is strictly prohibited.




