Return-Path: <SRS0=dbCU=BH=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65914C433E8
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jul 2020 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB8620658
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jul 2020 05:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDHCpeeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG1FTJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG1FTI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2020 01:19:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A7C061794;
        Mon, 27 Jul 2020 22:19:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l2so3953522pff.0;
        Mon, 27 Jul 2020 22:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ghlAYTyzFZwTZgv3PuWK0Pqom48ugz1LIIW6nutfN0=;
        b=DDHCpeeKFIvand3ijvOlzW1o6Bwf1v/pnGmPNiE8ejUG8vuxqOAjjI3HXEl1LC0pyA
         fJIGCAGcWTYXIYUY47OXImPiMsDDxwKZwyBRoFVgPeAJ32R+warIxyiqEuVq19OHR9Io
         JOjC4bc2vEXTt4PuabQcyHuGfVvYNdLntd6Lc5l20glat+NFQv9KPA1bvUjq++IAtxjn
         kF3ghZqaThYfqEC7CCgKVCf0v66n+IJfYPazs96AzrMCgeEhzcmPF0TuUdas5GLJCZQt
         vfjPSNYp1XOx99K9yIhkiOu7Cy9MjjaMQfOIEsAASErLtZB6Uo8fD7C6KzJlig/8+pr+
         jeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ghlAYTyzFZwTZgv3PuWK0Pqom48ugz1LIIW6nutfN0=;
        b=WkqC+ixKv153yhn1KwXtd2vFp9sN0M6UUCbzk2QNyYFXQcFXdNnoChiZrucfJj10K8
         U5lCo5C+FRuDErRPWavrP3Hzg7Zun7XGaDLvr2A69uk1hbqdou+86XLTSHkywGtyMGsh
         5nG5fQq7uxyqoOI+BBrLlkVLNdFwlZHhE8UXhVnwvkNBwH8AxG471jRjGdZVl1GhOnFB
         SOXDHbBYb/Xz4smRaevf4c1VvAiqFkGA92TBCSjBiyMbUaySacof7xJ2nAcdq8Ak7Fgr
         Dl975YwSwPJBIIIEfuqy8fV/GAr+cyxR7q3LZSDCmxASNqx4EJrx0nHhRjhUV6ywgZnj
         oRXg==
X-Gm-Message-State: AOAM533s/ijfzuRYleeEasQLJLathMGpPlSTT4E+4QZm/vSKe4xKiEhh
        8SWvYrtK+WEQSMgAGW755uY=
X-Google-Smtp-Source: ABdhPJxj98U/h9D2NiyHWET1poZTnBjn/xdQ09g3tOwYLU9+dhSYrjB2Yyl6WXPjpEujKJSAZiFOiQ==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr22409995pgc.182.1595913548066;
        Mon, 27 Jul 2020 22:19:08 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f6sm4299245pfa.23.2020.07.27.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 22:19:07 -0700 (PDT)
Date:   Tue, 28 Jul 2020 10:47:42 +0530
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
Message-ID: <20200728051742.GA198538@gmail.com>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
 <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
 <20200727181144.GA543@gmail.com>
 <9718954b-2152-1bc2-e702-ebe8799fdfb3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9718954b-2152-1bc2-e702-ebe8799fdfb3@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jul 27, 2020 at 02:30:03PM -0600, Jens Axboe wrote:
> On 7/27/20 12:11 PM, Vaibhav Gupta wrote:
> > On Mon, Jul 27, 2020 at 11:59:05AM -0600, Jens Axboe wrote:
> >> On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
> >>> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
> >>>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
> > Yes, I agree. Actually with previous drivers, I was able to get help
> > from maintainers and/or supporters for the hardware testing. Is that
> > possible for this patch?
> 
> It might be, you'll have to ask people to help you, very rarely do people
> just test patches unsolicited unless they have some sort of interest in the
> feature.
> 
> This is all part of what it takes to get code upstream. Writing the code
> is just a small part of it, the bigger part is usually getting it tested
> and providing some assurance that you are willing to fix issues when/if
> they come up.
> 
> You might want to consider splitting up the patchset a bit - you could
> have one patch for the generic bits, then one for each chipset. That
> would allow you to at least get some of the work upstream, once tested.
>
I think I can break this patch into one commit per driver. The reason that
all updates got into one single patch is that I made
ata_pci_device_suspend/resume() static and exported just the
ata_pci_device_pm_ops variable. Thus, all the driver using .suspend/.resume()
had to be updated in a single patch.

First I will make changes in drivers/ata/libata-core.c, but won't make any
function static. Thus, each driver can be updated in independent commits
without breaking anything. And then in the last commit, I can hide the
unnecessary .suspend()/.resume() callbacks. This will create patch-series of 55
or 56 patches.

Will this approach work?

Thanks
Vaibhav Gupta
> -- 
> Jens Axboe
> 
