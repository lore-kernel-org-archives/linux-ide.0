Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22BC433E1
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001FC20714
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsIZtQnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgG0SNK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgG0SNK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 14:13:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9DC061794;
        Mon, 27 Jul 2020 11:13:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so8525291pls.4;
        Mon, 27 Jul 2020 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kR383wS8kqwekIjxfXK5kIjXSbnIh9i7VOxO4cysSoo=;
        b=dsIZtQnrESfjZx0zpTL6h5JDXL/rRLZ3xWAJWBj3SXWF/o76ZkStabCnFKUDo2LSrh
         aypLIUiYaSJFu8CZsNXXO/X2kJGZXKAy0SEQSp1sSV158dfSWab0RDENgd6qL2h+l/pq
         H7iEhYY7FmoQTM2pLFc2TxcdKbH8wEP+bG5bsq8DMwONxmMdFkroipo1HpSDu0c0VQLc
         lVMkFZOOYuqZ84Xa1StBWtpBMPGzrjUfjUJtvOCbXTZvYIZD2UXA2fsQ7wZh4XyebtHQ
         raVpZi8aaFXiDWANQXFsXr1rsxpymFC5JrWJIuCFhzFJKTUGvtiL09p0oi1GH9SGyZxm
         no7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kR383wS8kqwekIjxfXK5kIjXSbnIh9i7VOxO4cysSoo=;
        b=YOipMrulhwOfjO+Ow1ehvC9nXL8UgNmygUBp7VUpplGJBias7Lo6OHHH5uj3pqo3hN
         iWxM4Ab4istOOZ8bx4CCwDRBrv0FOxPOzX2tPgZy7B3aHJhFx5LbGgekA3LQxrmc1aTk
         YT7SEHhAsZ+MN4w83y08lsDMki754gD+qQMLlxkmIHR5N2QzxXGXjMeqeW/QwIrx5BWc
         oWB3LpbDPsbUhMQ3GETLDpAevIVR1HDW+leWhcm4JAbvhA4pjxnJHO5hKKtb0XyMNaXO
         bDKsYBSnNrjiIGFJXzgxlZVhLxoOzAw18z26KVng1T/2ShInd9NRtlvFISpdkIroH0O8
         2dCg==
X-Gm-Message-State: AOAM531mNwWSWPZeqTcISnXwj/ON4L+lu9urAVwYW+/rN5dAkrlXgyJp
        z721GEfp3eNu72Y8n2qHvWQ=
X-Google-Smtp-Source: ABdhPJx2W8GAzXwFm0DY2CvswNN7eeV0OJe+kpgDp9G5l3uvOcy3v3G4ipQeuyhK8me3YL7tW5c4HQ==
X-Received: by 2002:a17:90a:2349:: with SMTP id f67mr489127pje.17.1595873589858;
        Mon, 27 Jul 2020 11:13:09 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id w18sm15382775pgj.31.2020.07.27.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:13:09 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:41:44 +0530
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
Message-ID: <20200727181144.GA543@gmail.com>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
 <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jul 27, 2020 at 11:59:05AM -0600, Jens Axboe wrote:
> On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
> > On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
> >> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
> >>> The patch is compile-tested only.
> >>
> >> Please test and verify actual functionality, if you're serious about
> >> potentially getting this into the kernel.
> >>
> > Hello Jens,
> > 
> > Sadly I don't have the hardware. This upgrade is part of my Linux Kernel
> > Mentorship Program project. Like other PCI drivers which I have updated, I could
> > do compile-testing only. Though this patch covers 54 drivers but the actual
> > change is done only in drivers/ata/libata-core. Since rest of the drivers
> > make use of the same ata_pci_device_suspend/resume(), it was a chain reaction. I
> > only had to change variable binding in "struct pci_driver" variable of dependent
> > drivers.
> 
> That's understandable, but you should find at least some hardware (maybe remotely
> accessible) to test this on. I'm not going to apply this without some confidence
> that it actually works, and compile only testing is a far cry from that. Lots of
> code compiles, but fails miserably at runtime.
> 
> While it's touching 54 drivers, at least basic coverage of the most popular
> choices will give everybody some confidence that it works in general.
>
Yes, I agree. Actually with previous drivers, I was able to get help from
maintainers and/or supporters for the hardware testing. Is that possible for
this patch?

Thanks
Vaibhav Gupta 
> -- 
> Jens Axboe
> 
