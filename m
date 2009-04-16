From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like
	PowerPC systems
Date: Fri, 17 Apr 2009 02:04:51 +0400
Message-ID: <20090416220451.GA8636@oksana.dev.rtsoft.ru>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com> <c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com> <200904162130.01237.bzolnier@gmail.com> <20090416205735.GA26519@oksana.dev.rtsoft.ru> <c8485d470904161427w31ff313dsb651aa1f53bbacea@mail.gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:11746 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753878AbZDPWEx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 18:04:53 -0400
Content-Disposition: inline
In-Reply-To: <c8485d470904161427w31ff313dsb651aa1f53bbacea@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, Apr 16, 2009 at 11:27:34PM +0200, Roderick Colenbrander wrote:
> On Thu, Apr 16, 2009 at 10:57 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Thu, Apr 16, 2009 at 09:30:00PM +0200, Bartlomiej Zolnierkiewicz=
 wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday 15 April 2009 16:34:22 Roderick Colenbrander wrote:
> >> > Hi,
> >> >
> >> > I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
> >> > Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
> >> > for IDE, USB and Audio. I did a lot of work to get the pci bus w=
orking
> >> > on this board and it works correctly but the default init code
> >> > of the alim15x3 driver doesn't work for me. The driver explicitl=
y
> >> > disabled some initialization code for powerpc after uncommenting=
 this
> >> > code it works properly. Benjamin Herrenschmidt and I think this
> >> > !CONFIG_PPC check should be removed because the system behaves
> >> > like a real 'x86' system (also the i8259 interrupt controller is=
 used).
> >>
> >> Ben, I guess you are OK with the change and there are no longer ot=
her
> >> platforms requiring CONFIG_PPC check below? =C2=A0[I don't see you=
r ACK here]
> >
> > I'd like to nak this patch. It'll break MPC8610HPCD boards.
> >
> > See commit 6d1cee44361b8d06ccd1812e80448d86ae60dfe3
> >
> > I'm not sure how should we handle this for Xilinx PPC, MPC8610
> > PPC and Sparc all at the same time, but it's obvious that #ifdef
> > isn't enough any longer...
> >
> >
> >
>=20
> If it is really a board specific issue (in case of powerpc it appears
> to be one) we could also use the default_irq override in ppc_md. What
> do you think?

Um, I don't see "default_irq" in the ppc_md. Do you want to add one?

I wonder if DECLARE_PCI_FIXUP_*() mechanism will work... see
arch/powerpc/platforms/fsl_uli1575.c as an example for board-specific
PCI fixups.

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
