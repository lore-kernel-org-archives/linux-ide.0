Return-Path: <SRS0=oFzF=6R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF5EC28CBC
	for <linux-ide@archiver.kernel.org>; Sun,  3 May 2020 21:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2B5206EB
	for <linux-ide@archiver.kernel.org>; Sun,  3 May 2020 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588542391;
	bh=GBGCkhxLK9ereAx0GcQnVpnlPY3m3AUtgAJvWygV8lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LhngO2FTlPISGYvkvs5Di+TOAA/FiFuui1Re8vCrB5Hh8+N8URxyeiEluO/9dX360
	 EB9MGp1N0mg5AZm+LRoIC6zIp8/Wqo8RpDKdIQy8R0BihXbBx4kK+qxOChUFertTM+
	 r1TlJzhSDQLpXT1F/kwHO8CYX0SyGd8RyMARIdVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgECVqa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 May 2020 17:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbgECVqa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 3 May 2020 17:46:30 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61519206B9;
        Sun,  3 May 2020 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588542389;
        bh=GBGCkhxLK9ereAx0GcQnVpnlPY3m3AUtgAJvWygV8lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfNDkH2osiIRVWaHRKquVVacc40DjLOz6VoO/VHWZN5xxrAYRnnr/Iq+j4Xpd56QQ
         QQXWwxuHCD4jtPSeWrVRfkCGIkqtUKtnNkT3Z9x0y5sVDEG5prW2/Mj7IY5RZpHioD
         okDQebXI8EwXI4bn/MIuGGT460B1LmXp0Tqm8S1w=
Received: by pali.im (Postfix)
        id 6A5E7F28; Sun,  3 May 2020 23:46:27 +0200 (CEST)
Date:   Sun, 3 May 2020 23:46:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20200503214627.gerb3ipcwek2h3h7@pali>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
 <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Monday 27 January 2020 12:24:28 Sascha Hauer wrote:
> On Mon, Jan 27, 2020 at 12:16:30PM +0100, Pali Rohár wrote:
> > On Monday 06 January 2020 09:16:05 Sascha Hauer wrote:
> > > On Wed, Dec 25, 2019 at 07:18:40PM +0100, Pali Rohár wrote:
> > > > Hello Sascha!
> > > > 
> > > > On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> > > > > ata_qc_complete_multiple() is called with a mask of the still active
> > > > > tags.
> > > > > 
> > > > > mv_sata doesn't have this information directly and instead calculates
> > > > > the still active tags from the started tags (ap->qc_active) and the
> > > > > finished tags as (ap->qc_active ^ done_mask)
> > > > > 
> > > > > Since 28361c40368 the hw_tag and tag are no longer the same and the
> > > > > equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> > > > > initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> > > > > started and this will be in done_mask on completion. ap->qc_active ^
> > > > > done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> > > > > the internal tag will never be reported as completed.
> > > > > 
> > > > > This is fixed by introducing ata_qc_get_active() which returns the
> > > > > active hardware tags and calling it where appropriate.
> > > > > 
> > > > > This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> > > > > problem. There is another case in sata_nv that most likely needs fixing
> > > > > as well, but this looks a little different, so I wasn't confident enough
> > > > > to change that.
> > > > 
> > > > I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> > > > version correctly. More details are in email:
> > > > 
> > > > https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
> > > > 
> > > > I tried this patch and it fixed above problems with sata_nv.ko. It just
> > > > needs small modification (see below).
> > > > 
> > > > So you can add my:
> > > > 
> > > > Tested-by: Pali Rohár <pali.rohar@gmail.com>
> > > > 
> > > > And I hope that patch would be backported to 4.18 and 4.19 stable
> > > > branches soon as distributions kernels are broken for machines with
> > > > these nvidia sata controllers.
> > > > 
> > > > Anyway, what is that another case in sata_nv which needs to be fixed
> > > > too?
> > > 
> > > It's in nv_swncq_sdbfis(). Here we have:
> > > 
> > > 	sactive = readl(pp->sactive_block);
> > > 	done_mask = pp->qc_active ^ sactive;
> > > 
> > > 	pp->qc_active &= ~done_mask;
> > > 	pp->dhfis_bits &= ~done_mask;
> > > 	pp->dmafis_bits &= ~done_mask;
> > > 	pp->sdbfis_bits |= done_mask;
> > > 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> > > 
> > > Sascha
> > 
> > Ok. Are you going to fix also this case?
> 
> As said, this one looks slightly different than the others and I would
> prefer if somebody could fix it who actually has a hardware and can test
> it.

Well, I have hardware and could test changes. But I'm not really sure
that I understand this part of code. So it would be better if somebody
else with better knowledge prepares patches I could test them. But
currently during coronavirus I have only remote ssh access, so boot,
modify/compile/reboot process is quite slower.
