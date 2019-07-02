Return-Path: <SRS0=9A0L=VA=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E0C5B57D
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DA6218AD
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fxfGahkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGCAnQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:43:16 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34951 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAnP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jul 2019 20:43:15 -0400
Received: by mail-pf1-f170.google.com with SMTP id d126so298860pfd.2
        for <linux-ide@vger.kernel.org>; Tue, 02 Jul 2019 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vWKVyxqHmDEYPvZBOZ7UPxvEAgIFDSKgV7/fFiA+y4A=;
        b=fxfGahkGIxoDTfhE1sJ+yImR2UPB1XhEFL3mwmfjlGXZnHphJoCYqAEMDHb5r07Q3w
         OFuTcTtG9J7TRl8GgcK9eGS5qNlUZe4AJvLPOUi3vNMw8NtGV+CZdsG5VRtF+KC08EPd
         ysNIzIyeKFRSYNhObq/b2cbriP0aSrxEx7EGrHdNjn6eRSwICCHukApXtZoGbyEeNLr8
         MiuUl/SnwrpoS+A9E2kUelDfBGT9mCl8+Fum1nUEd+KqTUvLvQ3nn2guOrdJ09y+XBLd
         F2K4Mm1OSAvykP+SH5WV4dtKYQsjrtmyU/oz2Knxbp8uZbn+SiqUNMvHaEbFzoeDVOxE
         oXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vWKVyxqHmDEYPvZBOZ7UPxvEAgIFDSKgV7/fFiA+y4A=;
        b=IVfD0J3AGySeK35EALEm5P0Bg2PeULn0FrEqdTx8sf1odjS0+SNM8iP0bVH7byufgu
         emDrAYjYdgg72u8P7HxnBKuBx1JZgC/U8SWyLO0JEfllYg3B4FgDDWK0y8lF4/DTGe/v
         A7ZQ2BVU4eAgeRRO4CjPm0y8fLvXZm79jwbHph83pksk5NL2Etyp751amT0vdJh0lI+w
         dIMfKVJsPp6859f/QdTfWClAWBg7RGqJ2yPdFyabCosy4H51xWeMbSjUOnPmr3OWd3wR
         u02EvcTNaFyPeS5FQdfo/1GAZviYVtJ6rRbB60N4D+SR7Qvif4ipwaIFd/xbeb4y2Fyd
         OxdQ==
X-Gm-Message-State: APjAAAWigohw9gBoW7uAzPMKdbyhgW7lFMHfhgeMTGeBgC1L1HfrlDQJ
        Big3mKHe9DmhuXy8XehepoygMJUF2HY=
X-Google-Smtp-Source: APXvYqwy4T+fCByg6refz29geB9T1xyWvzGcPP/tDtwjiiUWwGylDLV0/vtd2KvuUukQcGUYYmpWxg==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr7719511pjo.137.1562104418853;
        Tue, 02 Jul 2019 14:53:38 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g2sm54497pfb.95.2019.07.02.14.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 14:53:37 -0700 (PDT)
Subject: Re: [PATCH] libata: Drop firmware version check from the ST1000LM024
 quirk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190701165813.15607-1-hdegoede@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e466a134-765d-af21-1b28-d4743b58ecb5@kernel.dk>
Date:   Tue, 2 Jul 2019 15:53:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701165813.15607-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/1/19 10:58 AM, Hans de Goede wrote:
> There are several firmware versions between version 2AR10001 and
> 2BA30001, presumably these also have broken FPDMA_AA activation, so
> lets play it safe and apply the quirk to all firmware versions.

Applied, thanks Hans.

-- 
Jens Axboe

