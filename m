Return-Path: <SRS0=SRgV=B5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D40C433DF
	for <linux-ide@archiver.kernel.org>; Wed, 19 Aug 2020 18:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32B420658
	for <linux-ide@archiver.kernel.org>; Wed, 19 Aug 2020 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e+mMmkTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHSSk1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSSkZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Aug 2020 14:40:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403BC061757
        for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2020 11:40:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so1514770pjd.0
        for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2020 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S1EUhordtUMjel9FzBtn8TtSvL9SVNZ9uwAnsm6qFvw=;
        b=e+mMmkTZHdUnOzUeVKsZZ9CczIEu12TU8Kve2CC8dc6MqNmTEWTaZ348q66vWBSfQF
         GIklVGsrgvsTEi1Qo4eoBoX6yS36bEKuwLEDTe9RkBCSPbDnBBXP6W0qOW5001XEK0Qt
         BkCV9STVWZ3StfyFgDVToDTKDhXjLPEHSiqjoDG8SYkTzLcjxMH4/00xiBfEgzz2mUTW
         +JK9+Bh7w2UX6zSUKJnkIqT8hbNPAph1a/yxm3dqaYY30/wyoRpifLbnVPoVYkVOUGQD
         v7S+6t27MltFWBp/vody+r29b/EGImRaMm5d0kwzHa/ke2SzSzF7lV3zpxK7bhO/2nf2
         6Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1EUhordtUMjel9FzBtn8TtSvL9SVNZ9uwAnsm6qFvw=;
        b=HguBvuTp3YIOpwgTk+Lkd8GGTImg5MOHnxm/RkwSWvI8VMK4KrZwj9QCihtPa8ymPI
         TFKhj7WiTuXw33yhi/8YiWqbV2n+eqEA2Qchz0DTy6Ms4SRoWppMB2zeU/GAVOhqxbX1
         RRGWUgDPT/dtX7KzDOAcAw4nbgMmnIwN65hkdzvLsFb3C/Hvn3g4pisYoLIbDhdNUJcx
         qkGN/P6c2vaP6pojkBnRovOLJfii4IXzocat+DZkIZUqpPMhRoiyaXStk0iNzORJuoge
         mVVp28+iw9qN7WL3wkcr62Nmeh6LxgEcbq51ohykQWLjra58iXttRL+rU62tpU6Zw+WK
         0tlA==
X-Gm-Message-State: AOAM533Ivi/d0D94XER4naVnx8Hvd/6tgqGQURa6mUFB9BC/PYxMReW9
        6+g/91HCSzZq/dIlZB3Aztzm0g==
X-Google-Smtp-Source: ABdhPJxp72MaH2m2nPgfUrred95nj+8zIrU+NNhgrwSD/P/pZgzig9Z2qyQTh3Wm88TgTsloY+2vBg==
X-Received: by 2002:a17:90a:ab96:: with SMTP id n22mr5132823pjq.52.1597862424863;
        Wed, 19 Aug 2020 11:40:24 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y79sm28201877pfb.65.2020.08.19.11.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:40:23 -0700 (PDT)
Subject: Re: [PATCH v3] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
References: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
 <20200817092511.GA10566@gmail.com>
 <11190a0b-1009-caf8-9cbe-6cf296b614bf@kernel.dk>
 <20200818130329.GA39194@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1937b38-055f-0fc7-0d08-16af7c42660b@kernel.dk>
Date:   Wed, 19 Aug 2020 12:40:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818130329.GA39194@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/18/20 6:03 AM, Vaibhav Gupta wrote:
> On Mon, Aug 17, 2020 at 07:06:03AM -0700, Jens Axboe wrote:
>> On 8/17/20 2:25 AM, Vaibhav Gupta wrote:
>>> Hello,
>>>
>>> I am working to upgrade power management framework support for PCI drivers, as
>>> my project under the Linux Kernel Mentorship Program.
>>>
>>> The ultimate goal is to completely remove the legacy framework. And for this we
>>> need to remove ".suspend" and ".resume" pointers from "struct pci_driver".
>>>
>>> The patch is doing the change for the same. The actual suspend() and
>>> resume() callbacks are defined in drivers/ata/libata-core.c and are exported.
>>> Which are then used by other files.
>>>
>>> Thus removing those pointers, included 54 files in this patch. Although, the
>>> actual changes are done in few files only. The changes should work fine as I
>>> have done similar changes for other drivers too which made their way into the
>>> kernel. Still, tests on few ata devices are necessary.
>>
>> Didn't we agree to split this up into separate patches??
>>
>>> I tried but unfortunately, I couldn't find or arrange devices to test upon. I
>>> have added the authors of the previous commit(s) for respective drivers as
>>> recipients. It would be very helpful if someone can test it on a device.
>>
>> Does qemu support any of the affected drivers?
>>
> Hello Jens,
> Yes we discussed about splitting it and I will surely do it. I just thought that
> still it has not got tested and in that case keeping check on patch-series with
> 55+ patches may become somewhat messy. Moreover, to test any driver one will
> have to apply the patch for libata-core and then that of the driver.
> So, I sent this v3 in order to get some help for the testing purpose. Once it
> goes successful, I can split it and send it for the submission.
> 
> I am not sure about qemu, I haven't checked for it. Qemu will be appropriate
> for testing power management for .suspend() and .resume() callbacks?

Well, that's your homework then, it seems pretty ideal for testing that
kind of thing and way easier than getting your hands on hardware. It
won't have support for everything, but so far you are at 0 things
tested, so any piix and ahci testing would be a win as far as I'm
concerned.

-- 
Jens Axboe

