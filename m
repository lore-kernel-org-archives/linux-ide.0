Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E218C61DA4
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 07:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBNHHP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjBNHHG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2023 02:07:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD51EFF5;
        Mon, 13 Feb 2023 23:06:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so10771047wmb.5;
        Mon, 13 Feb 2023 23:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RSNDSei1cvEI2TbZqPp2qztpn6EMY6rziZcsn0c1v4=;
        b=DGIGar2V45GyQ5EGa5cr2sHvNFhtS2/eCSc8t2a9Jy1U9vdQwNuXHfUCwlRsF0kkPi
         zp6W5I/bOvRFU44DkcAy90Fmm2pTaAjojOU5Rq3JKabZUsUf6ZmBSw2e+iDQDJopym9Y
         FfJUIy2c95Li1c1+w4nW+jkIlbnt5QaRqK3MU+EjSJ5X8+KAVh6jAQO0FSzEwNynvcRH
         e83jCJK3VeBfrKbyXjc2Awp43i18sjD3cp0fVTJRzViY43jy7w7GlKvl2NEeiCCoUZj+
         PEanH2j/NJB+doemDSu+IQcMNHPulM0Xo/lH9jm00QoZDG8Sm3rmi9zien0kCioIEQZ0
         SFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RSNDSei1cvEI2TbZqPp2qztpn6EMY6rziZcsn0c1v4=;
        b=J1KhbdCok+MdoVFxxWny59RdsSdHFIie+G4U/WYFHcY2u+O034jE4aHNzn9KxmBCJe
         yfdnh2+BO3HnsCKrFh9Cw/sVBXt13P2bw/3D3POISEU1ttPa46UnyJnjjqi4qQIPZTu8
         945YyDkIqIbZtAVEVe6eAuhrz+6Gt0rcniLdvAKUSO+tQJSzQ/tKJYR0dWruWwJc3DzN
         V+/0FEFRxxakORGofzjj1lxkv55V31wQttVxDW9zdfXdXZqC3hnsO+ZiJNrBN5dmpX6B
         +L/Xg1ixWiwQFeYLR65akytW8tjzFIbfL3f0dLdds65VAe7bt/Q7VSHuJ3IQIDmWdAMB
         FpfA==
X-Gm-Message-State: AO0yUKXgMiJRwSmRO/ZLE4SgHolRFdSLiDsCKsoPSTrFT8DuruJVyZZg
        IiJufUcWwBMIXrI5mFWqumvYSy68hhQ=
X-Google-Smtp-Source: AK7set+5/I+CAmLWWtV5fCxP5KSDYhsVKt723oHN1uONsZ1JTPM40/7jcY5v1b6hH1mIAbKe9mi6Ew==
X-Received: by 2002:a05:600c:1e14:b0:3df:9858:c033 with SMTP id ay20-20020a05600c1e1400b003df9858c033mr8516458wmb.8.1676358404333;
        Mon, 13 Feb 2023 23:06:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003e0015c8618sm19607599wmb.6.2023.02.13.23.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:06:43 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:06:39 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ata: pata_hpt3x2n: prevent potential forever loop in
 hpt3xn_calibrate_dpll()
Message-ID: <Y+sy/zldAljT5Sir@kadam>
References: <Y9pyzLUShZJeLDq7@kili>
 <48330abf-31ee-d0d1-7542-6d6a2de71dfc@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48330abf-31ee-d0d1-7542-6d6a2de71dfc@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Feb 14, 2023 at 12:47:52PM +0900, Damien Le Moal wrote:
> On 2/1/23 23:10, Dan Carpenter wrote:
> > This code accidentally reuses "tries" as the iterator for both the inside
> > and outside loops.  It means that the potentially the "tries" could be
> > reset to 0x1000 and never reach 0x5000.
> > 
> > Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/ata/pata_hpt3x2n.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
> > index 617c95522f43..447dc287a2d4 100644
> > --- a/drivers/ata/pata_hpt3x2n.c
> > +++ b/drivers/ata/pata_hpt3x2n.c
> > @@ -380,14 +380,14 @@ static int hpt3xn_calibrate_dpll(struct pci_dev *dev)
> >  {
> >  	u8 reg5b;
> >  	u32 reg5c;
> > -	int tries;
> > +	int tries, tries2;
> >  
> >  	for (tries = 0; tries < 0x5000; tries++) {
> >  		udelay(50);
> >  		pci_read_config_byte(dev, 0x5b, &reg5b);
> >  		if (reg5b & 0x80) {
> >  			/* See if it stays set */
> > -			for (tries = 0; tries < 0x1000; tries++) {
> > +			for (tries2 = 0; tries2 < 0x1000; tries2++) {
> >  				pci_read_config_byte(dev, 0x5b, &reg5b);
> >  				/* Failed ? */
> >  				if ((reg5b & 0x80) == 0)
> 
> I am assuming this one is the same as for pata_hpt37x: a false positive ?

Yes, sorry.

regards,
dan carpenter

