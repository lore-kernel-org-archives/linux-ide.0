Return-Path: <SRS0=Xbu2=5X=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A9C2BB54
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5442F206C0
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="N9VSIZQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDGJO1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:14:27 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:32830 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGJO0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2020 05:14:26 -0400
Received: by mail-lf1-f44.google.com with SMTP id h6so1819179lfc.0
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2020 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6OtopnAAEq7RcaO3cYzbThDgjEImIu/ZUC/MK9b+8Qk=;
        b=N9VSIZQuml59Tid/3BT8Vv4Sl3yokkoCg6reujsWc0KVmCdZMyecSp/JlJ5bRFLMfx
         3oEg5dE+ElyxX76iOxKMp8b439iMCs5lrNXjrIO3VqB+0WP4iInZWzceXD0wNI+VqQPk
         n8LP6LTxMSNYh6XvAAoh/2rLEUZfgWzlTbFU+ThhE+qFEcYl3fTFc99sVuIHcvh2oRVo
         F/7Y9Lj4MEndi2rtAbUwoyLYjzu10I+wrv0GkyOXtzYsT+h2jZyY4KZUOX/q6fLO2+Sk
         crkqYg8AcOeIXQfefQQYKJRFd3hBg5pkw0LosD1pDaBbXt8u6BEY/WXxDULmROayJbJ5
         VwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OtopnAAEq7RcaO3cYzbThDgjEImIu/ZUC/MK9b+8Qk=;
        b=XYXquJDYpfumTNEZJk8oecDGKd5z6U43wBKidyo2LdtKybQvGIVO3U9sByWsY2X/wA
         tuzXDSMjSfECJ1H+gd9DHl09/SIh++7cihn6aq3zx4s9wbDjAvD/DIplY7oKOZYUROD0
         KBnQeST8qMJHZIokwinJxiog7WYK0+QD3BvawZMBtb7T4RGl0/5jhkX7Kt8PAilRJ1lu
         mEXefQj0+Tbm0NolqKnlyhE7crWe3MRWI6iOP9VCb0Kv7ZxuY5o0MdYxnNsTLszonGZf
         Yrn4fqbE4mRqNNM/psSAi54ecLB8DbWo1eSivA6AvtJU3Olvs39khNxb9utYi1v93dOt
         hokw==
X-Gm-Message-State: AGi0Pub2XhDOE0h08UKItsi8FgLHZ5zQaMp+TinbbYwAUbeNKoN6znuC
        G4AIbN34ddwiiCGmcRGV3tB4kw==
X-Google-Smtp-Source: APiQypJGoa7tB+BMSHzRLxg2kNe/UtYrewh2+8LZfB0dIpTElAeYYLhQvYMMPeS2DRMexOD8gZbQCw==
X-Received: by 2002:ac2:5559:: with SMTP id l25mr936737lfk.55.1586250864387;
        Tue, 07 Apr 2020 02:14:24 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:46df:46e6:40f1:f0a5:2488:8311? ([2a00:1fa0:46df:46e6:40f1:f0a5:2488:8311])
        by smtp.gmail.com with ESMTPSA id m17sm11470733ljb.61.2020.04.07.02.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 02:14:23 -0700 (PDT)
Subject: Re: [PATCH] libata: Return correct rc status in
 sata_pmp_eh_recover_pm() pwhen ATA_DFLAG_DETACH is set
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190327090254.10365-1-kai.heng.feng@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6c0f9cd4-13a7-3f5c-020f-2401de9e42b7@cogentembedded.com>
Date:   Tue, 7 Apr 2020 12:14:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20190327090254.10365-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

    s/pwhen/when/ in the subject? Also, I don't think "rc" is needed there...

MBR, Sergei
