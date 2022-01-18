Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CAAC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jan 2022 00:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiARAFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Jan 2022 19:05:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44620 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiARAFM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2022 19:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642464312; x=1674000312;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9uw5NU8HSOFeqdJuDJB1ye6xOOQMoRtnqs0DdPQ5OUU=;
  b=S/SSYFaet8MLkVeiLkiGLsUZwIaO5k2HEJs8VN84HQaltALSD0A4Fzb4
   x301KZN9H9CEV3hPJeBLF8Yd1qaZZAQXXzXn7KuVD5wPUI9Kos4b7v7uY
   o34HHjn14BSnX4IkOg95usETFq89wayZxzQCIKoxrydo1NPwHX0PU5xPS
   N+ZR6vPiUgjykFh9+Kps2mfLuj19DCs7IJxiUO43qkPyW/y7CghNonOMV
   9t0KLjutwLtIo2F21Pd1xRH8uHv0O7H2//RnOyuQCj7sXVYHbssl5v0u0
   Jgm16MkGJvlCu1zStzcEO5WGeBkCn+4yV3PFJU5KNIkXtqawl3ZbKqIGb
   g==;
X-IronPort-AV: E=Sophos;i="5.88,296,1635177600"; 
   d="scan'208";a="294744119"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2022 08:05:11 +0800
IronPort-SDR: ScrOmQi1KzhW3hVdZs9OljQWK9Dq/JqMdWNh9ozmPmWlsuvmfZh1d8rdiNL7ge7205Q31tr6fI
 ZQK17o65f3+wjNqYBlv/8sw0s+uTrGbEmDd+o0COrAa9DgQB/78GkuIpsPn4oegQOnHiIpRgO6
 0GH30T7nNGyu50hs22nv/mLXD9y+obmYY791S2mBdH8L+zlHuEygoiN0rMA7ULJ3YfjAgr3ZQs
 KnJIGhvnXG3vCtobsb0JxTbx/iqGzCErVyNRK6pYIJBIfjn4Y9hMnoXnoG+vhAltDeDZbNQ6jY
 3SlZyH38tjJrvnJaA0VTt6lm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 15:38:44 -0800
IronPort-SDR: bhG39KwFQHDyCq8seMtro4xp8dlqEQKevnI/JXg5nHrBzav78qhjgcf4SJKdYzf/uXcBxKNEpF
 KlurKSU3HJVsx1R0slMwV33zezdN2rGOY2jnQQayWJuWYYrcErBIhr7iiT/d0nQsHyOJbhXth/
 rPWm4p3TDiPC/6W27t0GiwrscZgfhBGsNqnizlBfTLKiNOm3KgPIX7wln2TTJ0WpFyQoA//ZII
 kdaUjFCFyGZlYUCmQqade2sPOAZN/6d40ep8wv8RcUUNq2APEjhcEfVyYWiegoH7Biwz8aWNDf
 KyU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 16:05:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jd8D74Fbgz1SVp0
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 16:05:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642464311; x=1645056312; bh=9uw5NU8HSOFeqdJuDJB1ye6xOOQMoRtnqs0
        DdPQ5OUU=; b=LEQxnRsySrrCV+SY0lNf8893Rl0nu8AAf/ROEPJhfUc3tADiP8W
        LpCVe0PmV0CeKWEGcGWNWebLwCkQ9Mvxz+WksHvGKla8UrPpULyrAdlow6CqWfuN
        G6d25Xs3/it6hFuqiWxiHj6pXT883mCfUUZz+jp40pnBlOMft6XDo8cZx4VtspH4
        KyGWQ3xG5LDInB/42l3pHmAk1KRSl7xgssLDglbCgZCiB6fvf8wXs8vgVhfPxWCv
        XGQjDr/pDfTZReRKg6AutHmkGdLyLqLLUeYz8IbDgsY3LlIdV2yIu6SOf807tyLa
        //zvIEjXaBtfcy8aViq3yrwgydwPv0guBzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hpiKsjXbfzQm for <linux-ide@vger.kernel.org>;
        Mon, 17 Jan 2022 16:05:11 -0800 (PST)
Received: from [10.225.163.49] (unknown [10.225.163.49])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jd8D66KHxz1Rwrw;
        Mon, 17 Jan 2022 16:05:10 -0800 (PST)
Message-ID: <017131e8-50c5-567e-6b17-b82dc65ae3d6@opensource.wdc.com>
Date:   Tue, 18 Jan 2022 09:05:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Samsung t5 / t7 problem with ncq trim
Content-Language: en-US
To:     Sven Hugi <hugi.sven@gmail.com>, linux-ide@vger.kernel.org
References: <CAFrqyV5qv3K4m5m__VGfs5O_ocx0LDa=Dyiqc=rtGj9OwqsO3g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAFrqyV5qv3K4m5m__VGfs5O_ocx0LDa=Dyiqc=rtGj9OwqsO3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/18/22 05:02, Sven Hugi wrote:
> Hello
> 
> I hope, that this is the correct mailinglist... if not, pls let me know...
> 
> So, there is a problem with the samsung t5 and t7, those ssd's are
> just samsung 850 with an usb-c adapter.

Then the SSDs are likely seen as scsi devices rather than ATA ones,
through USB mass storage/UAS (USB attached SCSI). So the problem may
come from the USB-C adapter in the device, which would explain why the
changes you show below are ineffective.

See the output of:

scripts/get_maintainer.pl  drivers/usb/storage/uas.c

to see who to contact about that problem.

> They should get added to the ata_device_blacklist in libata-core.c
> Those 4 lines should work in theory, but i was unable to test it,
> would be nice, if someone how knows what he is doing could do this.
> 
> { "Samsung Portable SSD T5",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>                                         ATA_HORKAGE_ZERO_AFTER_TRIM, },
> { "Samsung Portable SSD T3",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>                                         ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
> Sorry for my poor english
> 
> I hope this helps somehow fix the problem.
> 
> Best regards
> 


-- 
Damien Le Moal
Western Digital Research
