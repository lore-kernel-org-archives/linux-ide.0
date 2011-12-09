From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/3] pata/at91: use new introduce smc accessor
Date: Fri, 9 Dec 2011 19:42:39 +0100
Message-ID: <20111209184239.GR23884@game.jcrosoft.org>
References: <20111208150348.GD23884@game.jcrosoft.org>
 <1323357784-17555-2-git-send-email-plagnioj@jcrosoft.com>
 <4EE1EA25.3010002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:50652 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942Ab1LISqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2011 13:46:38 -0500
Received: from mail192.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 91C1D1050343
	for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2011 19:46:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EE1EA25.3010002@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

On 14:59 Fri 09 Dec     , Sergei Shtylyov wrote:
> Hello.
> 
> On 08-12-2011 19:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
>    Your subject doesn't parse. Maybe you meant "use newly introduced
> smc accessor"?
yeap
> 
> >this will allow to use the pata_at91 on a single zImage
> 
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> >Cc: linux-ide@vger.kernel.org
> >---
> >Hi,
> 
> >	it's depends on other patch for AT91 can we apply via at91
> 
> >Best Regards,
> >J.
> >  drivers/ata/pata_at91.c |   43 +++++++++++++++++++++----------------------
> >  1 files changed, 21 insertions(+), 22 deletions(-)
> 
> >diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> >index 5249e6d..c8d1154 100644
> >--- a/drivers/ata/pata_at91.c
> >+++ b/drivers/ata/pata_at91.c
> >@@ -207,11 +207,11 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
> >  {
> >  	int ret = 0;
> >  	int use_iordy;
> >+	struct sam9_smc_config smc;
> >  	unsigned int t6z;         /* data tristate time in ns */
> >  	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
> >  	unsigned int setup;       /* SMC Setup width in MCK ticks */
> >  	unsigned int pulse;       /* CFIOR and CFIOW pulse width in MCK ticks */
> >-	unsigned int cs_setup = 0;/* CS4 or CS5 setup width in MCK ticks */
> >  	unsigned int cs_pulse;    /* CS4 or CS5 pulse width in MCK ticks*/
> >  	unsigned int tdf_cycles;  /* SMC TDF MCK ticks */
> >  	unsigned long mck_hz;     /* MCK frequency in Hz */
> >@@ -244,26 +244,25 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
> >  	}
> >
> >  	dev_dbg(dev, "Use IORDY=%u, TDF Cycles=%u\n", use_iordy, tdf_cycles);
> >-	info->mode |= AT91_SMC_TDF_(tdf_cycles);
> >
> >  	/* write SMC Setup Register */
> >-	at91_sys_write(AT91_SMC_SETUP(info->cs),
> >-			AT91_SMC_NWESETUP_(setup) |
> >-			AT91_SMC_NRDSETUP_(setup) |
> >-			AT91_SMC_NCS_WRSETUP_(cs_setup) |
> >-			AT91_SMC_NCS_RDSETUP_(cs_setup));
> >+	smc.nrd_setup = setup;
> >+	smc.nwe_setup = smc.nrd_setup;
> >+	smc.ncs_read_setup = 0;
> >+	smc.ncs_write_setup = smc.ncs_read_setup;
> 
>    Why not:
> 
> 	smc.nrd_setup = smc.nwe_setup = setup;
> 	smc.ncs_read_setup = smc.ncs_write_setup = 0;
why not

Best Regards,
J.
