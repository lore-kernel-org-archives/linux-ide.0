Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C93C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73534207BB
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I1T7nVAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgG0R7J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgG0R7I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 13:59:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEAEC061794
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so8495695plx.6
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFDUQmogg46Posu3w903aMyaH9JFMPS/SgmwZ4I8ccU=;
        b=I1T7nVAHC3vzto7UQ9hEUXPS9L7N6JIHGvzV+CxpjYgmTe+ds1sKddaNfOp5Lz3zFa
         gwq29Ta3R+Ik6gTSzyHZj/QZTNGF+3YjxvH/oCQsmR39XPWWUgXlruApbZuRv4+UO6m+
         F+qJsD58I3vBK2wxxeMXuf1z2fVrikDTjLjbR3nvBVLAacLbU8HVbI0K7jV8MOuA6Bxz
         4oT6R6utDcWVEFQn1fppwmwQNvzuhRptA2GEPRg7km6J4qyewnJSZB9xyCMkLRSxVBOr
         HSqr07ARxowQi2ya25mF7GPbk4Gk2mFcDQT0lHnrh3jPX2oUlHgOexqhi5yZie7+ZxLf
         N3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFDUQmogg46Posu3w903aMyaH9JFMPS/SgmwZ4I8ccU=;
        b=I+U59fNKBL1Ja8s/CWJdypWGsq7hxdIwsE8d9vgfIkrlkkWPF/BhuWZ6M4c+Kh8wxe
         XS4kakT0AAdKZ/6DH2y2l2YhEkGMnSu2lfFwigyXVDbfPM9prB31qE8WI3piIiCAWyzZ
         vRqJvxeuH14dH2UIv1YKCtJb8HjfAr7GK7njSy6MGN5p2Iz3bI0MbdB+VJZ7QMktRQZR
         ilmxMLK7OsTBEJQs4N+b1LXRgBWHU49uFFhtDFRAL+88KHQcQA2L6ds96iBJ3jGXA3UF
         jcXK+/1ENM1RDqvPbHPPCv8II9n3UNVtI2gUZD6LXaEebJY5nQTgr0fLz4tKcIgtCY+P
         /ooQ==
X-Gm-Message-State: AOAM530x47oKsCE/G9GMiL/FadlThrvwWld2KeK0ldlZp3EScEfjwW6c
        Ms5w+fXpkDvVeyRBa7pkcSWiJw==
X-Google-Smtp-Source: ABdhPJxmYU88VTup/scAe1Pwy/mPgv3UJuWHJtQ3YU8xLR7QKaHQ2gI4MwOQdpbgduq0ybJfvL0uCg==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr495293pjb.8.1595872748151;
        Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w70sm8378070pfc.98.2020.07.27.10.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 10:59:07 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
Date:   Mon, 27 Jul 2020 11:59:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727175119.GA700880@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
>>> The patch is compile-tested only.
>>
>> Please test and verify actual functionality, if you're serious about
>> potentially getting this into the kernel.
>>
> Hello Jens,
> 
> Sadly I don't have the hardware. This upgrade is part of my Linux Kernel
> Mentorship Program project. Like other PCI drivers which I have updated, I could
> do compile-testing only. Though this patch covers 54 drivers but the actual
> change is done only in drivers/ata/libata-core. Since rest of the drivers
> make use of the same ata_pci_device_suspend/resume(), it was a chain reaction. I
> only had to change variable binding in "struct pci_driver" variable of dependent
> drivers.

That's understandable, but you should find at least some hardware (maybe remotely
accessible) to test this on. I'm not going to apply this without some confidence
that it actually works, and compile only testing is a far cry from that. Lots of
code compiles, but fails miserably at runtime.

While it's touching 54 drivers, at least basic coverage of the most popular
choices will give everybody some confidence that it works in general.

-- 
Jens Axboe

