From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes
Date: Tue, 27 Nov 2007 19:41:01 +0300
Message-ID: <20071127164101.GA14790@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain> <474C3C79.5060908@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7437 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751018AbXK0QgK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 11:36:10 -0500
Content-Disposition: inline
In-Reply-To: <474C3C79.5060908@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Tue, Nov 27, 2007 at 06:49:13PM +0300, Sergei Shtylyov wrote:
> Hello.

Hi Sergei,

> Anton Vorontsov wrote:
> 
> >This patch adds localbus and pata nodes to use CF IDE interface
> >on MPC8349E-mITX boards.
> 
> >Patch also adds code to probe localbus.
> 
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> > arch/powerpc/boot/dts/mpc8349emitx.dts    |   17 ++++++++++++++++-
> > arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
> > 2 files changed, 33 insertions(+), 1 deletions(-)
> 
> >diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts 
> >b/arch/powerpc/boot/dts/mpc8349emitx.dts
> >index 5072f6d..7a97068 100644
> >--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> >+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> >@@ -249,6 +249,21 @@
> > 		device_type = "pci";
> > 	};
> > 
> >+	localbus@e0005000 {
> >+		#address-cells = <2>;
> >+		#size-cells = <1>;
> >+		compatible = "fsl,mpc8349emitx-localbus",
> 
>    Board compatible bus?

This is what Documentation/powerpc/booting-without-of.txt suggests
for localbuses. I'm following.

> >+			     "fsl,mpc8349e-localbus",
> >+			     "fsl,pq2pro-localbus";
> >+		reg = <e0005000 d8>;
> >+		ranges = <3 0 f0000000 210>;
> > 
> >-
> >+		pata@3,0 {
> >+			compatible = "fsl,mpc8349emitx-pata", 
> >"pata-platform";
> >+			reg = <3 0 10 3 20c 4>;
> >+			ioport-shift = <1>;
> 
>    Bleh... that shift again. And this is surely not a good name for a 
> property (where's I/O ports in your case?) -- why not call it "reg-shift" 
> (well, I'd call it "reg-size" or "reg-stride" myself :-)?

1. "shift" because pata_platform using that name. I don't see any
   reason to contrive indirections. ioport-shift is what the whole
   Linux kernel using nowadays, and ioport-shift dts property
   anyway Linux-specific.

   I'm just following todays' conventions.

   If you feel really bad about that, I think better to fix that in
   the source of the badness -- pata_platform. It's easy, I can do
   that. Would you ack patch that converts whole pata_platform and
   users? Would Paul ack it?

   Still, is there any hardware that needs not power of 2 stride?

2. "ioport" because shift^Wstride ;-) applies only to the io range
   (yes, it's obvious, but worth open-wording, no?).


And btw, I can get rid of ioport-shift at all. And do fixups in
the pata_of_platform driver via .compatible matching. But I don't
want: it feels bad to list every needs-to-fixup board in the common
driver. It also feels not so great creating something like
pata-platform-stride-{1,2,4,...} compatible stuff. Heh.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
