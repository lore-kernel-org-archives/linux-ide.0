Return-Path: <SRS0=hcVH=V4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F9C32751
	for <linux-ide@archiver.kernel.org>; Wed, 31 Jul 2019 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2682520659
	for <linux-ide@archiver.kernel.org>; Wed, 31 Jul 2019 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IPz2gG+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbfGaOvF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:51:05 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41914 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfGaOvF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jul 2019 10:51:05 -0400
Received: by mail-io1-f54.google.com with SMTP id j5so132731950ioj.8
        for <linux-ide@vger.kernel.org>; Wed, 31 Jul 2019 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+hJcglQKsXhxYcWrna658gQ9B56W6mc5bB1Q9aiEEZc=;
        b=IPz2gG+1/xXqXZFeRzJM9JDdc78Kqh8+cFW3aNkrgHdi2LMeM4UWwoX+rZj9bNU8mC
         yyLWRaxxTPG4w9vW+osG78TlwXFyrEeOuzOL6yG9Hnq1y+lR3G4Y4/n2Jl7b7O+CjErd
         VY45Xr2mbr1cbPfcFof0qLjUjpW7pvAfqHPExZGeKqYDdb28GW9SH3jDBoqbJDhWFZP0
         5KeJUZWyj83XZ19SBKx46fj6cvkBn072ENbtPhkqZLAHNedxi8vSrJ8MNLpZnQgSRdJG
         K0048zy9C4t993qxi+Px0WSHkZ8DDsX7Ej5HD8lmo0Xx35SczF3YWtA1Ivzt6v04MW/J
         JwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+hJcglQKsXhxYcWrna658gQ9B56W6mc5bB1Q9aiEEZc=;
        b=dFc8u8+qI8uQM5L59rdwvz9aYkbQmPjcZ4O0tq1+cb9rcX5I3+q7KOnyHs9Zxkco5L
         5qMVH0xW1arhxgGlO2xvkPb69wVagIQyljY8AQxYUZevPd7dKtt39ZeSGOnsVerPrXRs
         ug1g2rIS6a6wE3mPutqLxr1W7a1AByr1eUJ3wfppKrQSZjJpiC+1BRlBqMwjFni37lvr
         DBpfamJpxwpvnDnnw+K7v4LQX2Vc9rptt2rPUP0NYfZMEW20v1WPPUMr3kBGgVQyYThj
         SNN84TC1DG1IgRv90Lf7JjFThw14RmCQ+ozNUDz8AcgNFEWoIk7K9/LTv215sIVwWdLh
         1XVw==
X-Gm-Message-State: APjAAAV80PFv0JFbf4YKszy/n4XuRUh0c5xvBW1YbLrScrAWumPkm5Zv
        3bXc/QG3e8dkDnb/b574RMy2LTyyJOQ=
X-Google-Smtp-Source: APXvYqwJATfi8I6o3vkTo8886RKmM4EXKAAoZ1cC3r/giDFvrwx6HdiUGgbxVAd2tp1VFtAjikOiqg==
X-Received: by 2002:a5d:8747:: with SMTP id k7mr97569156iol.20.1564584664424;
        Wed, 31 Jul 2019 07:51:04 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm55027937iok.19.2019.07.31.07.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:51:03 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci: do not complain in case of deferred probe
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-ide@vger.kernel.org
References: <20190731122651.3378-1-miquel.raynal@bootlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9606c11-7e8e-d8fe-f452-306750e9ab5a@kernel.dk>
Date:   Wed, 31 Jul 2019 08:51:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731122651.3378-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/31/19 6:26 AM, Miquel Raynal wrote:
> Retrieving PHYs can deffer the probe, do not spawn an error when
> -EPROBE_DEFER is returned, it is normal behavior.

Applied, thanks.

-- 
Jens Axboe

