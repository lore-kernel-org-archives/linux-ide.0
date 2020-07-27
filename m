Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE2C433E4
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0C22070B
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex96dlh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgG0Rwp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG0Rwp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 13:52:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD9C061794;
        Mon, 27 Jul 2020 10:52:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so8487747pls.4;
        Mon, 27 Jul 2020 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4VCScZRbl2Kssf66LOgWwySs23Ntsbywsu3NL3678ak=;
        b=Ex96dlh+wuks3liR/urNzQZJVgLenPUAIj7Ed1wrcIQh6ZwCHVQwJ2OfuuZOzFxqhL
         KUXIQYhr54D4KMp98E456whL4BBIeMawzkY0ZuXWNmIZiQ3NLGtPNSdkCbK0FkkiE/lS
         Cqk1hdHNhLsbEasQS9o+Ccx8yqeiL0KL6LyMrF8ru3Ge2C9oVQTTqVYl5qdBTzd/r4sa
         TWRmgPzr8VpRUjVKGuvzlHs6a70Fb13VJBNCvtU4Dw6rRMWHuqQ4e8isJEIsWMekxPMk
         st9PA00EQAkiYyrF/kjpRLUIK/9+4FpG8oaJvHsshZu+cNRNCmVJCofG3XqNP5Rr732u
         wKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VCScZRbl2Kssf66LOgWwySs23Ntsbywsu3NL3678ak=;
        b=F/LuxPgdqs1iMhoxWCXlZQ6ae1MWzwl20BV1q8u4T9UK/KIKh83AcFEahNlO+/GVWE
         myCGWgpV0HQbBmj8pNPR7ZLDfj3z5On+D1nLTP6iVo6HZEeho2nmGdZEDdSDCjwFZj+9
         7OpA1AR/kTmUTiUdZYO/Yjvj370pjQvmgm4E6gV/GFs4+eQHa1flP4XFSL92W1du3vfk
         /9tLoyq8gzOeXO7VKu1zw6EeorQ7KCJD94YrXiuMAe1vn0CSnrERiDzmDW8yNvl9dF0V
         BRg+ESpg6XFEfzbVSmYWXYlqpOA3MW2clgEWDOY6TEEF7X79UciYJjxslCUPmRjETrMl
         XqFw==
X-Gm-Message-State: AOAM530j+y9VUV6RSkI4rjTihkM2k6KWe+30EhNFHGlmHvdJ4M2qVUu2
        0sZRzFX/zSLifMIrmRLgirY=
X-Google-Smtp-Source: ABdhPJzXEawmCxeONFI1GIOymjqICePldjpplnxMQ4v/+pEqGBpLiU8WhBycr0UoEGLF+1a0IrFrlA==
X-Received: by 2002:a17:902:b412:: with SMTP id x18mr18885570plr.116.1595872364116;
        Mon, 27 Jul 2020 10:52:44 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id bx18sm211489pjb.49.2020.07.27.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:52:43 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:21:19 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] ata: use generic power management
Message-ID: <20200727175119.GA700880@gmail.com>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
> > The patch is compile-tested only.
> 
> Please test and verify actual functionality, if you're serious about
> potentially getting this into the kernel.
>
Hello Jens,

Sadly I don't have the hardware. This upgrade is part of my Linux Kernel
Mentorship Program project. Like other PCI drivers which I have updated, I could
do compile-testing only. Though this patch covers 54 drivers but the actual
change is done only in drivers/ata/libata-core. Since rest of the drivers
make use of the same ata_pci_device_suspend/resume(), it was a chain reaction. I
only had to change variable binding in "struct pci_driver" variable of dependent
drivers.

Thanks
Vaibhav Gupta
> -- 
> Jens Axboe
> 
