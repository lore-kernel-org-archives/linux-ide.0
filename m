Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031AC6FD1F
	for <linux-ide@archiver.kernel.org>; Wed, 15 Mar 2023 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCOBgI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCOBgH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2023 21:36:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6D15163
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678844160; x=1710380160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oplxjgXdM5PxlwEDg42IRu+esUCZcy0BkDT5Uan3IsA=;
  b=Q/zCv9TvaF4JwI3D8OSCQn8bsQZ0w/puuSY/RuEEIgynJxsjLCZhE+Gm
   cYfopcH0Vj3iZ1/qfrWE0wOsFFeqdpIIZ6sb0JrpDuQIzMIgQfH/BvFl4
   3WZfmIxZeNJTVHysjLLu5tVcc/VD4mYIz9+TG0YGel0NIs8jdUMRZcgrz
   a67dS0YLk2Rj2nhgXfvyEenZmQYe8Zcibcma3GImpuNKf0K9M0ZDz9CiY
   kn0vmTD/7KDISF3G7SXs8BpjQoBqPtxuFEf35/7AH4p6bmL4gDFhBi/OO
   7bA0zXs4GGEG4dNghTA3FozCVaZ9H04HeIxgG1wE3ko7jYMuz1YPGej8W
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="330029962"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:35:59 +0800
IronPort-SDR: 0F0j4ctdTuF92qbrAKkwlHRQb67p9WPvOTVE+srkGzupWsnlPgy8DG4DsRw0X1xCSL7fyywbad
 yv1jrWDReDJYhKUGRT6HsZ9IPgaszo/8YUnS5Hp0qQyN/dPYsIqxmTa+aZYCv9vn7vMXpTLIi1
 iabTByxcMNoIsQ090WMTH9+0g5s/NWCtHOR47/G3388OF4eIolAvnWz/Vtlfp/xhVkk+D1GsCI
 uioa63EQ2HvIm+YxEKrEC4oX74Rw55GY0ajSvvHiEay2M9Jh3IMnP2I6c1Agmu3EDgzIqnRPjA
 b98=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:52:26 -0700
IronPort-SDR: k/O8t7zl6gwtExvf1/72HBzd7pB1aHD6TTmoxjD+Yd6SL+HrHbbclMirnYkk6mccmwRR9SgWos
 xE58JAY0rAvKr8jMx1H10Ar3ti7bVVn3g5AKpnJBafvSTFq1etlVjStZs0PZdMHYYxGgUkPmTo
 /y6CNAtRlLCEzKxOW0dStBs431mWRlvyk0lT988IvFqfYEAVNQIHpqzxLelL5U/c61Ig4Akutz
 ZcLYx/PyzIV3sCT1t9d0o1idCfs0NppE7dPQipA0rm7/UUeu0Pdtc1tgotPMZ9tThMzz7iT2S/
 id0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:36:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbtJb2ml6z1RtVp
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:35:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678844158; x=1681436159; bh=oplxjgXdM5PxlwEDg42IRu+esUCZcy0BkDT
        5Uan3IsA=; b=CGZJpxYm1k6ns4KCac9t0Adn0IgrR+kyLgvehRdaziLjsG1e/2L
        p3JuOXztGyYSgi/hIH9mrRS13fEnPx1JHKVIQdNumBSTFODj/Fg5OsZb3HWH3S/v
        dHyUgTX8udLlBhDZecPMno3yltn83BvgSPy0IqJb3rsSbOCjx9sSonWmMCltIBW7
        dcRCtKWpVl05EDNbgP6Ys0KF9Y7fmv2hBHNBdKj690bAuH/2x8ScCg9Ef0wcpRjm
        U8i5DcvYst45YZFi6CVlTTWOk3xJ15S2LbJEtI7Pz3hz4Ry1fsq2EG61qLHHASDW
        rge4NtpiHV+2NZy0I1Ow3BgVPoBU4tD7BCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zQjY-GqJ7PYp for <linux-ide@vger.kernel.org>;
        Tue, 14 Mar 2023 18:35:58 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbtJZ0wLvz1RtVm;
        Tue, 14 Mar 2023 18:35:57 -0700 (PDT)
Message-ID: <f218e051-48de-06d1-bf0e-2517f6b3ae38@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:35:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] pata_parport: fix parport release without claim
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230311192538.29067-1-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230311192538.29067-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/12/23 04:25, Ondrej Zary wrote:
> When adapter is not found, pi->disconnect() is called without previous
> pi->connect(). This results in error like this:
> parport0: pata_parport tried to release parport when not owner
> 
> Add missing out_disconnect label and use it correctly.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied to for-6.3-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

