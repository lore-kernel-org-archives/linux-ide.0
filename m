From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Fri, 30 Dec 2016 17:05:51 +0100
Message-ID: <2007222.eymCZIUvPG@amdc3058>
References: <3010789.Juyl7C8p5j@amdc3058> <1544514.cVcK9YN4LR@amdc3058>
 <20161230005232.GA9069@giustizia>
 <CGME20161230160554epcas1p3830e973edb084440f85e5bb24dbf1f1f@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40288 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbcL3QF5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2016 11:05:57 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OJ0021W5A1UBV20@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 31 Dec 2016 01:05:54 +0900 (KST)
In-reply-to: <20161230005232.GA9069@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, petkovbb@gmail.com


Hi,

[ Your mails don't make it into linux-ide mailing list for some reason
  (the reason why I have not seen your patch before Dave applied it). ]

On Thursday, December 29, 2016 10:52:33 PM Luiz Carlos Ramos wrote:
> Hi,
> 
> I think I could catch the whole picture after your explanation. I'll try
> to summarize all the points discussed below in the body.
> 
> My suggestion now is to drop the current (proposed) patch and substitute
> it for a pure "documentational" patch, as it seems for me that a
> programmer new to that subsystem - as the case of myself - tends to find
> ide-generic.c buggy, if analyzed out of the whole context. Some more
> inline documentation may help all of us IMHO.

I agree.  BTW ide-generic is a bad name (my fault), it should have been
ide-isa or (better) ide-legacy.
 
> Of course improving the printed messages - as suggested - can help as well.
> 
> I'd like to hear from David (cc'ed) about this suggestion. What would you David
> suggest?
> 
> Anyway, there is a "break of the contract" with the old patch which
> introduced the search for the IDE interfaces. Before, it was not necessary
> to specify probe_mask=0x03 or like to make ide-generic find something in
> I/O addresses 0x1f0 and 0x170 (I wrongly wrote 0x1e0 in the former emails;
> please apologize me for that mistake). But this contract break seems to be
> justifiable on the grounds that - by a design decision - users "are encouraged"
> to use the designated drivers as a basic axiom. I suppose (or I hope) this
> was discussed at that time and this decision was taken consciously.

Yes, it was a conscious decision.

