Return-Path: <SRS0=oJiQ=UY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CDC48BD5
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C41215EA
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2RHGDQpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfFYPfr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:35:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45023 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfFYPfq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2019 11:35:46 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so4143726iob.11
        for <linux-ide@vger.kernel.org>; Tue, 25 Jun 2019 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qAEoMfdaMGcFfOg1G5ymzcp9AU69am23zNkF2oKzZGU=;
        b=2RHGDQpynqDIXdYkN51hbtu7BJF7SsSaGyvro0xx+E6Y/kwID+E4QvM8uGjqbqYrs8
         RFzBspBgh6MRxJVidQgxC3+ntmvhmSrTmD7C9IYA5VGcJexiC7LNe+JoubG378s3wmGn
         lmO5vaSt3G8lfHGxED6SrMA96exqvJ6ZyG3AKGYhW+MSw0wrvEH6p5NvVmFcFACIOEl3
         jPxsrDGBwRwmnVS15JSZgWsPXW1cOdbV9JbRSLGI5ARSRT1CtttTM6nqOmGqr+6buSvx
         v8+/sVMDKg3MtwrLe0OmVPMjOksA5Dszy5ZejrzSJLM6c/mrXg1Vsf8c+8eJcreyDdZR
         8YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qAEoMfdaMGcFfOg1G5ymzcp9AU69am23zNkF2oKzZGU=;
        b=IdLt/j5/IfzS+31USOuNSuH2kSEqccEaUgc50ZP8dBfvjupjuw+S5uJqWlDy1RizoZ
         TAXLp/Kr1Xif0jQ4NvUOa+a7WbWO9bYQ442IXf9mWOnA2Dpke7qE/WnRQp9RmGDs+7Ui
         r/uq3vJG2JjjZz+SlL8nCV9DlT+78nh1AZDUG242rjmbFypXdsvCZOLf3LywN35O+wKm
         Sk9XP9azckwUeSQqqc4SO04vUIKys87GuI8OuDw3E9Z6nFHcfOzEHIwk0e6gIRRPqk6q
         0XsInjNkYvGTpoAVj66iHk6OAM5WT2CiOtmXBs34aXebIjK8K2tBuUmObWaJ8uiOBDen
         63mQ==
X-Gm-Message-State: APjAAAWQfrCZGHFCH74ZpuSTcGm1gxBd/c6Al44ON/JOBHq3J6Ko+0Gm
        on1pa6vrQK8TzGeYPKaDMmVpNA==
X-Google-Smtp-Source: APXvYqyr2hKVmp3s7Rx8Sy0/cGhSolGFDS8NtXQaALA/4txfsr29jc4vveo1JDR3fWYKCkKRpYII4w==
X-Received: by 2002:a6b:4101:: with SMTP id n1mr220040ioa.138.1561476946181;
        Tue, 25 Jun 2019 08:35:46 -0700 (PDT)
Received: from [172.19.131.32] ([8.46.75.11])
        by smtp.gmail.com with ESMTPSA id h19sm17014021iol.65.2019.06.25.08.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:35:45 -0700 (PDT)
Subject: Re: [PATCH] libata: don't request sense data on !ZAC ATA devices
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        kernel-team@fb.com
References: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d864165-79be-ea02-59ba-3a3d00bdfaf2@kernel.dk>
Date:   Tue, 25 Jun 2019 09:35:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/24/19 10:32 AM, Tejun Heo wrote:
> ZAC support added sense data requesting on error for both ZAC and ATA
> devices. This seems to cause erratic error handling behaviors on some
> SSDs where the device reports sense data availability and then
> delivers the wrong content making EH take the wrong actions.  The
> failure mode was sporadic on a LITE-ON ssd and couldn't be reliably
> reproduced.
> 
> There is no value in requesting sense data from non-ZAC ATA devices
> while there's a significant risk of introducing EH misbehaviors which
> are difficult to reproduce and fix.  Let's do the sense data dancing
> only for ZAC devices.

Applied, thanks Tejun.

-- 
Jens Axboe

