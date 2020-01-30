Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA0C3F68F
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 04:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EDA207FF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 04:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TkiYFdWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgA3ECg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:02:36 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37023 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgA3ECf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 23:02:35 -0500
Received: by mail-pf1-f175.google.com with SMTP id p14so786835pfn.4
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2020 20:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9gi7cftqQhgEACfQSG0oIMlygZz7GMQOh7VEOEdbmsk=;
        b=TkiYFdWKNw7Sp2JKCDubpt91jPpLEDCcOpRzE67lzrn4zUdF91ZeIBNvtsw1QkA5et
         2GJnr9gXAoUHg0NNr+GWAXmedY4i4yBw+0CstvfoRVyF60x/QbNS+Gastps2fRVBEiAJ
         N/kfKxZuLlsBWNv41ClMapYv2i8mMVb+OP2CIZfa8jGC08nyYbdHpwkqqKaU6poD5VmF
         4TMfbfiQs06gW0jbLZew1ZnArGD3aVMthyIEhJRs8y6w8OJ03PiJkLQMzBcYOsLqCD4Q
         nxdTslR0oSTmlW+JrZe1kSqZjR0oagOy/tjdoyYcRBQALabisuZ1dGyYro+jrvtAIWss
         hEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gi7cftqQhgEACfQSG0oIMlygZz7GMQOh7VEOEdbmsk=;
        b=j3sZi4Na26yvFqH+iOqu2B679H5vpoj7N3QtN+KpWySkDoWWVqGPMZ7b7unJqlH5aC
         K61ABi60wKoQjpFZM2WrX9v8Kt6UQwUvzq3t0+W/f7G8SpA81atf+qWWknyb+c5fTilr
         UzNVl1dMFeTTO3ooU6T3NxooNLj2FPRu8OEqtXNLi7gqe73yLgnI22kwI0wXOEizpr+r
         gl0KgbcV7116tZR2ujNQaqfX24CwaBPEjZJwM9p2UaP7ayYZJk3Zeap9jScWso00D5DV
         EcYhE24MTzKGhqnMIlAsNKG5qWet6i+Zs6HRxLWWRBJCXaxnRWhE4TJ037NmZY7wBjbT
         EaNw==
X-Gm-Message-State: APjAAAXHnC+dBUFxCbfc4Ogf9Sg0CRDhyxfNTQUxotcKjYeXdz6LU4Xr
        /UF/m1RyP5zZAnn7e6brQNx2DQ==
X-Google-Smtp-Source: APXvYqygfj0eCdlxEcY/Q9qnem+Iu4pR2PO/Pv2r6Tz/SFwfD2kn37iJLTRwdI4m6x71W7niF7BisA==
X-Received: by 2002:a63:f62:: with SMTP id 34mr2736391pgp.184.1580356953827;
        Wed, 29 Jan 2020 20:02:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u26sm4210926pfn.46.2020.01.29.20.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:02:33 -0800 (PST)
Subject: Re: [PATCH][v2] ata: ahci: Add shutdown to freeze hardware resources
 of ahci
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>
References: <1579923437-12983-1-git-send-email-pkushwaha@marvell.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d610a34d-16f5-1035-f3c3-f32a75aa0fe2@kernel.dk>
Date:   Wed, 29 Jan 2020 21:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579923437-12983-1-git-send-email-pkushwaha@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/24/20 8:37 PM, Prabhakar Kushwaha wrote:
> device_shutdown() called from reboot or power_shutdown expect
> all devices to be shutdown. Same is true for even ahci pci driver.
> As no ahci shutdown function is implemented, the ata subsystem
> always remains alive with DMA & interrupt support. File system 
> related calls should not be honored after device_shutdown().
> 
> So defining ahci pci driver shutdown to freeze hardware (mask
> interrupt, stop DMA engine and free DMA resources).

Applied, thanks.

-- 
Jens Axboe

