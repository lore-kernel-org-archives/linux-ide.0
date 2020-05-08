Return-Path: <SRS0=7pxr=6W=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A67C38A2A
	for <linux-ide@archiver.kernel.org>; Fri,  8 May 2020 05:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3907820870
	for <linux-ide@archiver.kernel.org>; Fri,  8 May 2020 05:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgEHFqr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 8 May 2020 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHFqr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2020 01:46:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF05C05BD43
        for <linux-ide@vger.kernel.org>; Thu,  7 May 2020 22:46:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jWvqP-0007iP-3D; Fri, 08 May 2020 07:46:45 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jWvqO-0003zb-Fq; Fri, 08 May 2020 07:46:44 +0200
Date:   Fri, 8 May 2020 07:46:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Pali =?iso-8859-15?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20200508054644.GJ5877@pengutronix.de>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
 <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
 <20200503214627.gerb3ipcwek2h3h7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200503214627.gerb3ipcwek2h3h7@pali>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:38:54 up 78 days, 13:09, 81 users,  load average: 0.04, 0.11,
 0.13
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, May 03, 2020 at 11:46:27PM +0200, Pali Rohár wrote:
> On Monday 27 January 2020 12:24:28 Sascha Hauer wrote:
> > On Mon, Jan 27, 2020 at 12:16:30PM +0100, Pali Rohár wrote:
> > > On Monday 06 January 2020 09:16:05 Sascha Hauer wrote:
> > > > On Wed, Dec 25, 2019 at 07:18:40PM +0100, Pali Rohár wrote:
> > > > > Hello Sascha!
> > > > > 
> > > > > On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> > > > > > ata_qc_complete_multiple() is called with a mask of the still active
> > > > > > tags.
> > > > > > 
> > > > > > mv_sata doesn't have this information directly and instead calculates
> > > > > > the still active tags from the started tags (ap->qc_active) and the
> > > > > > finished tags as (ap->qc_active ^ done_mask)
> > > > > > 
> > > > > > Since 28361c40368 the hw_tag and tag are no longer the same and the
> > > > > > equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> > > > > > initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> > > > > > started and this will be in done_mask on completion. ap->qc_active ^
> > > > > > done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> > > > > > the internal tag will never be reported as completed.
> > > > > > 
> > > > > > This is fixed by introducing ata_qc_get_active() which returns the
> > > > > > active hardware tags and calling it where appropriate.
> > > > > > 
> > > > > > This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> > > > > > problem. There is another case in sata_nv that most likely needs fixing
> > > > > > as well, but this looks a little different, so I wasn't confident enough
> > > > > > to change that.
> > > > > 
> > > > > I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> > > > > version correctly. More details are in email:
> > > > > 
> > > > > https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
> > > > > 
> > > > > I tried this patch and it fixed above problems with sata_nv.ko. It just
> > > > > needs small modification (see below).
> > > > > 
> > > > > So you can add my:
> > > > > 
> > > > > Tested-by: Pali Rohár <pali.rohar@gmail.com>
> > > > > 
> > > > > And I hope that patch would be backported to 4.18 and 4.19 stable
> > > > > branches soon as distributions kernels are broken for machines with
> > > > > these nvidia sata controllers.
> > > > > 
> > > > > Anyway, what is that another case in sata_nv which needs to be fixed
> > > > > too?
> > > > 
> > > > It's in nv_swncq_sdbfis(). Here we have:
> > > > 
> > > > 	sactive = readl(pp->sactive_block);
> > > > 	done_mask = pp->qc_active ^ sactive;
> > > > 
> > > > 	pp->qc_active &= ~done_mask;
> > > > 	pp->dhfis_bits &= ~done_mask;
> > > > 	pp->dmafis_bits &= ~done_mask;
> > > > 	pp->sdbfis_bits |= done_mask;
> > > > 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> > > > 
> > > > Sascha
> > > 
> > > Ok. Are you going to fix also this case?
> > 
> > As said, this one looks slightly different than the others and I would
> > prefer if somebody could fix it who actually has a hardware and can test
> > it.
> 
> Well, I have hardware and could test changes. But I'm not really sure
> that I understand this part of code. So it would be better if somebody
> else with better knowledge prepares patches I could test them. But
> currently during coronavirus I have only remote ssh access, so boot,
> modify/compile/reboot process is quite slower.

Ok, here we go. Compile tested only.

Regards,
 Sascha

------------------------------8<-----------------------------------

From fcdcfa9e7a4ee4faf411de1df4f3c4e12c78545c Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 8 May 2020 07:28:19 +0200
Subject: [PATCH] ata: sata_nv: Fix retrieving of active qcs

ata_qc_complete_multiple() has to be called with the tags physically
active, that is the hw tag is at bit 0. ap->qc_active has the same tag
at bit ATA_TAG_INTERNAL instead, so call ata_qc_get_active() to fix that
up. This is done in the vein of 8385d756e114 ("libata: Fix retrieving of
active qcs").

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/sata_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index eb9dc14e5147..20190f66ced9 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2100,7 +2100,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 	pp->dhfis_bits &= ~done_mask;
 	pp->dmafis_bits &= ~done_mask;
 	pp->sdbfis_bits |= done_mask;
-	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
+	ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
 
 	if (!ap->qc_active) {
 		DPRINTK("over\n");
-- 
2.26.2

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
