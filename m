Return-Path: <SRS0=WsOc=EE=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18385C4363A
	for <linux-ide@archiver.kernel.org>; Thu, 29 Oct 2020 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B534820790
	for <linux-ide@archiver.kernel.org>; Thu, 29 Oct 2020 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603933258;
	bh=BxlMyj/ERhPQpajoGhj5wK+DMWvDJ3D2iMgwQXUd4fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fCGustHnO+bdzJMjYMPRgvdKHjDHR8EAVpY1BHsrtjNC+T+6Cwm5rC2v/KqNCIU9H
	 VW/eVwpskxOzlOdMZkNp6iauM1EriaR0QcANABAlwZYrQ/cxo427MT5wZMpQ1pvo4X
	 uS8tfuxqSReDpPUp26wTGw9wlhU/58fCA69JMAzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgJ2BAq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbgJ1WR2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CFC24728;
        Wed, 28 Oct 2020 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603893316;
        bh=BxlMyj/ERhPQpajoGhj5wK+DMWvDJ3D2iMgwQXUd4fA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFGDIVecxXHb7KAfE/gTEJw/IdQ5B4BhfoMt17zAWKNQHQchkXqQvDtrFLTW5/0UC
         lPio3FnnBEHCUW/utdXc/Nb26Y6bwaxOGTVG+eGSkpQg9pQrGOlLaSHJOQIx4myUL+
         feIqJHwJ6vsAx1FpoPFF4s2gUO5vB14sYwQu/UNM=
Received: by pali.im (Postfix)
        id 51D1ACB4; Wed, 28 Oct 2020 14:55:14 +0100 (CET)
Date:   Wed, 28 Oct 2020 14:55:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20201028135514.r2m3kxchbg6nljht@pali>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
 <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
 <20200503214627.gerb3ipcwek2h3h7@pali>
 <20200508054644.GJ5877@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200508054644.GJ5877@pengutronix.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Friday 08 May 2020 07:46:44 Sascha Hauer wrote:
> From fcdcfa9e7a4ee4faf411de1df4f3c4e12c78545c Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Fri, 8 May 2020 07:28:19 +0200
> Subject: [PATCH] ata: sata_nv: Fix retrieving of active qcs
> 
> ata_qc_complete_multiple() has to be called with the tags physically
> active, that is the hw tag is at bit 0. ap->qc_active has the same tag
> at bit ATA_TAG_INTERNAL instead, so call ata_qc_get_active() to fix that
> up. This is done in the vein of 8385d756e114 ("libata: Fix retrieving of
> active qcs").
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I tested this second change on nforce4 box with sata_nv controllers:

  00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0054] (rev f3)
  00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0055] (rev f3)

Both disks are working fine, I do not see any regression or change, so
you can add my:

Tested-by: Pali Rohár <pali@kernel.org>

Ideally add also Fixes line:

Fixes: 28361c403683 ("libata: add extra internal command")

Jens, do you need something more from me? Some special tests, etc?

> ---
>  drivers/ata/sata_nv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index eb9dc14e5147..20190f66ced9 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -2100,7 +2100,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  	pp->dhfis_bits &= ~done_mask;
>  	pp->dmafis_bits &= ~done_mask;
>  	pp->sdbfis_bits |= done_mask;
> -	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> +	ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>  
>  	if (!ap->qc_active) {
>  		DPRINTK("over\n");
> -- 
> 2.26.2
