Return-Path: <SRS0=3T05=3L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C76EC2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 22 Jan 2020 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C38C24125
	for <linux-ide@archiver.kernel.org>; Wed, 22 Jan 2020 17:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l9c+Elgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAVRqW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:46:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39859 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVRqW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jan 2020 12:46:22 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so119472ioh.6
        for <linux-ide@vger.kernel.org>; Wed, 22 Jan 2020 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nX6uQqxZtDslBvXjVtcrMietDRuI6jm4awh0ZwhZuHk=;
        b=l9c+ElghttALofFRE3FXnRVXPPau0oyeSYQ5mbLH7b8ONXnq+y7so+TYXDPNGCiefw
         cqHRGjgbWi17YvRde8XVJSpFt9oqNe5Ntn+/xJgtifi1/TLLjcbJ8rgJZyVDzLU7WEku
         LSsNB12k8N3ryZzv9G/4mASvyqEApmO/z9IjcclxSu9zTRUDJfyCuQ2/KeXtmP/le5EZ
         gQABIGHgJmpp0dBXlGfbLZVAsBIYOOVGkeldvLykqC5B0i/StCKD1k7rsEGeST3021ae
         eIR7R4HHk/MZd9DluhheD/DGRrhRb4vggGGPX/Yj9b1blHhQjk6NjmqABHDFkq3b9gtM
         hQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nX6uQqxZtDslBvXjVtcrMietDRuI6jm4awh0ZwhZuHk=;
        b=THNTfDzEpl8KGh37t0LtsAWuj/8ZBGg2DNbTCMZ4KzCD20qSr3vs5nk4j8G64UnLG8
         uOO0HI2DV0HraCByWDOh8PuP1Lpr9pTkkyFp6JI0h8rZaAW/IUA6EjDj6ip81nsN3JFP
         P47lpLerxspOtyxOl5hUfbNnA3vDN3wIiu8bBWnPOOViiX8PNa9LBsBgBt/TLQgvTVNE
         Al4pLojNoOrJUI4eeRH822slTqILGrJtGTa8UWCu0Rb7nYq4gSTBkuiRiHNeBthD9Igt
         Psdp9N9Clhysm3r9Ntc2RgVXZ/sL2wCewaG4/mJWMmeK1JBk/FB1WAdIDdun8ANI/TgD
         VHAw==
X-Gm-Message-State: APjAAAX8uA5UXrz8uaQVyRvBkXOCUCqxKZ9wsHvkq2DaokTLu/LCYnmx
        /ChWJZGlBjPMkBEm9PbxqVbyRENLgtA=
X-Google-Smtp-Source: APXvYqy1VRNqLa4g0S2QF+NjhVifJjGQlvtGeZO0tvd6fmsSaS+A6ipfcW95HEVjMOv2wh6vmhkpDg==
X-Received: by 2002:a5d:9b94:: with SMTP id r20mr3522840iom.140.1579715182028;
        Wed, 22 Jan 2020 09:46:22 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r14sm14813278ilg.59.2020.01.22.09.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:46:21 -0800 (PST)
Subject: Re: [PATCH] ata/acard_ahci: remove unused variable n_elem
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1579596529-257563-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d153603d-a492-e989-459a-de5ae7db0737@kernel.dk>
Date:   Wed, 22 Jan 2020 10:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579596529-257563-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/21/20 1:48 AM, Alex Shi wrote:
> No one care the varible acard_ahci in func acard_ahci_qc_prep.
> better to remove it.

Applied, thanks.

-- 
Jens Axboe

