From: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
Date: Fri, 25 Jan 2008 11:38:12 -0600
Message-ID: <20080125113812.ddf89c3f.kim.phillips@freescale.com>
References: <20080124204621.2c09359e.kim.phillips@freescale.com>
	<089EA00D-8EAB-417D-9A4B-FA500D23FF8D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:65481 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYAYRng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 12:43:36 -0500
In-Reply-To: <089EA00D-8EAB-417D-9A4B-FA500D23FF8D@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Fri, 25 Jan 2008 10:04:08 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jan 24, 2008, at 8:46 PM, Kim Phillips wrote:
> 
> > The mpc8315 shares the same SATA controller as the mpc837x,
> > and likelihood is that future SoCs from Freescale will also.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> > Kumar, let me know if you want me to post this to the ata list (I'm
> > assuming it's not necessary).
> 
> It is necessary so they are aware.  CC jgarizk, but we'll take it via  
> powerpc.
> 
> - k
> 
ok, cc'ing Jeff, linux-ide here:

From: Kim Phillips <kim.phillips@freescale.com>
Date: Thu, 24 Jan 2008 01:49:24 -0600
Subject: [PATCH] enable FSL SATA driver config for Freescale SoCs

The mpc8315 shares the same SATA controller as the mpc837x,
and likelihood is that future SoCs from Freescale will also.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/ata/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 64b4964..75939dd 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -184,7 +184,7 @@ config PATA_ACPI
 
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
-	depends on PPC_MPC837x
+	depends on FSL_SOC
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
 	  It can be found on MPC837x and MPC8315.
-- 
1.5.2.2