> On Wed, Dec 28, 2016 at 12:10:16PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> > > > > >> > > This humble patch was sent one or two months before, and had no actions,
> > > > > >> > > except for a colleague reply which friendly pointed out some formatting
> > > > > >> > > problems (which were solved in a second message).
> > > > > >> > > 
> > > > > >> > > It relates to an old code, the legacy IDE driver, but the bug it
> > > > > >> > > addresses is real. The code, although rarely used, is
> > > > > >> > > still there to be compiled if one chooses to do so (like me).
> > > > > >> > > 
> > > > > >> > > Also, the fix has a very low risk of present collateral effects IMHO.
> > > > > >> > > It is already compiled and tested in some embedded machines.
> > > > > >> > > 
> > > > > >> > > So, again IMHO, it is worth be fixed.
> > > > > >> > > 
> > > > > >> > > This email is a second trial with it. I hope it can help the one or two
> > > > > >> > > guys out there which are still running the legacy IDE driver and
> > > > > >> > > haven't noticed the former email.
> > > > > >> > > 
> > > > > >> > > Best regards,
> > > > > >> > > 
> > > > > >> > > Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> > > > > >> > 
> > > > > >> > This bug was introduced by commit
> > > > > >> > 20df429dd6671804999493baf2952f82582869fa ("ide-generic: handle probing
> > > > > >> > of legacy io-ports v5") which seems poorly tested.
> > > > > >> 
> > > > > >> Please always cc: the original commit author.
> > > > > >> 
> > > > > >> > Applied and queued up for -stable, th anks.
> > > > > >> 
> > > > > >> For some reason I've never got the discussed patch from
> > > > > >> linux-ide ML though I now have found in the patchwork:
> > > > > >> 
> > > > > >> https://patchwork.ozlabs.org/patch/680975/
> > > > > >> 
> > > > > >> The patch is incorrect.  If you have PCI IDE devices (like in
> > > 
> > > I think all of you have checked the code, but I will try to describe
> > > what I'm seeing.
> > > 
> > > The routine ide_generic_check_pci_legacy_iobases() returns *primary
> > > equal to 1 if some PCI IDE resource is found at 0x1f0, and *secondary
> > > equal to 1 if some PCI IDE resource is found at 0x1e0.  The same
> > > routine doesn't change neither *primary not *secondary if nothing is
> > > found. The only caller - ide_generic_init() - initializes both to zero
> > > before the call.
> > > 
> > > So, ide_generic_init() should test *primary for 1 in the case of an
> > > existing IDE primary resource, and *secondary for 1 in the case of a
> > > secondary IDE resource.
> > > 
> > > Unpatched code checks both for zero in order to set the proper bits in
> > > probe_mask, and IMHO this is reversed logic.
> > 
> > Unpatched code is correct.
> > 
> > If PCI IDE resource is found we shouldn't do the probe automatically
> > as ide-generic is not the proper driver to run the hardware.  IOW we
> > only want to do automatic probe if no PCI IDE resources are found (if
> > primary/secondary == 0).  In such case we are most likely running on
> > pre-PCI system and should be probing for legacy ISA IDE ports. Please
> > note they are are using the same I/O resources as PCI IDE ones (!).
> > 
> 
> Understood. ide-generic should not use devices which have a PCI
> interface, unless the user tells it to do it (using probe_mask!=0).
> 
> The basic assumption - as stated I think in your first reply - is that
> by design, users should use the driver more suitable for the chipset, if
> it has a PCI interface, and not ide-generic.
> 
> I think this assumption should be highlighted as an axiom, or a design
> decision. Otherwise, one could argue in favor of enabling ide-generic as a first
> option for handling the IDE interface, be that PCI or IDE.
> 
> Also is supposed that this decision is not subject to discussion (now).

You are correct, also IDE subsystem is now in deep maintenance mode.

> > > > > >> The patch is incorrect.  If you have PCI IDE devices (like in
> > > > > >> the case described in the situation being "fixed" by the patch)
> > > > > >> you should use the correct PCI IDE host driver for proper
> > > > > >> operation and not ide-generic host driver (the latter still can
> > > > > >> be used by using kernel parameters).
> > > > > > 
> > > 
> > > Please elaborate more on this; I really haven't understood. It seems that
> > > you're telling about PCI host driver code, which I haven't studied. I
> > > haven't caught the whole picture.
> > > 
> > > In my case, there are two IDE interfaces, which are at the common
> > > addresses 0x1f0 and 0x1e0 (PCI also tells me that), and the chipset is
> > > a CS5536. The previous kernel used in the system (2.6.16) worked with
> > > ide-generic, and the one I'm testing now (3.18.x) doesn't bring any of
> > > the IDE interfaces up.
> > > 
> > > You're right in the sense I haven't compiled the CS5536 legacy host
> > > driver code; so, I can't tell about how it works.
> > 
> > You should be using CS5336 PCI IDE host driver (drivers/ide/cs5536.c
> > enabled by CONFIG_BLK_DEV_CS5536 config option) for optimal performance
> > and proper operations.
> > 
> > CS5536 PCI IDE host driver was added in kernel v2.6.29.
> 
> This can be one reason to not have CS5536 driver used in the first
> version of the system (kernel 2.6.16).

Please note that CS5536 is supported also in amd74xx.c host driver
(for historical reasons) and this support was merged in 2005 in
commit 7fab773de16ccaeb249acdc6e956a9759c68225d (kernel v2.6.15).

Also even before that ide-pci-generic.c driver has been available
which is still more suitable than ide-generic.c one for CS5536
(it needs to be forced with "ide_pci_generic.all_generic_ide" kernel
command line parameter).

> > > Of course there are many reasons to use the correct PCI IDE host
> > > driver, but at the end, it's up to the user to choose which one he/she will
> > > use, and ideally any of them should work.
> > 
> > It happens to "work" on your system because CS5536 is relatively
> > simple and non-buggy PCI IDE chipset.
> > 
> > In case of other PCI IDE chipsets you may not only be missing
> > performance or some functionality - on some more quirky chipsets
> > you may be also affecting data integrity (!).
> > 
> > Anyway you still can use ide-generic by using kernel parameters
> > (just add "ide_generic.probe_mask=0x03" to your kernel command line).
> > 
> 
> As said before, this is a contract break between versions from, let's
> say, 2006 and today's.
> 
> Anyway, there's no way to avoid it, it we take the assumption above
> (designated drivers prior to ide-generic) as an axiom.
> 
> > I agree that the ide-generic could be more verbose and print more
> > information in case of skipping the probe (patches are welcomed).
> > 
> 
> I think this is a good idea, but more important IMHO is to document
> properly in the code all this discussion. If I have some spare time
> (not sure about this), I'll try to submit patches (better to have two)
> to address both "issues".

Thank you, it would be good to have this covered.

> > > > > > Moreover this patch introduces a regression.  In the situation
> > > > > > when there are no PCI IDE devices and the probing should be done
> > > > > > automatically (for the first two legacy IDE ports) it will be no
> > > > > > longer done.
> > > > > > 
> > > 
> > > Again, please elaborate more on this.
> > > 
> > > If there are no PCI IDE devices, well, there are no PCI IDE devices.
> > > Nothing is supposed to be found. Anyway, it seems they will be searched
> > > for, in ide_generic_check_pci_legacy_iobases(). Or I missed something
> > > important.
> > 
> > In case there are no PCI IDE devices we most likely are running on
> > pre-PCI system and should be probing for legacy ISA IDE ports (please
> > note they are are using the same I/O resources),
> > 
> 
> Ok, that is, ide-generic is tailored to pure ISA devices, and _can_ work
> in some PCI devices, although not guaranteed, on user request
> (probe_mask!=0).

Yes.

> > > > > > Now back to the using correct PCI IDE host drivers - Luiz what
> > > > > > are the systems that you need this patch on?  Could you please
> > > > > > get 'lspci -nn' command output from them?
> > > > > 
> > > > > The original code before the patch in question probed the interfaces
> > > > > unconditionally, probe_mask was a static int set to "0x03".
> > > > > 
> > > > > Commit 20df429dd6671804999493baf2952f82582869fa changed the default
> > > > > behavior, as well as adding a new module parameter whose behavior
> > > > > makes no sense at all.  Inverted bit logic?  Give me a break.
> > > > > 
> > > > > Sorry, no, the fix is correct and I'm pushing it to Linus.
> > > > 
> > > > The "fix" is not correct and is not needed.  99% of users of ide-generic
> > > > used it by mistake and should have used the designated host drivers for
> > > > their hardware or PCI IDE generic host driver (not ide-generic one).
> > > 
> > > My system didn't work without this patch. I agree I could use the
> > > designated host driver, but it seems a little strong to say one _should_
> > > use it.
> > 
> > Sorry but one should really use the designated drivers and we don't
> > want to see any bugreports from using ide-generic on hardware that
> > have designated drivers.
> > 
> 
> As said above, this is a kind of axiom, and I understand this is a
> conscious decision made somewhere in the past.
> 
> Avoiding extra bug reports is a smart decision, anyway.
> 
> > > > Alan Cox did the work on fixing this for his pata_legacy libata host
> > > > driver and later Borislav back-ported needed changes to ide-generic host
> > > > driver in commit 20df429dd6671804999493baf2952f82582869fa (in *2008*).
> > > > 
> > > > Also the "fix" is not a revert but a new patch which introduces a real
> > > > regression described by me in the previous mail.
> > > > 
> > > 
> > > As said above, it is a regression considering the versions from 2006. I
> > > agree that for someone who used the drivers from 2009 and after, it
> > > _may_ be a regression if she uses to bring all up with probe_mask=0.
> > 
> > The regression I was talking about is in the proposed patch.
> > 
> > By simply reversing the logic ISA IDE ports will no longer be probed
> > automatically on non-PCI systems.
> > 
> 
> Understood. It makes sense.

Thank you for understanding.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

