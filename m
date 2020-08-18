Return-Path: <SRS0=mRqE=B4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA13DC433DF
	for <linux-ide@archiver.kernel.org>; Tue, 18 Aug 2020 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0F3207DE
	for <linux-ide@archiver.kernel.org>; Tue, 18 Aug 2020 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkJQeBD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRNFt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgHRNFQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Aug 2020 09:05:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB27C061345;
        Tue, 18 Aug 2020 06:05:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so9382202pjb.3;
        Tue, 18 Aug 2020 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pwfLT3a+GHxpttTxhdKznWycfaefCqBgiAPgz6BJmtY=;
        b=HkJQeBD5RoedbtQ3hdyc9mVT3V3Wm52mIEQ8fUV+kXzwwZ+jTgbFyiKb7RmZ93qqme
         gAavNE7bb8gNdldcQR87zIEPLrakfEJ0pJkp7GQtVliBebOjI/wNHC65s4Ihpt2DsCMq
         WbycO9JRo46e4OBf+gsAbvjWRRYRJXfZpZKm63fkuY3ChIv5u3+VTNTLAo6QVRbw3yNZ
         dhO3lOf4RR2e8pwI1gfrxw4Dbak6tLWCRJAONIMi1OxTGt4e1ap+pLsHM3wxEAMVrGp7
         G1ovOufmVmk/ZUluGDT+SCK+i5IhKIV/Hd+XE+9ViiokyP9nhXvRBnRdFzlxuDyJeob7
         q97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwfLT3a+GHxpttTxhdKznWycfaefCqBgiAPgz6BJmtY=;
        b=Cmr6y8ZszAX9zxxfu9DnKQSTWdtBPznpssEXXIx/PAlLlS5Q/EygDUOF5wf7l5oNK3
         QPrP277nCAkBgoEcNKAzl4HsPTthV4YZMbup1Kkd8EuEgN40dFG0/Fe5oyl2f+KzEykH
         RWw0g5/KS820iwpU6XqD+J13vtSYBbK6MyNsrmpgbr1amQVXjpDdSziu/qrfssz60IKR
         y/1KbcbRW93Kjr+SlgcauOe4tqIkje60zIOLEruDGeXoSIk3hSeouZgj6omMWrL6rQvY
         KJoRfP1emldLNphhDoao1BXlAqiMV3TypfZ0q5r1ESC6aC3KodD6kMe6a01+jLR4p2+2
         Hp4g==
X-Gm-Message-State: AOAM533gKXvBJY8FMoTrPP7Co8KSfLj9dqhy6phOm1D185i17vNm9DpI
        h9IFtVtlI0biMjIQT5uv68g=
X-Google-Smtp-Source: ABdhPJwc5hrEFoEiKPxK3iuQJNxaRnHhfTDQfAxZpVW8kajYdWW9rkzCpNpBtHszvSibdhdi1EB6Nw==
X-Received: by 2002:a17:90a:ea0b:: with SMTP id w11mr15397420pjy.80.1597755915458;
        Tue, 18 Aug 2020 06:05:15 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id u14sm25042508pfm.103.2020.08.18.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 06:05:14 -0700 (PDT)
Date:   Tue, 18 Aug 2020 18:33:29 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
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
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] ata: use generic power management
Message-ID: <20200818130329.GA39194@gmail.com>
References: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
 <20200817092511.GA10566@gmail.com>
 <11190a0b-1009-caf8-9cbe-6cf296b614bf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11190a0b-1009-caf8-9cbe-6cf296b614bf@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 17, 2020 at 07:06:03AM -0700, Jens Axboe wrote:
> On 8/17/20 2:25 AM, Vaibhav Gupta wrote:
> > Hello,
> > 
> > I am working to upgrade power management framework support for PCI drivers, as
> > my project under the Linux Kernel Mentorship Program.
> > 
> > The ultimate goal is to completely remove the legacy framework. And for this we
> > need to remove ".suspend" and ".resume" pointers from "struct pci_driver".
> > 
> > The patch is doing the change for the same. The actual suspend() and
> > resume() callbacks are defined in drivers/ata/libata-core.c and are exported.
> > Which are then used by other files.
> > 
> > Thus removing those pointers, included 54 files in this patch. Although, the
> > actual changes are done in few files only. The changes should work fine as I
> > have done similar changes for other drivers too which made their way into the
> > kernel. Still, tests on few ata devices are necessary.
> 
> Didn't we agree to split this up into separate patches??
> 
> > I tried but unfortunately, I couldn't find or arrange devices to test upon. I
> > have added the authors of the previous commit(s) for respective drivers as
> > recipients. It would be very helpful if someone can test it on a device.
> 
> Does qemu support any of the affected drivers?
> 
Hello Jens,
Yes we discussed about splitting it and I will surely do it. I just thought that
still it has not got tested and in that case keeping check on patch-series with
55+ patches may become somewhat messy. Moreover, to test any driver one will
have to apply the patch for libata-core and then that of the driver.
So, I sent this v3 in order to get some help for the testing purpose. Once it
goes successful, I can split it and send it for the submission.

I am not sure about qemu, I haven't checked for it. Qemu will be appropriate
for testing power management for .suspend() and .resume() callbacks?

Thanks
Vaibhav Gupta
> -- 
> Jens Axboe
> 
