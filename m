Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335DC433E7
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FAC207EA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zxLiXEe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBRbs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBRbq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2020 13:31:46 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E45C061244
        for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2020 10:31:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b6so6148035iof.6
        for <linux-ide@vger.kernel.org>; Wed, 02 Sep 2020 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNcwkSk2B1rp+WPqbZwtkVTZaZCNTmyixloLaFnMgN4=;
        b=zxLiXEe7FcqLA236ub19LzbT74DmbTH554TuWJGMAq+Xg9LdCdmtvWjkYYDlnBoCFN
         aFyINAOi7tQPZkOC0Y00zx3NtgKaae2k72hZ7kO8uRya10WUThvFtjlBgP5LxnXk3Q2l
         HJoEj1Wo31bnjguKQSp0Gk01GZ5DN8Usl9vrYe/gTFHj/G6xO6/wByKygMvepYxG3H+t
         pliM12ZzyEjMF2p9nSoV56e8P1hdLg5IMmDRq4Yy+qztImK19VvWfw5njikmWjrgHpGf
         Vx0ZFSyL1Pf3xmvO6X1jrMeaFD9NbbpqwHpvCtBF/pT8YX3XIHpsshaYkAqkrmj5nImz
         IPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNcwkSk2B1rp+WPqbZwtkVTZaZCNTmyixloLaFnMgN4=;
        b=jq/+KYgYoakJ0WWioQLmJtH2Ubyf8X4rWqS2wMokQdQMHsGfaJrqnjyNCtibkZE2f8
         ObIUHJKZ/hDg+hVOUx/IIuwwmNg4UAbwpHuRIYryiBJM3cnYSONHyJPwVr++Fsq2RUX2
         2Mw8PV7HHtw9QqJdlBJ63DyPuPmzEDayC4zccWFOaHfLSWTixNCMToo8h6sRs12fgX5m
         dJ78RFgiMK9lC+mFgMZyXbCKhmzws5gNLNF6o2TKcqh2CFH+cjAMouaLCOpSqUCMmoir
         wpT4eIv5TARz58V+rSuRbNhk7KK+zPaxa8LnhARoemDe0eFwRYTZxegpjRs5fMzfPtCR
         kiZg==
X-Gm-Message-State: AOAM5307E/TPeH85j9sCxMC+KzR+JH9M457BXds3ADaHO3EMp2W/dy9r
        a7Jy3xcLXQ19OFlQ2wq6p7ETSw==
X-Google-Smtp-Source: ABdhPJysWrposnE60UfJEHxE712jJ+XBGk+b8zZeG2pqeg95CVvl5ezYZhWBWgUaeuPLIYBY7KFVbQ==
X-Received: by 2002:a6b:2c44:: with SMTP id s65mr4232514ios.185.1599067905670;
        Wed, 02 Sep 2020 10:31:45 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z9sm77578ilm.78.2020.09.02.10.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:31:45 -0700 (PDT)
Subject: Re: [libata-5.9] libata: implement ATA_HORKAGE_MAX_TRIM_128M and
 apply to Sandisks
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org, kernel-team@fb.com, karthikgs@fb.com
References: <20200902163245.GH4230@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d91d7882-3610-6b98-050c-d720b8b6249f@kernel.dk>
Date:   Wed, 2 Sep 2020 11:31:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902163245.GH4230@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/2/20 10:32 AM, Tejun Heo wrote:
> All three generations of Sandisk SSDs lock up hard intermittently.
> Experiments showed that disabling NCQ lowered the failure rate significantly
> and the kernel has been disabling NCQ for some models of SD7's and 8's,
> which is obviously undesirable.
> 
> Karthik worked with Sandisk to root cause the hard lockups to trim commands
> larger than 128M. This patch implements ATA_HORKAGE_MAX_TRIM_128M which
> limits max trim size to 128M and applies it to all three generations of
> Sandisk SSDs.

Applied for 5.9, thanks Tejun.

-- 
Jens Axboe

