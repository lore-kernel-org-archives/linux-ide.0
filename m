Return-Path: <SRS0=ghXF=AZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF5FC433E4
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE5E21835
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Darf2Q0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGNIZx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGNIZw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2020 04:25:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD0C061755;
        Tue, 14 Jul 2020 01:25:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so7291378pgm.2;
        Tue, 14 Jul 2020 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZWUwJu20ntegLxeLLUqqY9GoM4PIf6WDr0U1QRPCyz8=;
        b=Darf2Q0a0jpRgttYMoFvMgwq+LwapC98MDClJbfjYU8niFJTsvIYg6qqG7+YyGSl4g
         BVANOvMGHizpFJIsXFlORc9YkqZfSREZPfQLDljPrd7WdN//n51wc8ZJ2z6bJZCuYdP4
         JfhNJ7sK5U/fsWuDuMkaknhLm0fmeiLZrOhJl5rer8nGCqprfezgCAsgCaP86lWGd/RD
         rz5h0+PEC7Fnob8KbAu/ELHee03RVnZHqTaarQbQcpTjzIm7dXudutq+AT812XR4rye2
         JWfMWoZkhXeBCrKavWJswfO1LkV6ma0ssNQxlxNEG8NPUQBYt5v9y459teksLszUzRjl
         yrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWUwJu20ntegLxeLLUqqY9GoM4PIf6WDr0U1QRPCyz8=;
        b=Vp1qHrWE7u27JgmPkKDYhJdYiyJtDX7CDTmoqDRFOCnMIL/lEaxIWp4wCi8/LiVZ5n
         D9krTzUSGt1vPq4THjGo6XwjpeFMHmxwzWqh1D4YAQha3IWQsQ6DlqRoJ4BCFw0dnl/H
         l6qvntsytDvvwX0fA7/BYrM/bhYVpAsAm4czbpfECBbplnaXYVvvOfUt/LSoBLIUSkLT
         Z02+xoUdbayL7wyRW5DVtGX6zMxpFr2EZK8yg8M0ICyArAMCaZVSKBr06ojQyW5M1aSo
         b4QR7elzQEfkMlOJjj3+Qb0b+egYhYf+4B3+d7E2WTvMw6/NDeohVE+rynTjmVh832Qj
         qRIQ==
X-Gm-Message-State: AOAM531dFlJpMTi0hLC2QBcaskf9dRnJnny6L5bS0DqYrmzPa+Sk0QYY
        jyVuWOjfT1khO1wp8T13dV1LcTg5aMs=
X-Google-Smtp-Source: ABdhPJygF5X1M5e9T6GC2BhRd2ugrdwtEBpQe4L+h8fYZn97BoUouscBcjxQDAIzI2+9+Tnii+xgvQ==
X-Received: by 2002:a63:9342:: with SMTP id w2mr2554954pgm.20.1594715152238;
        Tue, 14 Jul 2020 01:25:52 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id i21sm16683167pfa.18.2020.07.14.01.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:25:51 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:54:26 +0530
From:   Vaibhav Gupta <vaibhav.varodek@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: ide: use generic power management
Message-ID: <20200714082426.GA5817@gmail.com>
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
 <CGME20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed@eucas1p1.samsung.com>
 <3b26bfff-7a42-7bbe-2050-51fe1ce96d4e@samsung.com>
 <20200714075247.GA4859@gmail.com>
 <834eb293-bd4f-626c-4558-fbf71a5999f0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <834eb293-bd4f-626c-4558-fbf71a5999f0@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jul 14, 2020 at 10:19:06AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 7/14/20 9:52 AM, Vaibhav Gupta wrote:
> > On Tue, Jul 14, 2020 at 09:32:56AM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >>
> >> IDE subsystem (drivers/ide/) is deprecated and has been superseded by libata
> >> subsystem (drivers/ata/).
> >>
> >> libata drivers have the same issue so please concentrate on fixing them
> >> first. Later (if desirable) changes can be back-ported to drivers/ide/.
> >>
> > Hello, (drivers/ide) and (drivers/ata) are the two major families, I am working
> > on, for generic PM upgradation. I was bit unaware about priority, and also in
> > the last, both ide and ata drivers have to be upgraded.
> 
> Well, drivers/ide/ is scheduled for removal in 2021
> (it even prints the warning during initialization of
> every host driver)..
Okay then, I will start with ata family.

Thanks,
Vaibhav Gupta
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> >>> All patches are compile-tested only.
> >>
> >> This patchset needs (at least) some basic testing. It should be easier with
> >> libata subsystem as it also support SATA controllers and devices.
> > To upgrade PM in (drivers/ide) I have made .suspend() and .resume() static. Then
> > bind them in "struct dev_pm_ops" variable (ide_pci_pm_ops) and expose it using
> > EXPORT_SYMBOL_GPL(). This has affected 30 drivers. I was hoping if ide changes
> > can be tested/verified, specially [PATCH 1/3]. As then, I will be sure about
> > similar change in ata, as it also requires similar alteration.
> > 
> > Thanks
> > Vaibhav Gupta
> > 
> >>
> >> Best regards,
> >> --
> >> Bartlomiej Zolnierkiewicz
> >> Samsung R&D Institute Poland
> >> Samsung Electronics
> >>
