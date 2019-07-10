Return-Path: <SRS0=7AwG=VH=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB50C73C66
	for <linux-ide@archiver.kernel.org>; Wed, 10 Jul 2019 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A712073D
	for <linux-ide@archiver.kernel.org>; Wed, 10 Jul 2019 03:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z0YbjvDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfGJDEO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:04:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGJDEO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jul 2019 23:04:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so333558pfq.12
        for <linux-ide@vger.kernel.org>; Tue, 09 Jul 2019 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FEdkSOwEiVwsjukTZwCe45mSNh9wLOeBdBVL8WohUzo=;
        b=Z0YbjvDiU4Dl9aNipT1ktogMqPG2Og0ttfZsdv410DnOxzNF2klf3krXd6sI3jSnkA
         OorwPv0xLSJNKN2os3jrd5Mh1vp6nX6A+ncnNXJPdvzGNqXBR6rcq2FOkx0s9qtky0LL
         Sl28apdMmUiKwIzj7P2vdfGiUcnVvkpy2M4N8dV5qk7IBBuuOEAATxl6W5oqse0EoSDT
         yHBvobmIIQixUrLModsm2nBtKItEVWiJvpwLOSbadKGLlT0G1fbBr+qxtZTfwPzAA3Xc
         clmt+kE5syBrDCsEFGbBwmYb8pnGkKW2wXEjh5v8dNxG9g8w1+GKqN2QsBkuD7bcvOf0
         Kwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FEdkSOwEiVwsjukTZwCe45mSNh9wLOeBdBVL8WohUzo=;
        b=jyv3uIJDeu/kVnPYhV2et7u4r9Ikl+0SDFzcKbTcFlYTNHiHRGOsi1+9BdXt9aAfM1
         RCq5pltzKiJd8aEng/Fu0cCCGATOWV8EZ8x2JZCiIgOa/jcQ89vGvSIv9EB5bCjXOvJH
         oGMDVOsTHvDVf/BDdAGuovBmPQ8swsAAroJdhk4S7uwNsmzIUlNUxkUu39tHqmBhBl5W
         QXHYIoKxKSeYOWsA/JrK8V2z2fGtfUoJ8NQouF5Hzkuwx9eJdiHI9JqXdgANFFiCCHGN
         1bNfoim+vYQj04f4xd/K3BP4tHkN0LvcU6f2OhJ4kqRDBqxhc3LWBT1cE9/27MgihrAH
         IqNg==
X-Gm-Message-State: APjAAAXPZ0MbAqrzfTyzrcAu+AizX4RmnguTUMYQPxs8NPC1s3QxcUu9
        tTzfHaltfegi6FUjjWrzcOCnzrOG/ZAgQQ==
X-Google-Smtp-Source: APXvYqzBhnFM7SlKJzm2GX+T7m0tRfqvvbkxi8I6ixZaRzF6nvLCIjP6+yJ6bPrXj6oDdjdOB6JdXQ==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr4059609pja.104.1562727853159;
        Tue, 09 Jul 2019 20:04:13 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z13sm396715pjn.32.2019.07.09.20.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 20:04:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] ata: make qc_prep return an int
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20190709100203.19049-1-jslaby@suse.cz>
 <20190709100203.19049-2-jslaby@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ed428e5-8108-e6c5-b580-9dd20ec049f0@kernel.dk>
Date:   Tue, 9 Jul 2019 21:04:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709100203.19049-2-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/9/19 4:02 AM, Jiri Slaby wrote:
> In case a driver wants to return an error. sata_mv is one of those --
> see the next patch.

Not against the change as such, but there seems to be some confusion on
int vs enum ata_completion_errors. The latter is probably poorly named
if you're going to start using it for prep return, but would probably
still be saner to have an AC_ERR_OK as 0 and use that and use the enum.

-- 
Jens Axboe

