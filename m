Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE3C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 04:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B4206D5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 04:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IQp2EKT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgA3EKY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:10:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgA3EKY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 23:10:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so957307pgk.2
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2020 20:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H6a2hAcBNDf50jLsz7qbTfJE2hD85xCfgqwWgNuwHEg=;
        b=IQp2EKT6PqPbYC5WCstwLn2iWq0lAFgOEbp/wtS+FythiqN9JOZl1HPaYFxCGVkYWF
         z8KrjO5eD4RcqQKM9sZdNJ2npJ0pm6fGkKKpyBGanxml8u597u1G/efZt9I/kC+FWngQ
         GzuSOXh1rOt820nqqF3DjZ+UX0tCLfTbUrwwnfk1L9PPREH7kumvPJK2eAzwrp2mioOO
         2cxLi/6iRVd1LZIDB+TqPqytIcMYL9GUmdawbxtbcq48eDqHifSaLogkWLqN1iMWJNSF
         OqaTvX6Phl1vbNv6bl5frh9F58ZSpJOsqOYRq49PCUMIC971gxdbRn/ztlxaT/5pR3V3
         eVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6a2hAcBNDf50jLsz7qbTfJE2hD85xCfgqwWgNuwHEg=;
        b=pRnne3i1S7jmabpGImx0mF6nKrdTyfaTuTXzQ1dr9VRDnA166WiZWkHrptZ70J4YlZ
         nhILyyNbW8TGINXRJ2FxrYoHlQIR56XnwvLIvJYyEzTSAuJbkF5Dwql3UFZ1v87xtUon
         31sshO+VApZdVZQXIhLeSu9HXRUNxjYouJ21enSLeX9BJGKptQlYDFyzDlpk7ZMtV+2g
         7zio0dJAIdufniInS/5ZgotzoWK6yK3Lq6beZ4rtVEK75WXHj+r+Af66mK0OqZsuSk8T
         KWaqMKfn37vuCgRjZk5V95Un8eVZqHyd7cXB3fxv8psjb/lYl8zlDwDC5J7OLzbylde8
         BEsQ==
X-Gm-Message-State: APjAAAX4MY/0+F5/enwt1FzuTC5ZOSArhnIE5DMQgc/CGJH4tJ9xwV/R
        Ka0Pn0AxRDUSNP5goEBp/ZL/UA==
X-Google-Smtp-Source: APXvYqwlUl5uxiApMFafYxJAjhL0wBYgSra/Q0x2WTBFZLd9fgFhIoeBqLP7wN/unBxVdXHPxO60jg==
X-Received: by 2002:a63:214f:: with SMTP id s15mr2810698pgm.238.1580357423987;
        Wed, 29 Jan 2020 20:10:23 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id t30sm4216769pgl.75.2020.01.29.20.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:10:23 -0800 (PST)
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vireshk@kernel.org,
        b.zolnierkie@samsung.com
Cc:     vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200113142747.15240-1-peter.ujfalusi@ti.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bd30916-0c35-b1c1-d08f-b7dd9e181dba@kernel.dk>
Date:   Wed, 29 Jan 2020 21:10:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200113142747.15240-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/13/20 7:27 AM, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.

Applied, thanks.

-- 
Jens Axboe

