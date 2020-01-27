Return-Path: <SRS0=fywD=3Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B96C32771
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0787620716
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHVm4rKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgA0LQd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:16:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37973 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA0LQd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jan 2020 06:16:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so1662364wmj.3;
        Mon, 27 Jan 2020 03:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZHMvxWSExnfzvozzoiiK4wClMeOsgnVyBWHpemQRo9s=;
        b=FHVm4rKfLNiJPHYWvzgfs/nn4g8yQNhrqD8j0c+2odMhabmoA2ddTaXXbP+V1BZOLG
         qsuZ7oPKkyrzj5NwC49d32DvlQA5IKONDNtqQd+SfPbxr33FTffvfarVNe9XrY6eUKB9
         F08iDak4HQuaL9qRSqbP4erHO13uByYKNentIdLtOCl9VhTD2j/m6tZtK2pE1rKfXht8
         7Kx3yHkKChA3bJh22JcCrUOauM8+38NG3pZPDhEDQjb6xH3ZlqqcEEuNlb/JvTg8AMs1
         PYyANTumkwCX+gSTcCzbEBmFf0zFnTRzTDPVEa/isvL1zpM/mctSr58NZtH86SU+Ug+x
         u7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZHMvxWSExnfzvozzoiiK4wClMeOsgnVyBWHpemQRo9s=;
        b=Cgs/qMp3Tn9YL32W14lE6gjZk2cawTgHA5T9siMauICDy5chTMkD5v0HTYCBUYzBv5
         wuPeK/ph8BKh9ynvDcjH7/IsPgGiL7okJP+lCWDK+GnLxtOTkql52YqI6JGtfDi/7Lr8
         cixgJneS/ZSSjwah2F9ZEZEP+McXE/6WWUTxVLs08OzXEj2/Svd3ID75DirVMcurAQ13
         dKYjamcQqdWNmkBkkttrLRa8GZKYSnmaFhRIEq4UwPmSOwjmfabFuxr6FmT2E7v7TNMe
         O/t2nI8wyVGfsHev08faPbcso5Hu0wvy+6T47Tuiu74umOd5nB5/HurgznVwfQyePDUf
         Lqrg==
X-Gm-Message-State: APjAAAX/G9k79+mmLiaV1AUj3LekVPmsY867Fqb4pngksUeKP7H5ICfz
        2GfaO8pQYlpMyhwhhRio3f8=
X-Google-Smtp-Source: APXvYqwR91RGkxftZpslELja6YtBXa5WMBKeTTjWXx5Zs4tXR3KM/KxQ3+hzLBWkRFSYQG+t2PP2Cg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr13254610wmi.0.1580123791552;
        Mon, 27 Jan 2020 03:16:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w20sm17584910wmk.34.2020.01.27.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 03:16:30 -0800 (PST)
Date:   Mon, 27 Jan 2020 12:16:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20200127111630.bqqzhj57tzt7geds@pali>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Monday 06 January 2020 09:16:05 Sascha Hauer wrote:
> On Wed, Dec 25, 2019 at 07:18:40PM +0100, Pali Rohár wrote:
> > Hello Sascha!
> > 
> > On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> > > ata_qc_complete_multiple() is called with a mask of the still active
> > > tags.
> > > 
> > > mv_sata doesn't have this information directly and instead calculates
> > > the still active tags from the started tags (ap->qc_active) and the
> > > finished tags as (ap->qc_active ^ done_mask)
> > > 
> > > Since 28361c40368 the hw_tag and tag are no longer the same and the
> > > equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> > > initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> > > started and this will be in done_mask on completion. ap->qc_active ^
> > > done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> > > the internal tag will never be reported as completed.
> > > 
> > > This is fixed by introducing ata_qc_get_active() which returns the
> > > active hardware tags and calling it where appropriate.
> > > 
> > > This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> > > problem. There is another case in sata_nv that most likely needs fixing
> > > as well, but this looks a little different, so I wasn't confident enough
> > > to change that.
> > 
> > I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> > version correctly. More details are in email:
> > 
> > https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
> > 
> > I tried this patch and it fixed above problems with sata_nv.ko. It just
> > needs small modification (see below).
> > 
> > So you can add my:
> > 
> > Tested-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > And I hope that patch would be backported to 4.18 and 4.19 stable
> > branches soon as distributions kernels are broken for machines with
> > these nvidia sata controllers.
> > 
> > Anyway, what is that another case in sata_nv which needs to be fixed
> > too?
> 
> It's in nv_swncq_sdbfis(). Here we have:
> 
> 	sactive = readl(pp->sactive_block);
> 	done_mask = pp->qc_active ^ sactive;
> 
> 	pp->qc_active &= ~done_mask;
> 	pp->dhfis_bits &= ~done_mask;
> 	pp->dmafis_bits &= ~done_mask;
> 	pp->sdbfis_bits |= done_mask;
> 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> 
> Sascha

Ok. Are you going to fix also this case?

-- 
Pali Rohár
pali.rohar@gmail.com
