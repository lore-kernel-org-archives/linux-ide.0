Return-Path: <SRS0=SRgV=B5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9771C433DF
	for <linux-ide@archiver.kernel.org>; Wed, 19 Aug 2020 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9724222CAD
	for <linux-ide@archiver.kernel.org>; Wed, 19 Aug 2020 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skCBsF03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHSSxJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSSxH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Aug 2020 14:53:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82680C061757;
        Wed, 19 Aug 2020 11:53:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g15so7364816plj.6;
        Wed, 19 Aug 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ojo0vVfxMF4kGimsv0YT84fT9cZgWR2PgPBwNlWXlnI=;
        b=skCBsF03o+nKy1/X62nQs3ZlUExK97yXVDTlRaA8GO72wwa24H1C7qm2MuhrUyaALi
         mpZzXM9DozoVnhGuFMyeGT4y/xG3sviD5GzhhEOku6+iKvJK4t3So16vPlCDSBVw1Y6E
         vjyslNPnU+Ku+7fni24xc9moG9pHb+l08VL1GcDp6yualyjc5WbW86Z2cQQ1FYvroIo/
         0o0CG8HvML5rh5X5QEYPitjvapemHzuaNan08+aYY8bdP+uzd3ROmHemiDph51bwCjl1
         q2yzBJcwp9rpY6gC++vSo4O3mJqFqAYF6o8JaTp7NuP3hY7sEZs06cKm1I+D/ivrvMTT
         YNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ojo0vVfxMF4kGimsv0YT84fT9cZgWR2PgPBwNlWXlnI=;
        b=DjHSs7YCNcMY4VkW81fefWhTA0JkxpfHejLYBRSGnSh/DzR/126NkNy2DwyCwaX5ec
         d6SYQZGto6xOEOyzedEgwYVoQ3GoR589S381CNJYPjSvOvdcFPj4a597UksEa7TU8x2K
         x9sAbzhxNdJIyuc8PqW6mp697imbwQK9PaVXrReYxFeazH+Ii+EteHaOuxrBD37sb2Ol
         ebOKxoujR52LLATM+0RKro7XQaAUcYLW/Dp9pc8a9RRfHaS/2TG3uq3yMyChsSIY8ChF
         PPAKTD6xKHn6xr0N6m7HZJI8xyEDsyGz9tst8L66IWw9U3OgyYNKcerv11mIwBlmQVvD
         qLiQ==
X-Gm-Message-State: AOAM533t4ZHp5T+YLlHSoTDDkSb7ay+5IBColmh7EOTAz/rOYRARFp7E
        f00j7uGQ9sK1l1d/uLIzZWE=
X-Google-Smtp-Source: ABdhPJz8qgSUSMAh8sRZsex9BAVPb7wEOcm30G8p5x+PLRkaNGEKbLX19pSFlFe30lZkVGjNFsyTWw==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr10893239plp.260.1597863186960;
        Wed, 19 Aug 2020 11:53:06 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id x6sm25815940pge.61.2020.08.19.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:53:06 -0700 (PDT)
Date:   Thu, 20 Aug 2020 00:21:08 +0530
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
Message-ID: <20200819184738.GA108131@gmail.com>
References: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
 <20200817092511.GA10566@gmail.com>
 <11190a0b-1009-caf8-9cbe-6cf296b614bf@kernel.dk>
 <20200818130329.GA39194@gmail.com>
 <a1937b38-055f-0fc7-0d08-16af7c42660b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1937b38-055f-0fc7-0d08-16af7c42660b@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Aug 19, 2020 at 12:40:20PM -0600, Jens Axboe wrote:
> On 8/18/20 6:03 AM, Vaibhav Gupta wrote:
> > On Mon, Aug 17, 2020 at 07:06:03AM -0700, Jens Axboe wrote:
> >> On 8/17/20 2:25 AM, Vaibhav Gupta wrote:
> >>> Hello,
> >>>
> >>> I am working to upgrade power management framework support for PCI drivers, as
> >>> my project under the Linux Kernel Mentorship Program.
> >>>
> >>> The ultimate goal is to completely remove the legacy framework. And for this we
> >>> need to remove ".suspend" and ".resume" pointers from "struct pci_driver".
> >>>
> >>> The patch is doing the change for the same. The actual suspend() and
> >>> resume() callbacks are defined in drivers/ata/libata-core.c and are exported.
> >>> Which are then used by other files.
> >>>
> >>> Thus removing those pointers, included 54 files in this patch. Although, the
> >>> actual changes are done in few files only. The changes should work fine as I
> >>> have done similar changes for other drivers too which made their way into the
> >>> kernel. Still, tests on few ata devices are necessary.
> >>
> >> Didn't we agree to split this up into separate patches??
> >>
> >>> I tried but unfortunately, I couldn't find or arrange devices to test upon. I
> >>> have added the authors of the previous commit(s) for respective drivers as
> >>> recipients. It would be very helpful if someone can test it on a device.
> >>
> >> Does qemu support any of the affected drivers?
> >>
> > Hello Jens,
> > Yes we discussed about splitting it and I will surely do it. I just thought that
> > still it has not got tested and in that case keeping check on patch-series with
> > 55+ patches may become somewhat messy. Moreover, to test any driver one will
> > have to apply the patch for libata-core and then that of the driver.
> > So, I sent this v3 in order to get some help for the testing purpose. Once it
> > goes successful, I can split it and send it for the submission.
> > 
> > I am not sure about qemu, I haven't checked for it. Qemu will be appropriate
> > for testing power management for .suspend() and .resume() callbacks?
> 
> Well, that's your homework then, it seems pretty ideal for testing that
> kind of thing and way easier than getting your hands on hardware. It
> won't have support for everything, but so far you are at 0 things
> tested, so any piix and ahci testing would be a win as far as I'm
> concerned.
> 
Okay. Thanks for hinting about qemu. I will get started with it then.

Vaibhav Gupta
> -- 
> Jens Axboe
> 
