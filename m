Return-Path: <SRS0=ghXF=AZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441CC433DF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4292145D
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gge+R7Cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgGNHz2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNHz1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2020 03:55:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44932C061755;
        Tue, 14 Jul 2020 00:55:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so1202351pje.0;
        Tue, 14 Jul 2020 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fr0V53mp8gct+D0reFrcGwuhnT+2GL17XE1iCQ4XpVI=;
        b=Gge+R7Cg1yjg9iL0BE17WXm/g57Pn9HkIqT9YWBxp3KwEuFAuIKRHcUTDBv+cfSrw/
         TCX4qy6GgGFW2X9szsU0k0gIVmtwIttwLGTU6F41pDjCbQ+iHoVmKCvafswEIUVV8XBf
         hSQ7d8lx6G6vhNG77N2nhuI5T8zrVnxRUK3z5buqAlloqXOX++ivVBoemEt5Mdx36fwP
         ZnWJKqbOBv5Ixlv5VVRMpYoNoA/OnZEStGi+wSU1eKMGCFWhp1IvmXseHBMiVq9Xnab9
         yKUeYIUckh1drup9zfAUbZw4/tW+VBxl3B3N2Am7QgSV1XZvaW+1tN+ZnK7NKCzowEkL
         dR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fr0V53mp8gct+D0reFrcGwuhnT+2GL17XE1iCQ4XpVI=;
        b=kz7ZTUMK/Gy3jDx06AZneTlPBdjctDJXhSS4row8Dr39KzNgB7141sUoEjEV7eTWNc
         YCLUrOUBSQKKddCUsGzkBk65kLLPgJKF7DkIuHqzXRabGZsTYdmvL7X3Tl6HSnBOxXmE
         hwbqGEZw9wSPOBa1KG7nrSYVF644ZTLzzzlZo0gZiqkjL6dt6h9KCwP59DcSOn7uxh6R
         ueUpiCP0MjfRtSdtd05OLY9dUdVnuGZ/Ej2iI3i3QvvD2xeninpy8SG86HCKbG4FYQ5T
         I1GRrDT3PnxtICvg+R01Zblj8fF+bkFfccfeCgTmXtXX0wbDX1sB/gtlH99KcDOFhCDp
         sSpQ==
X-Gm-Message-State: AOAM531orLf+47jRVGRjptu7whdzq0e7/3ew0O+tkNJlcOuM/6oskYo6
        /5V5dcQQSryALGJXOolsJ8M=
X-Google-Smtp-Source: ABdhPJzYDyYtVsFITfsqj3tmWGRYr2P9068LqybFQZ8fMOdrTVGKRYAQj1kQKJCIXWH+Eqx1bL7jEQ==
X-Received: by 2002:a17:90a:c794:: with SMTP id gn20mr3174778pjb.114.1594713326762;
        Tue, 14 Jul 2020 00:55:26 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id p19sm15100868pgj.74.2020.07.14.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 00:55:26 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:22:47 +0530
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
Message-ID: <20200714075247.GA4859@gmail.com>
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
 <CGME20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed@eucas1p1.samsung.com>
 <3b26bfff-7a42-7bbe-2050-51fe1ce96d4e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b26bfff-7a42-7bbe-2050-51fe1ce96d4e@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jul 14, 2020 at 09:32:56AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 7/13/20 7:36 PM, Vaibhav Gupta wrote:
> > Linux Kernel Mentee: Remove Legacy Power Management.
> > 
> > The purpose of this patch series is to remove legacy power management callbacks
> > from ide drivers.
> > 
> > The suspend() and resume() callbacks operations are still invoking
> > pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
> > etc. and handling the power management themselves, which is not recommended.
> > 
> > The conversion requires the removal of the those function calls and change the
> > callback definition accordingly and make use of dev_pm_ops structure.
> 
> IDE subsystem (drivers/ide/) is deprecated and has been superseded by libata
> subsystem (drivers/ata/).
> 
> libata drivers have the same issue so please concentrate on fixing them
> first. Later (if desirable) changes can be back-ported to drivers/ide/.
>
Hello, (drivers/ide) and (drivers/ata) are the two major families, I am working
on, for generic PM upgradation. I was bit unaware about priority, and also in
the last, both ide and ata drivers have to be upgraded.
> > All patches are compile-tested only.
> 
> This patchset needs (at least) some basic testing. It should be easier with
> libata subsystem as it also support SATA controllers and devices.
To upgrade PM in (drivers/ide) I have made .suspend() and .resume() static. Then
bind them in "struct dev_pm_ops" variable (ide_pci_pm_ops) and expose it using
EXPORT_SYMBOL_GPL(). This has affected 30 drivers. I was hoping if ide changes
can be tested/verified, specially [PATCH 1/3]. As then, I will be sure about
similar change in ata, as it also requires similar alteration.

Thanks
Vaibhav Gupta

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > v3:
> >     - Modpost error for undefined reference by Kbuild in v1.
> >     - Another approach to disable PM in drivers/ide/triflex.c suggested by
> >       Bjorn Helgaas in v2.
> > 
> > Test tools:
> >     - Compiler: gcc (GCC) 10.1.0
> >     - allmodconfig build: make -j$(nproc) W=1 all
> > 
> > Vaibhav Gupta (3):
> >   ide: use generic power management
> >   ide: sc1200: use generic power management
> >   ide: delkin_cb: use generic power management
> > 
> >  drivers/ide/aec62xx.c         |  3 +--
> >  drivers/ide/alim15x3.c        |  3 +--
> >  drivers/ide/amd74xx.c         |  3 +--
> >  drivers/ide/atiixp.c          |  3 +--
> >  drivers/ide/cmd64x.c          |  3 +--
> >  drivers/ide/cs5520.c          |  3 +--
> >  drivers/ide/cs5530.c          |  3 +--
> >  drivers/ide/cs5535.c          |  3 +--
> >  drivers/ide/cs5536.c          |  3 +--
> >  drivers/ide/cy82c693.c        |  3 +--
> >  drivers/ide/delkin_cb.c       | 32 +++++---------------------
> >  drivers/ide/hpt366.c          |  3 +--
> >  drivers/ide/ide-pci-generic.c |  3 +--
> >  drivers/ide/it8172.c          |  3 +--
> >  drivers/ide/it8213.c          |  3 +--
> >  drivers/ide/it821x.c          |  3 +--
> >  drivers/ide/jmicron.c         |  3 +--
> >  drivers/ide/ns87415.c         |  3 +--
> >  drivers/ide/opti621.c         |  3 +--
> >  drivers/ide/pdc202xx_new.c    |  3 +--
> >  drivers/ide/pdc202xx_old.c    |  3 +--
> >  drivers/ide/piix.c            |  3 +--
> >  drivers/ide/sc1200.c          | 43 ++++++++++++-----------------------
> >  drivers/ide/serverworks.c     |  3 +--
> >  drivers/ide/setup-pci.c       | 29 +++++------------------
> >  drivers/ide/siimage.c         |  3 +--
> >  drivers/ide/sis5513.c         |  3 +--
> >  drivers/ide/sl82c105.c        |  3 +--
> >  drivers/ide/slc90e66.c        |  3 +--
> >  drivers/ide/triflex.c         | 24 +++++++------------
> >  drivers/ide/via82cxxx.c       |  3 +--
> >  include/linux/ide.h           |  8 +------
> >  32 files changed, 62 insertions(+), 155 deletions(-)
> > 
> 
