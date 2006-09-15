From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Fri, 15 Sep 2006 13:48:28 -0600
Message-ID: <8202f4270609151248k236d6c24vab519b64902f102e@mail.gmail.com>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
	 <20060915180903.GC25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:5265 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751590AbWIOTs3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 15:48:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so4197882pyg
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 12:48:28 -0700 (PDT)
In-Reply-To: <20060915180903.GC25800@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9/15/06, Tejun Heo <htejun@gmail.com> wrote:
> On Fri, Sep 15, 2006 at 09:12:33AM -0600, Fajun Chen wrote:
> > Hi,
> >
> > I'm trying to speed up the SATA hotplug sequence so I can measure the
> > disk spinup time more accurately.  I noticed two delays which may be
> > unnecessary in SATA hotplug:
> > 1. About 4-5 seconds delay during power cycle (power down then power
> > up) as shown below (detail log at the end):
> > [65642.680000] ata_eh_prep_resume: ENTER
> > [65642.680000] ata_eh_prep_resume: EXIT
> > [65642.680000] __ata_port_freeze: ata2 port frozen
> > [65646.970000] ata2: soft resetting port
> > [65646.970000] sil24_softreset: ENTER
> > Question: where is the delay introduced and can we eliminate this delay?
>
> It's probably waiting for ATA_BUSY to clear in prereset.
>
> > 2. Soft reset fails sometimes then followed by a successful hard reset.
> > Question: may I do hard reset to start with and where is the best
> > place to change this? I know sata spec recommend attempting less
> > intrusive recovery procedure first, but I need to eliminate as much
> > unnecessary delay as possible.
>
> ATA_FLAG_HRST_TO_RESUME.  You probably also want to tweak
> ATA_SPINUP_WAIT.
>

    Tejun, I use SATA Sil24.  Where should ATA_FLAG_HRST_TO_RESUME be
flagged?  I made one attempt by making the following change in
libata.h and it seems not working sometimes (see log at the end)? I'm
a little puzzled by different flags such as ap->flags, ehc->flags...
Is there any document about new eh?

static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
{
	if (ehi->flags & ATA_EHI_HOTPLUGGED)
		return;

	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
	ehi->hotplug_timestamp = jiffies;

	ehi->action |= ATA_EH_HARDRESET;    // My Change for Hard Reset
	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
}
...
[ 5985.450000] ata1: EH pending after completion, repeating EH (cnt=4)
[ 5985.450000] ata_eh_autopsy: ENTER
[ 5985.450000] ata_eh_autopsy: EXIT
[ 5985.450000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1
[ 5985.450000] ata1: (irq_stat 0x00b40090, PHY RDY changed)
[ 5985.450000] ata_eh_recover: ENTER
[ 5985.450000] ata_eh_prep_resume: ENTER
[ 5985.450000] ata_eh_prep_resume: EXIT
[ 5985.450000] __ata_port_freeze: ata1 port frozen
[ 5985.450000] ata_wait_spinup: ENTER
[ 5985.450000] sata_phy_debounce: ENTER
[ 5985.970000] sata_phy_debounce: EXIT
[ 5988.990000] ata_wait_spinup: EXIT
[ 5988.990000] sata_phy_resume: ENTER
[ 5989.200000] sata_phy_debounce: ENTER
[ 5989.720000] sata_phy_debounce: EXIT
[ 5989.720000] sata_phy_resume: EXIT
[ 5989.720000] ata1: soft resetting port
[ 5989.720000] sil24_softreset: ENTER
[ 5989.830000] ata_dev_classify: found ATA device by sig
[ 5989.830000] sil24_softreset: EXIT, class=1
[ 5989.830000] ata_std_postreset: ENTER
[ 5989.830000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
...
