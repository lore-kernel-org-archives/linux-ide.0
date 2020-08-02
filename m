Return-Path: <SRS0=QMhF=BM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE1C433E0
	for <linux-ide@archiver.kernel.org>; Sun,  2 Aug 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70312072A
	for <linux-ide@archiver.kernel.org>; Sun,  2 Aug 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQK0Z0rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHBOx7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:53:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgHBOxz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2020 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596380034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kkoTewt7Fx4Q+2DDC1UGcR4JlqqtBcQK2oUP1r3rTc=;
        b=UQK0Z0rSSJ3RYv/pOdPJNA6PyZ0mxVOF4RkOpslu2kWNJ0g7Kt3BefKGVQsNLUBThsozUB
        /jJmQMu09ACEQBH0BQpSE5sj4lk5RKUQu0RGPDZKQGLo/HP3Ui/G10SLQi/nNWpx0MY/Pm
        DFsDbzOA0RiZPAulcuLsKvnuKD9NR1I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-XjNLZQJ5OeyrRLJHx9H5AQ-1; Sun, 02 Aug 2020 10:53:51 -0400
X-MC-Unique: XjNLZQJ5OeyrRLJHx9H5AQ-1
Received: by mail-qv1-f69.google.com with SMTP id l10so13921523qvw.22
        for <linux-ide@vger.kernel.org>; Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1kkoTewt7Fx4Q+2DDC1UGcR4JlqqtBcQK2oUP1r3rTc=;
        b=n8HzQWuI1voWLVVhMPzM9Lfwlukoy0DQjpozCA+rwij7lSKeDu0iKSBGnjmogqT+Gj
         lcKpNz4MWX36NskghrwHdFIyptmN0mq5bplsi9C3432jFQ3hNzyfuJdCqkOJYZWsP/Ei
         4yxSoPVjYUdzM2WdKy65atvVD3L388/eCAn/s6BD6UcePLxkGKuZSYHWR9T0mNOo7ni1
         +s5+uYnW+ZztuO2WvWY+6X9ywazlZF8SUR3Qs1DSz+zeoLBfrlo/g/nmCQ5znNeXYsHL
         a5mlVsTNSc/LfN9pf3vDaxQ2wWAZwUxVwbfCjYsS6cGy4mQjvLD/xB59DI7SDK6haL9J
         Bvaw==
X-Gm-Message-State: AOAM5312hKh0cik4dwER94ZiC+0PENsqr3Rx+9s0A4qziZaYi9HC2jwj
        k+HSvIQkHUwpLYlYNNuj4TVyauE5XwdVg5lgM/K0r3JQh7/+c4Amr8bAgTvj8XWuGJ74N3UWpDX
        fhqXW5oUQP6u9HubnQEKx
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12711368qvk.53.1596380031292;
        Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsaj772ZR8xxDSmSbCv1i3DbzhNyKSnnIAtdh3ZvECGhzafck69cLoHqLTgfamrb5jJgzXtg==
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12711349qvk.53.1596380031093;
        Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t127sm16326265qkc.100.2020.08.02.07.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 07:53:50 -0700 (PDT)
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
To:     Borislav Petkov <bp@alien8.de>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-edac@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801125657.GA25391@nazgul.tnic>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6ecce8f3-350a-b5d5-82c9-4609f2298e61@redhat.com>
Date:   Sun, 2 Aug 2020 07:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200801125657.GA25391@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 8/1/20 5:56 AM, Borislav Petkov wrote:
> On Sat, Aug 01, 2020 at 01:24:29PM +0200, Saheed O. Bolarinwa wrote:
>> The return value of pci_read_config_*() may not indicate a device error.
>> However, the value read by these functions is more likely to indicate
>> this kind of error. This presents two overlapping ways of reporting
>> errors and complicates error checking.
> So why isn't the *value check done in the pci_read_config_* functions
> instead of touching gazillion callers?
>
> For example, pci_conf{1,2}_read() could check whether the u32 *value it
> just read depending on the access method, whether that value is ~0 and
> return proper PCIBIOS_ error in that case.
>
> The check you're replicating
>
> 	if (val32 == (u32)~0)
>
> everywhere, instead, is just ugly and tests a naked value ~0 which
> doesn't mean anything...
>
I agree, if there is a change, it should be in the pci_read_* functions.

Anything returning void should not fail and likely future users of the proposed change will not do the extra checks.

Tom

