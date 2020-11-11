Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5B8C388F9
	for <linux-ide@archiver.kernel.org>; Wed, 11 Nov 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B6920791
	for <linux-ide@archiver.kernel.org>; Wed, 11 Nov 2020 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E+UT7uDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKKQR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQR5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2020 11:17:57 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226CC0613D1
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2020 08:17:57 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s10so2877021ioe.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2020 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hIBjUOhCL4FamySv2BSK1WhnluetPINBm9sx/SODghk=;
        b=E+UT7uDKzv8M0Zf2lZ8UIYK1hcqMDMAvoGTdUr0tHYghvlxNxqiQgOW/5iqLyKbRZS
         zVvYZGeU4MSOIwiwwYIlWhf/37CVkuzMdXfkbJgAuUAynl3foV2aD2CgntKM01Eag1w6
         pQ8HBth/OBv12+fhMJKQGc1NkC3aSg3Ood/4QEvHAIURwz7xRQ3LiqHo+gH4kHkz/Tzz
         kGrYC8QFOWBAL14ps4gGvDC3EJQ6RukmqNG7qjjJB2x3L16pNJsAI7fQJAXbZiNkIOyF
         gOqtjfkreX6lm/ivN+Yhkt5U9rTka4eIy5SeWvarGIF0s96mi2fbJkGPVSL4J27D/Boc
         p0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hIBjUOhCL4FamySv2BSK1WhnluetPINBm9sx/SODghk=;
        b=gDz9ldwJ0jMZqIexli/xMZoOWtmGmfoippUFbNWoM8/jrCbPCUYX1L1iRTyC262t1s
         vdZGcYBpZv/tXcYPaK8CBQFwEV1d4Sd58zCTECPYOWKkHI8U422eKQ8RdOPVBzRi71Tx
         vGzVUzq1+19tIYASvrzJOWIljv+Bib3Rn0pNkk7GkU3V+hfr8dCsoztcBX4ObQns2f6l
         T2YpQPYCjFctGXcv1GZgJM+iH7no2xPUtjmiP9xX7T2YZqq1UhP37/PgF7RS9B1Fx1FN
         K0ji3M9XbhdTE12Fz2WaEr3E301sXLkfHj5aCakSY3d/cpyBimxOwGC6VY5iJ0HOY4k9
         IP7A==
X-Gm-Message-State: AOAM5327KRXAsVQqrvZeURgtv5RKySKJdqVHOt4hLf/Tbre1HFwKq3SS
        Azf2IA+TiGJyJUL20COJMQwUXw==
X-Google-Smtp-Source: ABdhPJyWFXPFFosbpi7Mw4IBURM5g2Va17wNDYQIiOuR5s1zvzKiVX4DBgORaOVic1unFcvUrR9Xmg==
X-Received: by 2002:a6b:7114:: with SMTP id q20mr18531488iog.16.1605111477264;
        Wed, 11 Nov 2020 08:17:57 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v63sm1404927ioe.52.2020.11.11.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:17:56 -0800 (PST)
Subject: Re: simplify gendisk lookup and remove struct block_device aliases v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20201029145841.144173-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92e869be-9717-8d97-a962-a630a2517f00@kernel.dk>
Date:   Wed, 11 Nov 2020 09:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029145841.144173-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/29/20 8:58 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the annoying struct block_device aliases, which can
> happen for a bunch of old floppy drivers (and z2ram).  In that case
> multiple struct block device instances for different dev_t's can point
> to the same gendisk, without being partitions.  The cause for that
> is the probe/get callback registered through blk_register_regions.
> 
> This series removes blk_register_region entirely, splitting it it into
> a simple xarray lookup of registered gendisks, and a probe callback
> stored in the major_names array that can be used for modprobe overrides
> or creating devices on demands when no gendisk is found.  The old
> remapping is gone entirely, and instead the 4 remaining drivers just
> register a gendisk for each operating mode.  In case of the two drivers
> that have lots of aliases that is done on-demand using the new probe
> callback, while for the other two I simply register all at probe time
> to keep things simple.
> 
> Note that the m68k drivers are compile tested only.

Applied, thanks.

-- 
Jens Axboe

