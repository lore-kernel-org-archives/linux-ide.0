Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2334C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D202072E
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0jcnI9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgHQJ1D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHQJ1C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2020 05:27:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B9C061389;
        Mon, 17 Aug 2020 02:27:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so7414925pjb.1;
        Mon, 17 Aug 2020 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rj6QAfp7fK0l7e7qFTK0S101pCtERJaPK3wMNiuezuY=;
        b=U0jcnI9S/jFzGDnvfm0t7CpqXvnyBzY4klINeV9Qgxl6g7KRhDVeAgua2xpHY3b8Lw
         XZXsUdrM5cQhpLB75CHifTZ9IHODvopA22F4njsuxi/eVy78Cv0TPbyLfJVAZGomuxGo
         eLqCJlNMwP7zjCwLGNJ15rwNg8uo05wxki0/A6ySGyeX+jwzOYZi/Klh9oarQu95UW3J
         QcOizn8dPSbPaGrvX5Ip+z2dO9mZg2ernZBrwfbj+o8kPeePADEUJ4Ys63aQltpk3eCS
         lUlCgurWWMAc3rXbwLrohpq4cqzxyrASROHsbjnAOJHVWMCkSYB5atU7zN0EbC5uPGGG
         AzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rj6QAfp7fK0l7e7qFTK0S101pCtERJaPK3wMNiuezuY=;
        b=fncFLbuzmusDFaZrz4EX2qZmuiBY/ry88/DGbHLUVkK82hpjgQt6rDFTg451lgERzM
         IdpwB69OgZIex39g1lXMgmKhv/JVOcUn1h6kDBOn3Qmxbgp0f41u3Xy1gY4T2X0/AV4I
         QB2OpsPx9q+l6bjCUp92x8nN9MJj/gIZibWnoomoT3I6oTN6HdVNfHpOHpXiaYXChHmc
         vUFBTyZoSXmJpmAPQG0Y2dX0X5tWOBqIePA7zG7e6fkBMjeMO68hoKonObLiWsR3OWnS
         sv+ZkDFnbdqespOVGV41bsxI5JN5HlRwhsfC/BPPT/5bn8ZR0Q8vnu2CJKUsuT5D6QJ0
         t07Q==
X-Gm-Message-State: AOAM530XeB3WqCUkB7w98yrpYdY2MNuAxhLNg0j6+0HA4N8zGsc3jOM/
        o6qOx/stt4ZCQVsRkuGD7us=
X-Google-Smtp-Source: ABdhPJz6lYnPyu0mQrpiz1HjSnbolwJUpaJy7iVIhiwHyzlwegTyNekAgYgri6gIqN+wwTIAdHUnAw==
X-Received: by 2002:a17:90a:230d:: with SMTP id f13mr11126659pje.116.1597656420344;
        Mon, 17 Aug 2020 02:27:00 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id e4sm18904633pfd.204.2020.08.17.02.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:26:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:55:11 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] ata: use generic power management
Message-ID: <20200817092511.GA10566@gmail.com>
References: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello,

I am working to upgrade power management framework support for PCI drivers, as
my project under the Linux Kernel Mentorship Program.

The ultimate goal is to completely remove the legacy framework. And for this we
need to remove ".suspend" and ".resume" pointers from "struct pci_driver".

The patch is doing the change for the same. The actual suspend() and
resume() callbacks are defined in drivers/ata/libata-core.c and are exported.
Which are then used by other files.

Thus removing those pointers, included 54 files in this patch. Although, the
actual changes are done in few files only. The changes should work fine as I
have done similar changes for other drivers too which made their way into the
kernel. Still, tests on few ata devices are necessary.

I tried but unfortunately, I couldn't find or arrange devices to test upon. I
have added the authors of the previous commit(s) for respective drivers as
recipients. It would be very helpful if someone can test it on a device.

Thanks
Vaibhav Gupta
