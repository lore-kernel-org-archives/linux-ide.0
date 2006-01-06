From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: 06 Jan 2006 10:02:14 +0900
Message-ID: <87k6deyxrd.fsf@marrow.phys.tohoku.ac.jp>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de> <20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
	<20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
	<87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
	<20060104114222.25182742.randy_d_dunlap@linux.intel.com>
	<87aceag437.fsf@marrow.phys.tohoku.ac.jp>
	<20060105103604.4b785239.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:62724 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP id S932363AbWAFBCX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2006 20:02:23 -0500
In-Reply-To: <20060105103604.4b785239.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:

> On 05 Jan 2006 23:08:12 +0900
> Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:
> 
> > Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
> > >
> > > Does your system work without using the AHCI driver?
> > > or is it required?
> > 
> > I tested turning off AHCI with 2.6.15-rc7 + git-libata-all.patch +
> > libata_resume_fix.patch + libata_suspend-fix.patch +
> > libata_suspend.patch.  The system runs okay, and ACPI suspend/resume
> > and suspend2 work, without AHCI.
> > 
> > > Of course, even if the AHCI driver is not needed,
> > > it shouldn't be oopsing like this.
> > > 
> > > It looks like the ata_piix driver is the one that is
> > > actually being used, from what I can see here.
> > > 
> > > Please send your /proc/interrupts, /proc/iomem, /proc/ioports,
> > > and 'lspci -v'.
> > 
> > They are enclosed below.
> 
> Hi,
> While I'm looking over this, do you have a mode in which
> the AHCI driver loads successfully?  If so, look for a
> kernel message similar to this one:
> 
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode
> 
> and post it, please.  (I think that it won't say "SATA mode".)
> The "prog-if" value of 80 from your lspci output is interesting to me:
> 0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
> 

I couldn't find a line like that from a working kernel with AHCI
option on.  The only ahci-related lines look like

    ahci 0000:00:1f.2: version 1.2
    ahci: probe of 0000:00:1f.2 failed with error -12

I selected AHCI because the lines in ata_piix.c

	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },

and

	/* ich6_sata_rm */
	{
		.sht		= &piix_sht,
		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
		.pio_mask	= 0x1f,	/* pio0-4 */
		.mwdma_mask	= 0x07, /* mwdma0-2 */
		.udma_mask	= 0x7f,	/* udma0-6 */
		.port_ops	= &piix_sata_ops,
	},

seemed to indicate that my controller was ahci-capable.
But according to
http://marc.theaimsgroup.com/?l=linux-ide&m=111828214909335&w=2,
my system does not support AHCI.  I don't see Region 5 in the output
of lspci -vv -s 00:1f.2.

Jae-hyeon
