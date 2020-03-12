Return-Path: <SRS0=Eprx=45=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A55DC10DCE
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C891720650
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZrTUsMRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCLNjq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:39:46 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43186 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgCLNjq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2020 09:39:46 -0400
Received: by mail-il1-f196.google.com with SMTP id d14so4944241ilq.10
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2020 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xy2H4VC/wJMkxvu084/wfqnTB3IBWIagFQJVaZmZ9J4=;
        b=ZrTUsMRLvq1VLy7Ax4Th3UzmJGEyBohccdttMACKufhoB5MnsjS47UrdMU1MwoFkJ7
         ubDy6wNgXQdg3Pv0iNehpjh/XFCSKB8IIDglrPhKqEDr42VPAbw6QbsQViXLFrkiyFkc
         RPBnpZv3CaSFa0kYiSXmRbb9Z2NmDqk4j5OBuustobnBmBxUvXjfOTwA4LFWyZtghtCf
         2tUlTPMAb+7HTr4a41nRoHCKSevBd8lZ3n9f7f6PF8KvEXzI2FfQkrATA4lKV6sbO48j
         soA9j/P3F2JhRo3GtLWT23PvlJlKsDWqp/OsJBWDwtQQsGlZ+mU8KLm3h1d37wcUwWyd
         XpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xy2H4VC/wJMkxvu084/wfqnTB3IBWIagFQJVaZmZ9J4=;
        b=aZ6FgQkDTZwzpfdgWxofxn2LC2aCr+WLsu19U3DR+dNgxGoNUOlpT1ETnnNzdsWIzu
         y4y1fZYz8U/WrTqkkyH5xAhvGW+ePlH8Se78g2Bd0ajTyNF7Slzo4jte15qZ5CNVnrd/
         0jhnvrFbvpEJH1vfkIFnXoWP9JOQgYqRM68v7XspWuIwJJMZSbDM7tKWlWGbsN1MwZW8
         XTlbfxvkkq+HJept8+1ofwifVMKS2V0w67d9Zmw0z2q0pWjhCtsHLp8miF9kJS+BtFDy
         EBNTk8ALIotWKcwUl6uuRXEfO4e0cL1WjJ0zC6JNSdo4JjMMQqfVkn07jVZN8PGhq6we
         Y7dQ==
X-Gm-Message-State: ANhLgQ0PA0nDLMSsJbkj1OXxqLpJHr0/7H+5xgdsLoR6d35rGwQOJ6Du
        iM8W+JX4Px1XBPq6uEWHWV1tmUWXL3Umzg==
X-Google-Smtp-Source: ADFU+vsmQAsop77kmj/XRlyd3gtNUVFOADF1rRO3mgUQhBk1saKJKme7CiIrK4iWb0am3PMy+5Y+CQ==
X-Received: by 2002:a92:ba01:: with SMTP id o1mr482824ili.217.1584020385239;
        Thu, 12 Mar 2020 06:39:45 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q20sm2843852ioh.37.2020.03.12.06.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:39:44 -0700 (PDT)
Subject: Re: [PATCH] libata: transport: Use scnprintf() for avoiding potential
 buffer overflow
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20200311071100.3969-1-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <76873f3a-92be-07cf-5039-d9d05c7cbaca@kernel.dk>
Date:   Thu, 12 Mar 2020 07:39:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311071100.3969-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/11/20 1:11 AM, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Applied for 5.7, thanks.

-- 
Jens Axboe

