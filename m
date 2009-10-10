From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Sat, 10 Oct 2009 15:13:49 +0200
Message-ID: <200910101513.51320.elendil@planet.nl>
References: <4ABBB8C2.2080901@sbg.ac.at> <200909251448.17671.elendil@planet.nl> <4ACDD45C.5090009@sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:62567 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751971AbZJJNO3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Oct 2009 09:14:29 -0400
In-Reply-To: <4ACDD45C.5090009@sbg.ac.at>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

(dropped stable from CC)

On Thursday 08 October 2009, you wrote:
> Frans Pop wrote:
> > On Friday 25 September 2009, Alexander Huemer wrote:
> >>> So with the revert already in mainline for .32, the only thing le=
ft
> >>> is for that to get included in stable updates for .30 and .31.
> >>
> >> please see the last comment in [1].
> >> can i do anything else to help ?
> >>
> >> [1] http://bugzilla.kernel.org/show_bug.cgi?id=3D14124
>
> it seems like the problem is _not_ solved.
> i just booted with 2.6.31.3.
> 2.6.31-gentoo-r2 is vanilla-2.6.31-r2 with a few unrelated patches.

I don't know what vanilla-2.6.31-r2 is, but I assume it's based on eith=
er
2.6.31.3 or 2.6.31.2.

> did the usual verification (compilation of gcc-4.3.4),

> so in my opinion reverting commit [1] with commit [2] missed the poin=
t.
>
> [1] a5bfc4714b3f01365aef89a92673f2ceb1ccf246
> [2] 31b239ad1ba7225435e13f5afc47e48eb674c0cc

The most likely explanation is that your earlier test from which you
concluded that the revert did fix the problem was incorrect. It seems
unlikely that some other stable commit interferes here.

So basically we're back where we started.

> =A0 =A0 [ 1018.059729] irq 23: nobody cared (try booting with the "ir=
qpoll" option)
> =A0 =A0 [ 1018.059734] Pid: 8656, comm: sh Tainted: G =A0 =A0 =A0 =A0=
W=A0 =A0 2.6.31-gentoo-r2-blackbit #1
> =A0 =A0 [ 1018.059736] Call Trace:
> =A0 =A0 [ 1018.059738] =A0<IRQ> =A0[<ffffffff81066ecf>] ? __report_ba=
d_irq+0x30/0x7d
> =A0 =A0 [ 1018.059748] =A0[<ffffffff81067023>] ? note_interrupt+0x107=
/0x170
> =A0 =A0 [ 1018.059751] =A0[<ffffffff81067610>] ? handle_fasteoi_irq+0=
x8a/0xaa
> =A0 =A0 [ 1018.059755] =A0[<ffffffff8100d1cf>] ? handle_irq+0x17/0x1d
> =A0 =A0 [ 1018.059757] =A0[<ffffffff8100c84b>] ? do_IRQ+0x54/0xb2
> =A0 =A0 [ 1018.059761] =A0[<ffffffff8100b6d3>] ? ret_from_intr+0x0/0x=
a
> =A0 =A0 [ 1018.059762] =A0<EOI> =A0[<ffffffff815c7d2c>] ? do_page_fau=
lt+0xed/0x2ef
> =A0 =A0 [ 1018.059769] =A0[<ffffffff815c7f12>] ? do_page_fault+0x2d3/=
0x2ef
> =A0 =A0 [ 1018.059773] =A0[<ffffffff812dd5ed>] ? __put_user_4+0x1d/0x=
30
> =A0 =A0 [ 1018.059776] =A0[<ffffffff815c5fdf>] ? page_fault+0x1f/0x30
> =A0 =A0 [ 1018.059777] handlers:
> =A0 =A0 [ 1018.059778] [<ffffffff813d2d8c>] (ahci_interrupt+0x0/0x426=
)=20
> =A0 =A0 [ 1018.059783] Disabling IRQ #23

How reproducible is the error for you? Do you see it every time or not?
If it is reliably reproducible, can you think of any explanation why yo=
ur
earlier test was a success while we now see that the revert does not he=
lp?

Does the error *only* occur during gcc compilation, or was that just th=
e
simplest way to reproduce it? Does it always occur at the same point du=
ring
the compilation or does it vary?
Can you create a test case that does not require doing the whole
compilation, but only executes the step that triggers the error?

If you can find a reliable and fairly quick way to reproduce the error,=
 I
would suggest doing a bisection.

Jeff, Tejun: do you have any ideas what could cause this issue to sudde=
nly
appear or how to debug/instrument it?

Cheers,
=46JP
