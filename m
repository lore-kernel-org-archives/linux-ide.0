From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Wed, 28 Dec 2016 12:10:16 +0100
Message-ID: <1544514.cVcK9YN4LR@amdc3058>
References: <3010789.Juyl7C8p5j@amdc3058> <1680456.bXBqjl9psU@amdc3058>
 <20161228003335.GA3720@giustizia>
 <CGME20161228111018epcas5p258bdefa12d6cb1e6a1ffe0164119f4e6@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36394 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbcL1LUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2016 06:20:35 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OIW032VX7178M30@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 28 Dec 2016 20:10:19 +0900 (KST)
In-reply-to: <20161228003335.GA3720@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, petkovbb@gmail.com


Hi,

On Tuesday, December 27, 2016 10:33:35 PM Luiz Carlos Ramos wrote:
> Hi,
> 
> I really don't know if my opinions will be well received, but here we go.
> 
> Please apologize me if you feel me rude, but I'm just trying to explain
> the problem the way I'm seeing it, and also to understand what you are
> saying the best I can.
> 
> On Tue, Dec 27, 2016 at 06:25:18PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Tuesday, December 27, 2016 11:41:12 AM David Miller wrote:
> > > From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Date: Tue, 27 Dec 2016 17:06:19 +0100
> > > 
> > > > On Tuesday, December 27, 2016 11:08:24 AM Bartlomiej Zolnierkiewicz wrote:
> > > >> 
> > > >> Hi,
> > > >> 
> > > >> On Monday, December 26, 2016 11:47:24 AM David Miller wrote:
> > > >> > From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> > > >> > Date: Tue, 11 Oct 2016 22:12:45 -0300
> > > >> > 
> > > >> > > This humble patch was sent one or two months before, and had no actions,
> > > >> > > except for a colleague reply which friendly pointed out some formatting
> > > >> > > problems (which were solved in a second message).
> > > >> > > 
> > > >> > > It relates to an old code, the legacy IDE driver, but the bug it
> > > >> > > addresses is real. The code, although rarely used, is
> > > >> > > still there to be compiled if one chooses to do so (like me).
> > > >> > > 
> > > >> > > Also, the fix has a very low risk of present collateral effects IMHO.
> > > >> > > It is already compiled and tested in some embedded machines.
> > > >> > > 
> > > >> > > So, again IMHO, it is worth be fixed.
> > > >> > > 
> > > >> > > This email is a second trial with it. I hope it can help the one or two
> > > >> > > guys out there which are still running the legacy IDE driver and
> > > >> > > haven't noticed the former email.
> > > >> > > 
> > > >> > > Best regards,
> > > >> > > 
> > > >> > > Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> > > >> > 
> > > >> > This bug was introduced by commit
> > > >> > 20df429dd6671804999493baf2952f82582869fa ("ide-generic: handle probing
> > > >> > of legacy io-ports v5") which seems poorly tested.
> > > >> 
> > > >> Please always cc: the original commit author.
> > > >> 
> > > >> > Applied and queued up for -stable, th anks.
> > > >> 
> > > >> For some reason I've never got the discussed patch from
> > > >> linux-ide ML though I now have found in the patchwork:
> > > >> 
> > > >> https://patchwork.ozlabs.org/patch/680975/
> > > >> 
> > > >> The patch is incorrect.  If you have PCI IDE devices (like in
> 
> I think all of you have checked the code, but I will try to describe
> what I'm seeing.
> 
> The routine ide_generic_check_pci_legacy_iobases() returns *primary
> equal to 1 if some PCI IDE resource is found at 0x1f0, and *secondary
> equal to 1 if some PCI IDE resource is found at 0x1e0.  The same
> routine doesn't change neither *primary not *secondary if nothing is
> found. The only caller - ide_generic_init() - initializes both to zero
> before the call.
> 
> So, ide_generic_init() should test *primary for 1 in the case of an
> existing IDE primary resource, and *secondary for 1 in the case of a
> secondary IDE resource.
> 
> Unpatched code checks both for zero in order to set the proper bits in
> probe_mask, and IMHO this is reversed logic.

Unpatched code is correct.

If PCI IDE resource is found we shouldn't do the probe automatically
as ide-generic is not the proper driver to run the hardware.  IOW we
only want to do automatic probe if no PCI IDE resources are found (if
primary/secondary == 0).  In such case we are most likely running on
pre-PCI system and should be probing for legacy ISA IDE ports. Please
note they are are using the same I/O resources as PCI IDE ones (!).

> There are two ways of fixing this. One is to test *primary and
> *secondary for "not zero" in ide_generic_init(), as proposed. The other
> way is to change ide_generic_check_pci_legacy_iobases() in order to
> return *primary or *secondary with zero in case of success when
> searching for PCI resources - along with setting them to "not zero"
> before checking.

No need to change anything.  Original code is correct.

> > > >> The patch is incorrect.  If you have PCI IDE devices (like in
> > > >> the case described in the situation being "fixed" by the patch)
> > > >> you should use the correct PCI IDE host driver for proper
> > > >> operation and not ide-generic host driver (the latter still can
> > > >> be used by using kernel parameters).
> > > > 
> 
> Please elaborate more on this; I really haven't understood. It seems that
> you're telling about PCI host driver code, which I haven't studied. I
> haven't caught the whole picture.
> 
> In my case, there are two IDE interfaces, which are at the common
> addresses 0x1f0 and 0x1e0 (PCI also tells me that), and the chipset is
> a CS5536. The previous kernel used in the system (2.6.16) worked with
> ide-generic, and the one I'm testing now (3.18.x) doesn't bring any of
> the IDE interfaces up.
> 
> You're right in the sense I haven't compiled the CS5536 legacy host
> driver code; so, I can't tell about how it works.

You should be using CS5336 PCI IDE host driver (drivers/ide/cs5536.c
enabled by CONFIG_BLK_DEV_CS5536 config option) for optimal performance
and proper operations.

CS5536 PCI IDE host driver was added in kernel v2.6.29.

> Of course there are many reasons to use the correct PCI IDE host
> driver, but at the end, it's up to the user to choose which one he/she will
> use, and ideally any of them should work.

It happens to "work" on your system because CS5536 is relatively
simple and non-buggy PCI IDE chipset.

In case of other PCI IDE chipsets you may not only be missing
performance or some functionality - on some more quirky chipsets
you may be also affecting data integrity (!).

Anyway you still can use ide-generic by using kernel parameters
(just add "ide_generic.probe_mask=0x03" to your kernel command line).

I agree that the ide-generic could be more verbose and print more
information in case of skipping the probe (patches are welcomed).

> > > > Moreover this patch introduces a regression.  In the situation
> > > > when there are no PCI IDE devices and the probing should be done
> > > > automatically (for the first two legacy IDE ports) it will be no
> > > > longer done.
> > > > 
> 
> Again, please elaborate more on this.
> 
> If there are no PCI IDE devices, well, there are no PCI IDE devices.
> Nothing is supposed to be found. Anyway, it seems they will be searched
> for, in ide_generic_check_pci_legacy_iobases(). Or I missed something
> important.

In case there are no PCI IDE devices we most likely are running on
pre-PCI system and should be probing for legacy ISA IDE ports (please
note they are are using the same I/O resources),

> > > > Now back to the using correct PCI IDE host drivers - Luiz what
> > > > are the systems that you need this patch on?  Could you please
> > > > get 'lspci -nn' command output from them?
> > > 
> > > The original code before the patch in question probed the interfaces
> > > unconditionally, probe_mask was a static int set to "0x03".
> > > 
> > > Commit 20df429dd6671804999493baf2952f82582869fa changed the default
> > > behavior, as well as adding a new module parameter whose behavior
> > > makes no sense at all.  Inverted bit logic?  Give me a break.
> > > 
> > > Sorry, no, the fix is correct and I'm pushing it to Linus.
> > 
> > The "fix" is not correct and is not needed.  99% of users of ide-generic
> > used it by mistake and should have used the designated host drivers for
> > their hardware or PCI IDE generic host driver (not ide-generic one).
> 
> My system didn't work without this patch. I agree I could use the
> designated host driver, but it seems a little strong to say one _should_
> use it.

Sorry but one should really use the designated drivers and we don't
want to see any bugreports from using ide-generic on hardware that
have designated drivers.

> A newer version of the system uses libata, and yes, it works.

In libata there is the same policy as in IDE - pata_legacy host driver
(libata's equivalent of ide-generic host driver) was the first one
using the new policy, it was later back-ported to ide-generic.

> > Alan Cox did the work on fixing this for his pata_legacy libata host
> > driver and later Borislav back-ported needed changes to ide-generic host
> > driver in commit 20df429dd6671804999493baf2952f82582869fa (in *2008*).
> > 
> > Also the "fix" is not a revert but a new patch which introduces a real
> > regression described by me in the previous mail.
> > 
> 
> As said above, it is a regression considering the versions from 2006. I
> agree that for someone who used the drivers from 2009 and after, it
> _may_ be a regression if she uses to bring all up with probe_mask=0.

The regression I was talking about is in the proposed patch.

By simply reversing the logic ISA IDE ports will no longer be probed
automatically on non-PCI systems.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> IMHO, it's the case where a bug later becomes a feature.
> 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> 
> Best regards,
> 
> Luiz Carlos Ramos
> São Paulo - Brazil

