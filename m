Return-Path: <SRS0=HnBo=2A=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D00C43603
	for <linux-ide@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D1420663
	for <linux-ide@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBzLxFYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJJnX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:43:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbfLJJnX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Dec 2019 04:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575971002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+9gHLFclc8eGt+cU05OJPVI/o5eh55h38LcdsgaD/w=;
        b=MBzLxFYj+DQgqc+5pfwZ75FFWNFIjreIIbRWIKYObnj4DoebL/nSe7aOxX7HDKHMQDNfE5
        eXA52JtlPIF4NkB6o1mbV40YQMPFTNcBkZsa84XQvrI4iz1vO9wAZj98IlzEi7EK6+g+bN
        C6pbo5e+k7h92JvMy/iDjqs7gCKqj7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-KUkXwzLcOEKVovc70klG6Q-1; Tue, 10 Dec 2019 04:43:21 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so8720270wrh.5
        for <linux-ide@vger.kernel.org>; Tue, 10 Dec 2019 01:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+9gHLFclc8eGt+cU05OJPVI/o5eh55h38LcdsgaD/w=;
        b=LLn9ROnIs3r/JSJICZ3ZtejAjaoR6zj17SFLO7DYr8HpjYBmH9bdCijOG7+DlHPOVS
         3ftZFGfyRPfvMxPNhqhy4s/530ki58lL8UpYxNU9+aakMADU+Vec1KvJ6GO7BEbPYpvB
         vVfXO7LVt+8gNJlOH/1+qLstF/5pg1+wsZe48YitTKWGMKc0wV+5V1DnCxzAW5+4ZAUV
         5cqB1pgAFTa/AB68mgEhZnzJbvuFiWe2iBHEHRaWZmpCbc7x3M1N0MU/FHBDzYUHZ+ww
         h09EBrtDQV+n+yCuHErN4VjaAE/lY1UO/hESaiR2RStuGw8UfkudDyYKZyXgoY0xvW6t
         nHZQ==
X-Gm-Message-State: APjAAAXiF5PXuWFVEMkuQGOIx6hXc3on/e0cJ/nsqFbxCpi8t2Ct4AeW
        +J1YyK/IIeXE2ocBy2s2X317b6Rt02/T6AzJJPwutcdNY3a/1NeryCklg2roUhc4544BnOGJTny
        L/PPMmfVhdLyFn4cgGIWN
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3986772wmi.37.1575970999950;
        Tue, 10 Dec 2019 01:43:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeB/265O6c03O2Y44pel5nEJWfsWRBNWO+Wh+zKrzCGpUdazhsyNsnPr0e8H+FzTQolpxaYw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3986749wmi.37.1575970999761;
        Tue, 10 Dec 2019 01:43:19 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m3sm2619952wrs.53.2019.12.10.01.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:43:18 -0800 (PST)
Subject: Re: [PATCH 0/2] ata: ahci: Add shutdown handler
To:     Hanna Hawa <hhhawa@amazon.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
References: <20191209163209.26284-1-hhhawa@amazon.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6eb4bf8-547d-54de-1f25-fbe9c715cde5@redhat.com>
Date:   Tue, 10 Dec 2019 10:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209163209.26284-1-hhhawa@amazon.com>
Content-Language: en-US
X-MC-Unique: KUkXwzLcOEKVovc70klG6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

HI,

On 09-12-2019 17:32, Hanna Hawa wrote:
> This series introduced AHCI shutdown handler for AHCI PCIe driver, to
> disable host controller DMA and interrupts in order to avoid potentially
> corrupting or otherwise interfering with a new kernel being started with
> kexec.
> 
> Part of this patch move the common part between platform and pcie
> drivers to libahci.c.

Series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Hanna Hawa (2):
>    ata: libahci: move ahci platform shutdown function to libahci
>    ata: ahci: Add shutdown handler
> 
>   drivers/ata/ahci.c             |  9 +++++++++
>   drivers/ata/ahci.h             |  1 +
>   drivers/ata/libahci.c          | 33 +++++++++++++++++++++++++++++++++
>   drivers/ata/libahci_platform.c | 20 +-------------------
>   4 files changed, 44 insertions(+), 19 deletions(-)
> 

