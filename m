Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A06C43331
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D722073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vqpcchf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCZPRU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:17:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46817 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCZPRU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:17:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so2901674pff.13
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgOWd2mmKFNevzzwZmClgw5vOEafrGQd9YYx6vt9JK4=;
        b=Vqpcchf00mOVPcS78f6v1MHgrYZAW4q8KRX797u2FHxh2gJu7Jx/wPI/7JJqzA7V1w
         tl7mJi1i9C4bpk/3D7Gs3n4Nn2kXTwLejNXRgRzOs/q+uHlQ66DUfwL5DdKN/P0mKFo9
         HlPY4HTh3kX0K4brFQgWCvygGCmh7ZD+Hu492nSNZNQH+Mv/ko6mchmNCcWLjT1XJ/j6
         W7B1SMBGnkLhWY7PrtwKrpZk1UCgSBV1h02c1WPQo7bqSAUslTeMVXlSCoVR4hK0LeDB
         fJ8V7Yf+M/gbySCtgTsmvpl4zTk/ndFGwOeH69Kr3kFjBr/SCb8VKXeGRa0MnwLIfuHs
         AcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgOWd2mmKFNevzzwZmClgw5vOEafrGQd9YYx6vt9JK4=;
        b=CmyVExK1G9seGxsXUu+Tzm/dwzsWeIz7U1GmJ1rzB6/8hnNLbVEUQ/oTRn6Sx9DAtR
         HQjxv9D7oBgwM2+OrHTWH+g90CCIrdC3GFADudmzFeEvKIFuC9WkXLlAOqetE8dZTX5m
         X3p8DGV6tE93s200Z81QKk2m4XwDBNl7SmdL4Gqwcq5lSdexYt1f9Vncpq31xz40pcFN
         p2wCy2gBp4eEG8mlGpTMlXFQsQ0jYUE0hYfkLzseiH40Gbd/EfzH5NqqDUHOe9cTVNeh
         mV8bfRoEQppijoPCaP/XZARpTlwerMKpPMX5oOPA86AsZ9IZ4CQjBzWg9epiq6UFx/le
         EtUQ==
X-Gm-Message-State: ANhLgQ2E5HMUmawcy6D1dsSg7H02EwdZMIUSMYJZ+zBOBZeeyUlJVS4K
        wBW0c0jR97QPJEUF/zBHCZLDJQ==
X-Google-Smtp-Source: ADFU+vvrhAugJMt0hChhUDacr6c1uF+Pf7E91Y3u6GT6xmUbUr9taW0rOVFoiywIwydmB2lMlt8/DQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr9569423pfc.230.1585235837937;
        Thu, 26 Mar 2020 08:17:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s137sm1999703pfs.45.2020.03.26.08.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 08:17:16 -0700 (PDT)
Subject: Re: [linux-next PATCH] ata: sata_fsl: fix a compile error
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200325235921.22431-1-leoyang.li@nxp.com>
 <7dda967d-4328-abd1-2687-95bc213030dc@cogentembedded.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34cdd2ed-f272-668f-03bc-18cc9efd57c0@kernel.dk>
Date:   Thu, 26 Mar 2020 09:17:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7dda967d-4328-abd1-2687-95bc213030dc@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/26/20 3:06 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 26.03.2020 2:59, Li Yang wrote:
> 
>> drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
>> drivers/ata/sata_fsl.c:1365:15: error: 'ap' undeclared (first use in this function)
>>    ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
>  >                 ^
> 
>     Another fix has been posted yesterday.

I also dropped the series yesterday, so we don't need any of these
patches anymore.

-- 
Jens Axboe

