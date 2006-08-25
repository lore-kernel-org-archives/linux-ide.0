From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Fri, 25 Aug 2006 09:26:03 -0600
Message-ID: <8202f4270608250826h67edf5d7n8436961374896348@mail.gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
	 <44EC8128.2040204@gmail.com>
	 <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>
	 <44ECAB62.8030804@gmail.com>
	 <8202f4270608231255k116918dfk58e4c14cd859c175@mail.gmail.com>
	 <8202f4270608231349v5aabace2xaff8fe93c133a7ca@mail.gmail.com>
	 <20060824070257.GD21866@htj.dyndns.org>
	 <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>
	 <44EDDB91.1050102@gmail.com>
	 <8202f4270608241701g494bfadaw74dd3d059182e4cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:29760 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030193AbWHYP0F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 11:26:05 -0400
Received: by py-out-1112.google.com with SMTP id n25so1282079pyg
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 08:26:04 -0700 (PDT)
In-Reply-To: <8202f4270608241701g494bfadaw74dd3d059182e4cc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun,

JFYI. I found a workaround which seems to be working in 2.6.18-rc2.
During warm plug/unplug, if I don't delete the device through sysfs or
proc and just rescan the host, it recovered just fine.

Thanks,
Fajun

On 8/24/06, Fajun Chen <fajunchen@gmail.com> wrote:
> Hi Tejun,
>
> I tested 2.6.18-rc4-mm2 on i386 platform with and without your patch.
> The behavior is the same as rc2 with your patch. No kernel error and
> the only relevant dmesg traces are:
> [  125.048966] ata5: soft resetting port
> [  125.202410] ata5.00: configured for UDMA/100
> [  125.202492] ata5: EH complete
> [End of dmesg]
> It did not proceed to add/attach sg device!
>
> In rc4-mm2 release without your patch, I forgot to power on pata drive
> and add drive will cause kernel error. Please see attachment for
> detailed log.
>
> I can reproduce the problem easily, please feel free to let me know
> what kind of log/traces can be collected.
>
> Thanks,
> Fajun
>
>
> On 8/24/06, Tejun Heo <htejun@gmail.com> wrote:
> > [cc'ing linux-ide again]
> >
> > Fajun Chen wrote:
> > > Hi Tejun,
> > >
> > > Your patch is successful at fixing the kernel error when adding pata
> > > drive on 2.6.18-rc2 but there's some sg availability issue.  I did the
> > > same sequence of test: power off drive -> remove drive -> power on
> > > drive -> add drive. From dmesg log, pata drive was added back
> > > successfully as sg0 but somehow it is unavailable for upper level. For
> > > instance, sg_scan didn't detect it. It is not shown in
> > > /sys/class/scsi_generic/.  Sg utilities sg_inq and sg_dd complained
> > > about no such device for sg0.  Is there any magic command I need to
> > > issue to populate sg information up to the user space? If not, then
> > > there is still bug somewhere.  Complete log of the test sequence is
> > > attached.
> > >
> > > I'll hold off the testing on 2.6.18-rc4 for now. Please let me know if
> > > you think it still makes sense to test your patch in the new release.
> > > Thanks for your help!
> >
> > The thing is that the patch shouldn't really change behavior.  With the
> > patch, libata might be more forgiving about SCSI refcnt bugs but the
> > code before and after are identical correctness-wise.  ISTR there has
> > been SCSI ref bug fixed sometime inbetween.  I can't pinpoint it though.
> >   So, please try 2.5.18-rc4 w/ or w/o the patch.  Pull
> > libata-dev#pata-drivers, that's basically current linus #master +
> > libata-dev#upstream updates + Alan's pata-drivers.
> >
> > Of course, I might be wrong, but I kind of have too little lead to
> > follow on at the moment, especially because I can't reproduce it here.
> > If testing new kernel on your target platform takes a lot of effort,
> > just perform preliminary tests on x86.  As far as SCSI and libata are
> > concerned, there's little difference.
> >
> > --
> > tejun
> >
>
>
>
