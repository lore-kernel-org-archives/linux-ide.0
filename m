Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740710;
	b=ShJTCzyPQHQ0+X/nJLiz8ech0Y4o+ED6fgeFMav5OuR3r1tHZWD0etm+yLshzKtlgvbw
	 GdwXSj0uIkW6wA5gv8t2qju8vj8Sre4bI9HdPDYjcIAymI8i4DqG5fDOYgwLHeCFGLZf3
	 aRB0O4VLI1BWiexHiZXfZAww1kUQTanJ0YiUnfKOh7nacG0QU8Rul6F1GiQgyGAGi+vs/
	 GQ9YIYwqBPIgF0yzIZUi7OYS86KiHOGK+3/6BaZSlzf6voHDAiPpngdz/RqVBC/CqrrGO
	 usAfplBAZ8nyUypRP16wZNTIj/asr4804oNY+5UOfDSFOeiBeVk+I5oY3mVqUGd0YMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AQeTKRIXaKBHBv9GRp0SBIJBwg8ZzQZgPBC+KPG3sx0=;
	b=daToh7KM/CWaKSzQIcJnQp9WTTl6hPeIkoN12G638D0ZggiHDHmQ6hfXCQ6U2MpymPxE
	 bIZR/YXhrywJWOxf9nzt+tyeb6HDHk206Y9fZdAE/1hU33mhwcgCKSVTSiUgGpvOiq2kD
	 WYks7mbwSmWyklnj7WpIKKl/4PEiYphydeNnB1QxQKsKraOv9FLB414vq2pnxMhg2GWzT
	 JT/G39I0d7Bw7qd5RQsaR+9m1HpK0P3rgMk6FDCNsn1gwdL7w+TKMZGh/UxRyCYrWbACZ
	 ImLaFQJ3n/3w6WB7UjCRTIMqKKRHFHJcf46iGWZDjDpjgaAO8eoqABkP6fRzsHRaRBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbRUW6Sk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30938606A324
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbRUW6Sk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED02E1F00919;
	Tue,  3 Nov 2026 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740709;
	bh=AQeTKRIXaKBHBv9GRp0SBIJBwg8ZzQZgPBC+KPG3sx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cbRUW6SkMMDqlVAHRoD/UsA0MC3VIECpnWgdnElK2Fn6soMC3C2PCxC4x1x6aEJgC
	 3z2WF0iPgYFNLmmnKqCk14+EDOTbW6zsf3TmttefuCyrxpYisLTNa4K6uWjh6j2D5j
	 2cyXGpf/G+Ce6qJZKhxOu95OCU0bM0Qa7M8wDga+LlGtprXnHvAS98xRHPAUpLgm+7
	 O75hE9IQvSySDqOFcpggZ9JZxghC4goqppenJEJLzuaVPDuJRI/lKTy921HyRgiSLX
	 KuQnBkr6JVLDl3myXfY660mVhnafyA+VLj2WMSCqipc6U0h+51nZ+GdpQGYADDWKAO
	 mRAbQtOxIf1sA==
Date: Tue, 3 Nov 2026 22:18:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: set the field pointer when rejecting
 CDL
Message-ID: <aupPouIrF_SkU0jz@ryzen>
References: <202610291903148135Df-fh-xl3zWuRJkq8AXn@zte.com.cn>
 <aupMUrNn7PkrJg6W@ryzen>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aupMUrNn7PkrJg6W@ryzen>

On Tue, Nov 03, 2026 at 10:04:18PM +0100, Niklas Cassel wrote:
> Hello Shao,
> 
> On Thu, Oct 29, 2026 at 07:03:14PM +0800, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> > 
> > ata_mselect_control_ata_feature() rejects enabling CDL while NCQ
> > priority is enabled, but unlike its other error branches it returns
> > without setting *fp.
> > 
> > ata_scsi_mode_select_xlat() initializes fp to 0xffff and, when the
> > handler fails, adds the mode select header and block descriptor lengths
> > to it.  The resulting sense data then reports a field pointer far
> > outside of the submitted parameter list instead of the byte that has to
> > be changed.
> > 
> > Set *fp to the beginning of the mode page data, as the other branches of
> > this function do.
> > 
> > Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> > ---
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 5cde90fe594e..c07c1ff09757 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -4494,6 +4494,7 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
> >  		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
> >  			ata_dev_err(dev,
> >  				"NCQ priority must be disabled to enable CDL\n");
> > +			*fp = 0;
> >  			return -EINVAL;
> >  		}
> >  		ata_dev_dbg(dev, "Enabling CDL\n");
> 
> 
> Setting fp to zero looks very wrong to me, even though with the current
> overly complicated code where buf and fp was using completely different
> offsets, it was actually correct.

Sorry, to clarify, 0 would have been wrong anyway, but because of existing
bugs in ata_scsi_mode_select_xlat() related to fp, not because your patch
was wrong:
https://lore.kernel.org/linux-ide/20261103205448.931471-10-cassel@kernel.org

  Parameter list                                     Before After Correct
  CDL enable while NCQ priority is enabled                7    12      12


Kind regards,
Niklas
