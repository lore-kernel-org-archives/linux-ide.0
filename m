From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Mon, 20 Feb 2012 04:40:21 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002065A30@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
 <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
 <1329448724.2892.43.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:56257
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893Ab2BTEk1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Feb 2012 23:40:27 -0500
In-Reply-To: <1329448724.2892.43.camel@pasglop>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Li Yang-R58472 <r58472@freescale.com>
Cc: Liu Qiang-B32616 <B32616@freescale.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org]
> On Behalf Of Benjamin Herrenschmidt
> Sent: Friday, February 17, 2012 11:19 AM
> To: Li Yang-R58472
> Cc: Liu Qiang-B32616; jgarzik@pobox.com; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org
> Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
> 
> On Fri, 2012-02-17 at 03:09 +0000, Li Yang-R58472 wrote:
> > >I tried a debian install on the p5020ds here and I find SATA to be
> > >extremely slow, generating millions of interrupts. I think the
> > defaults
> > >should be a lot more aggressive at coalescing.
> >
> > The P5020 has a hardware problem with SATA, making it generate more
> > interrupts than it should.  A new revision of the silicon will fix it.
> 
> Ok cool. With a bit of luck you guys can send me a new silicon when it's
> available then :-) (The one in the board you got me seems to be in a
> socket).
Ben,
We still do not have the a P5020 sample to fix the problem.
One workaround is to use the patch ( I think you have noticed the patch):
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/commit/?id=92c0ce1e599e788ffc0908739db9bd5e0dbdad69

and  use a SSD hard drive.
It will have a usable performance.
Thanks.
Roy

