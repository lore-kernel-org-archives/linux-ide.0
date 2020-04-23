Return-Path: <SRS0=1fB0=6H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5224C54FCB
	for <linux-ide@archiver.kernel.org>; Thu, 23 Apr 2020 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A383220728
	for <linux-ide@archiver.kernel.org>; Thu, 23 Apr 2020 15:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e8CQ6cVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgDWP7z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgDWP7z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2020 11:59:55 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05653C09B040
        for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2020 08:59:55 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s10so5997097iln.11
        for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2020 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H56dCNWzMv1cG8zQ/XZsLJBghV5eUZ/t0Tde2AZJjDc=;
        b=e8CQ6cVkj8IRAa5QO8Y30+bpwk40P/+McqYiWfbmVRwPmyC0XA3u2eI0NRoKwGh1MR
         AJXQPYoiXm2o3bJrI6devMXI9bjdABTAwRfVSJag50kufWErhkvsAOo54d8VzipIlrSr
         on/Sbsp5SkRHmxDbFJyx3z1hPyZnmrqCPyO5wcwYOGv+TYIVdk1bMM/MuykhAfHL0ryj
         05B9eUqSAj3y/Ed7GEa01y5UWFYTK8fQjSfwl6q2wMUjEKgp1w8A/NaVgrvqdT1l9AuD
         gcjOn/XGvp8I2+RW5hvvEH/NrbkOq4C6h4QoJMnmw/lNsbWOzbrhUqezU36rkQqOm9kq
         lKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H56dCNWzMv1cG8zQ/XZsLJBghV5eUZ/t0Tde2AZJjDc=;
        b=RGjgDni2x+He5RUXbqgrdmtaOikb8UvbHWj1tJrFw/zW6gIHncOG9gMokQlF2I5oqh
         e75zLSwrC3M4RXlF2GDYrroOJovEHtqQP6X7KI3JrZfcVF8krr9Nb7Tvvf8xK6oMX7pJ
         2qWcRoYabbDoLww9hd6hY78R2rIXHsORgyOZdLtXazGqm6lQLmsEYn6bleJThld4wDM5
         ra4xTqG+Ejte8nvz8EDVEigGQMXOAiykBvV/8Vh4yKe/7XkcVldVfherwihF65DCz84a
         zcIGXNesXShWHTqRAxf0OqqTq4BS5Cl41Z87vRKceuWkSuYFiNl95HrNDcvqV50tbm2g
         0iJg==
X-Gm-Message-State: AGi0PuZEyo6E60WeHOUmy6Q8XCsWvAf8mx5fNdvEd+UWRGcOsnENpRan
        +uO7cu07rndoCIJWUP3M0RCLMnNKFNgxpQ==
X-Google-Smtp-Source: APiQypILHtPjs8/054VadV1CS6zFpJtI717uwmdHbv1h8zY1V+PUwUYTwFzoF49ovXZGcgQFpzBWPA==
X-Received: by 2002:a92:d90b:: with SMTP id s11mr4155392iln.295.1587657594040;
        Thu, 23 Apr 2020 08:59:54 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o202sm999084ila.57.2020.04.23.08.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:59:52 -0700 (PDT)
Subject: Re: [PATCH] ata: sata_inic162x fixed a spelling issue
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200423090742.20590-1-john.oldman@polehill.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec61b2c1-3b7b-9b17-77a0-b131da1eca79@kernel.dk>
Date:   Thu, 23 Apr 2020 09:59:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423090742.20590-1-john.oldman@polehill.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/23/20 3:07 AM, John Oldman wrote:
> Fixed a warning message spelling issue.

Applied, thanks.

-- 
Jens Axboe

