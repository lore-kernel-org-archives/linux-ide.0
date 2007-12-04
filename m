From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes
Date: Tue, 4 Dec 2007 22:45:31 +0300
Message-ID: <20071204194531.GA1253@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170726.GC15599@localhost.localdomain> <20071204191657.GB5758@lixom.net>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:5261 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751297AbXLDTlb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 14:41:31 -0500
Content-Disposition: inline
In-Reply-To: <20071204191657.GB5758@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>

On Tue, Dec 04, 2007 at 01:16:57PM -0600, Olof Johansson wrote:
> Hi,
> 
> On Tue, Dec 04, 2007 at 08:07:26PM +0300, Anton Vorontsov wrote:
> > diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> > index 5072f6d..c459b0a 100644
[...]
> > +static struct of_device_id mpc834x_itx_ids[] = {
> > +	{ .name = "localbus", },
> > +	{},
> > +};
> 
> Please add the "compatible" field here (fsl,pq2pro-localbus should do
> just fine), instead of the name.

Done, thanks.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v2.1] [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes

This patch adds localbus and pata nodes to use CF IDE interface
on MPC8349E-mITX boards.

Patch also adds code to probe localbus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts    |   18 +++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..c459b0a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -249,6 +249,22 @@
 		device_type = "pci";
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349emitx-localbus",
+			     "fsl,mpc8349e-localbus",
+			     "fsl,pq2pro-localbus";
+		reg = <e0005000 d8>;
+		ranges = <3 0 f0000000 210>;
 
-
+		pata@3,0 {
+			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
+			reg = <3 0 10 3 20c 4>;
+			reg-shift = <1>;
+			pio-mode = <6>;
+			interrupts = <17 8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..4797850 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -37,6 +38,22 @@
 
 #include "mpc83xx.h"
 
+static struct of_device_id mpc834x_itx_ids[] = {
+	{ .compatible = "fsl,pq2pro-localbus", },
+	{},
+};
+
+static int __init mpc834x_itx_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_itx))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc834x_itx_declare_of_platform_devices);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.2.2

