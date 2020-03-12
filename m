Return-Path: <SRS0=Eprx=45=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B629C1975A
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1936920663
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wcqOcX9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCLOET (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:04:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43323 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCLOET (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2020 10:04:19 -0400
Received: by mail-il1-f196.google.com with SMTP id d14so5022762ilq.10
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2020 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8G+gwUzbb7/chI2AWwgAsitbf2nC7fPocoJMuqbMv5s=;
        b=wcqOcX9t3NDPxq8oDeF8oc1rm2Oa1x6huiw8IMno4/dWY+UrIdnDKhB05XQh+ke1GN
         mOLG2a1enoA00b8UfGVjLEA1nSSMT+4scTOV2qqe3n5ZcCYSmqa3Kr+5HF2uyzcCQVGG
         txyjC2dW4TaS6iPaQl7nncTfWTGRC2rjWq1qibA+2rN2gcObzEiImu9qWF7qCMyvIZV0
         usNk9j+XXO0briEerS9JIknbTPzxj3xhtWqaWCLQzQTue/oGMWXgLB5iAy4G9Bj+FVOs
         Zg8cMDQJ95w96L8B9VdzLelwMsaJ+/y28RiXJbVQ/aFX6U/n0MHwqBzspG2bok9j3+8N
         K0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8G+gwUzbb7/chI2AWwgAsitbf2nC7fPocoJMuqbMv5s=;
        b=jEkrfI0J9CQx6uBztxS8o2WsESIY6SG0OV4UrLtgMQOus59a6wWAtZoY4FNAWffxpv
         aD9UbJ+Wc/RpPSlW2Yt8+qXlfar/QuFubH6cqtGHhcBua7+ug3Eh/8D69A80o5H4jL/A
         seYi4NpGA4ThpZDW/UzaHuR2XfMNXLznu3UWdqI/ZwBKfKUc4lRINxNIExYLMxEgEnGe
         jLdQqUZcewnCKbWLWOXCqgmA4ruRk/IQmCf7P6G7ARFixjF17UaJZUCDMONlC7a/y8Pa
         KMbqp1S7iMEo5H2se4S0WKJ3un14NQ1dqlob/yQT/a/EgaR06jZEtlyjZX/B+uR7ZEbF
         VHEQ==
X-Gm-Message-State: ANhLgQ2FmSa8eJZV/1OmSd+Km+EqYnb2GjBKceCRJr7AFlZ+QcRAR+yp
        T04QL9RGznQQQXlpiZoaLSWjT1nsajCINA==
X-Google-Smtp-Source: ADFU+vvYvjCDV7pHIl27ElMcqBAvbhJZuNIGHX4wmeOWb5u0vZ3QhmwG+b6UJtITn6pqKvxjZzMVzw==
X-Received: by 2002:a92:49d4:: with SMTP id k81mr8557394ilg.289.1584021858386;
        Thu, 12 Mar 2020 07:04:18 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a21sm15083706ioh.29.2020.03.12.07.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:04:17 -0700 (PDT)
Subject: Re: [PATCHv3 00/40] ata: kill ATA_DEBUG
To:     Hannes Reinecke <hare@suse.de>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org
References: <20200303093813.18523-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20da7527-e8de-f1e9-24d8-7650a0291f7a@kernel.dk>
Date:   Thu, 12 Mar 2020 08:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/20 2:37 AM, Hannes Reinecke wrote:
> Hi all,
> 
> this is a rewrite of an earlier patchset titled
> 'ata: move DPRINTK to dynamic debugging'.
> The overall idea is that it's really tiresome to having
> to recompile the kernel every time one wants or needs
> to debug ata issues, especially as the kernel already provides
> mechanism for dynamic debugging messages.
> 
> At the same time dynamic debugging does increase the load on
> the logging subsystem, and things like printk() are poorly
> suited for high-speed logging.
> 
> So this patchset does several things:
> - cleans up the logging messages by removing duplicate
>   or pointless messages
> - Converts I/O and error handling related messages to
>   tracepoints
> - Moves all remaining messages over to dynamic debugging
> 
> With that ATA_DEBUG can be killed.
> 
> Note, I'll be preparing an additional patchset for killing
> off ATA_VERBOSE_DEBUG, too, but wanted to get this one out
> first before it becomes too large.

Applied for 5.7.

-- 
Jens Axboe

