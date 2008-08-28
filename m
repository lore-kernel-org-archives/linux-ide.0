From: Thomas Renninger <trenn@suse.de>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Thu, 28 Aug 2008 14:36:28 +0200
Message-ID: <200808281436.30089.trenn@suse.de>
References: <48A35FE6.1080903@tlinx.org> <48B60373.2050501@tlinx.org> <48B64DB3.6060906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41341 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYH1Mgd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Aug 2008 08:36:33 -0400
In-Reply-To: <48B64DB3.6060906@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday 28 August 2008 09:03:15 Tejun Heo wrote:
> (cc'ing Thomas and linux-acpi for ACPI reference)
>
> Linda Walsh wrote:
> > Tejun Heo wrote:
> >> Alan Cox wrote:
> >>>> 13 10:12:20 kern: res ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x12
> >>>> (ATA bus error)
> >>>> rn: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar DevExch }
> >>>> 13 10:14:37 kern: ata4: port is slow to respond, please be patient
> >>>> (Status 0xff)
> >>>
> >>> First guess would be a dud drive but it could be power or cabling or
> >>> firmware or ...
> >>
> >> Hmm... this could be either the drive or the controller.
> >
> > ----
> >
> >    Just to confirm -- this particular problem was due to a faulty
> > brand-new SATA Western_Digital drive that died.  It hung the system
> > several times under load, but shortly after the above errors,
> > the system would not boot with that drive attached.
> >
> >    Secondary error:     My ACPI impementation is, /apparently/, flakey.
> > I used to not be able to use acpi back in the 2.2 timeframe.  But
> > sometime in the 2.4 timeframe, ACPI started working with this system
> > (a 440BX based motherboard).  I thought ACPI support had improved.
> > Symptom of ACPI based boot vs. non: random hang (a few hours up to maybe
> > 48 hours max).  But after I thought ACPI was 'fixed', booting with ACPI
> > (or not) resulted in stable system.
> >
> >    But -- two different error types.  Starting with the 2.6.25 series,
> > I started observing hangs again (same in the 2.6.26 series).  My last
> > stable was 2.6.24.1.  BUT -- I also occasionally noticed some rare
> > sporadic disk error messages (while looking for the cause of the hang) --
> > they weren't there in the "pre-hang" 2.6.24.1 kernel...(I couldn't
> > even get a 2.6.24.7 kernel to stay up for more than 2 days).
> >
> >    My upgrade strategy for disks has been to move to SATA disks as
> > I needed to replace older PATA's.  Had alot of problems last Feb when
> > I tried to use SATA; after a few weeks of making no progress discovering
> > the source of he hangs, I went back to a PATA drive and took out the SATA
> > controller -- and system went back to stable.  Ok...I'm tired of
> > debugging this...lets stay with PATA for now.
> >
> >    Six months later...need another disk.  Back to trying SATA...
> > more hangs (and a bad disk drive).  It seems that in addition to
> > ACPI no longer working above my 2.6.24.1 kernel, adding in the SATA
> > board also would cause an ACPI based boot to eventually hang (max
> > runtime ~30 hours).  Using the kernel load option "acpi=noirq", seems to
> > be the key to stability now.
> >
> >    So I don't know exactly what changed -- but ACPI, which was working
> > (pre-SATA) seemed to stop being reliable after 2.6.24.1.
> >    Anyway I cut it,  acpi=noirq   now seems to be a requirement for
> > system stability.  My ACPI version string shows it as "1.0"...so I'm
> > guessing there might have been some kinks in the implementation.
There is bug:
http://bugzilla.kernel.org/show_bug.cgi?id=11044
There it is exactly the other way around:
PATA is not, but SATA is working. But:
pci=noacpi (which should have the same effect as acpi=irq)
Hmm, the machine are rather different? Could be totally unrelated.

Hmm, are there dmesg from working and non-working kernels?

Also the system is really old. Why don't you stick to pci=noacpi or
even acpi=off?
What advantage do you want to get with ACPI (SATA works?)?

   Thomas

> >
> >    So had 4 different problems all converge at roughly the same time:
> > 1)  new SATA Western_Digital-1TB disk failure,
> > 2)  ACPI-induced instability in 2.6.25 and above
> > 3)  ACPI induced instability with addition of new SATA controller
> >    (including a rebuilt-for-sata-support 2.6.24.1).
> > 4)  Auxiliary cooling fan failed and system would get 'warm' (don't know
> >    exact temps, but some disks were nearing 50C (normal is mid 30's,
> >    except for the 15K system SCSI.  It has its own attached fan, so
> >    it's usually a few degrees cooler when the case-fans are operating
> >    correctly.
> >    However, the disk temps are not indicative of the CPU temps -- they
> >    are only an indirect sign that case-airflow is sub-optimal.  The
> >    CPU's (2 1GHz P-III's) in this baby don't give reliable thermal
> >    warnings (have only ever seen 1).  Usually the system will
> >    just 'hang' (not the most helpful indicator in any event).
> >
> > Thanks much for feedback that led me to figuring out (*crossing
> > fingers*) the problems and fixes...
