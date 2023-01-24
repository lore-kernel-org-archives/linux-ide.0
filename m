Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23732C61D97
	for <linux-ide@archiver.kernel.org>; Tue, 24 Jan 2023 21:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAXVgW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjAXVgU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 16:36:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BC48A05
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 13:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674596179; x=1706132179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MaeulGlWcam/cauFGlIbI6QYkQXS6fmIFOQvrLj/zE0=;
  b=npF3NL5SfNjYRNwCwddVuriX68ug4cEmz0MClcIS5mvJTb3Z1czAvEuF
   RzvRtGJ5pEAqkj7FxSAAeQSZ+qFZSWm1w2xX2sDCQeG3lIrtfoazPABgA
   StwQ6fzedOmnUT61sLqSuuAHpbTKB7YAhA4mUYOPeUbxiXhbfDgwvrh+U
   uMY8asHhjoz0Kzv90JKIBnu6x5nQushVQCeNGE8BTS/DC3XP+zSRHOHxm
   hLpRkRUY+DrDMWhzOiwUV5IDRGXK+k3ecXtWS3TlJaDyp+WEl/bKdQ3t9
   JCBUwMQDKGtJKSbnrrD3q19bvA2XbNODZrzhLIqFRAzZnYUl9UjdBZUeI
   g==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="325971142"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 05:36:18 +0800
IronPort-SDR: YiqbffVhn5UUWPhqu/kHb03ujRpI0/LGcV3lvmPRXc0y+AEo4QpuFraPkTd0uBs+n1a/B+F+vS
 vMneXJiDhZm2VrYinkP9+Cnlzg1+K0av4ZOBqjLF323E+nEeBro9bzjnj68saSkSDr7+bV2jfq
 jmESN0QBlqSJfdBVxqkvqfaoTssYgl9dTBst/lBu4k9ApbU7poUrvWGrZoYQmn5Wz2nwAydWCz
 hcRUYUyGuuKJK5/q9a/XbDxSTQ6SK0mzDFoG9bN2Pr4lNzZ33SWbtNVLcfFPDWU2mt+OAYquiN
 hfY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 12:48:06 -0800
IronPort-SDR: Vi9gXUP552X+TpaPs6H35A1qkK31bDJIZyIG04kUfD7qIDCfX28k86lcxd6AEob5w9z1ewpm5I
 rN2sHlmgCjYpIARrQkG4G/FRchVM7UY5hqQgbs7pmid+PALhGRkgP3FKLsGW56ERMaXM7DB5fj
 ldtutjt/z+VNEyd5lobGoHYsOBqBW82Sd8zjKXsHHlMxtRdoaeAg3rAcSo9aYkcS9Apu/VBDlO
 4J4o6jZjKQeiWqVnRBV0VZElfuT4RSZ1tLE+IvVK+K7zaOxULWc7BVUVtF57RDjATA4UpF9rp1
 /Bs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 13:36:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1gJf1dZpz1RwtC
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 13:36:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674596177; x=1677188178; bh=MaeulGlWcam/cauFGlIbI6QYkQXS6fmIFOQ
        vrLj/zE0=; b=fTeMqXQcxQcQK0CIxga3PorH3O7ZyjYWi/8Yfxhw7qngxvQlnBg
        J0CR8JEsMcV7DArmgahGzPa5aNcNBjk8IWVRjNP7lG60Wk1PmNkVA1sgw8Y4k+qa
        4JcHpKrt9I1yCblUZfFgShtOAeDfIaTQhrDfzQ4rP/GabBZmeDm6ZzDgf/j8iyRw
        tvX8vJ1h1Vtd+1/XyGsxD8scqvS1H6YEg08fA3GHxeLaRfr7ySCC55k5ZGkiXSMw
        RUHqHO2VOWF9DH8OoxQcvaYOQDVEH5TSIQ5OAYBC+pTnmdzsz8cyqj0wzUntgjJt
        w1a4XR9kYLJ7U7d+wTvnsBtEDtnzkW7qs8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2mcE0D63uTzO for <linux-ide@vger.kernel.org>;
        Tue, 24 Jan 2023 13:36:17 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1gJc1Rgvz1RvLy;
        Tue, 24 Jan 2023 13:36:15 -0800 (PST)
Message-ID: <b585cc43-8584-a980-6b52-224d8692b66a@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 06:36:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 02/18] block: introduce BLK_STS_DURATION_LIMIT
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-3-niklas.cassel@wdc.com>
 <517c119a-38cf-2600-0443-9bda93e03f32@acm.org>
 <Y9A4s5tlsdx0S8s4@kbusch-mbp.dhcp.thefacebook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y9A4s5tlsdx0S8s4@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/25/23 04:59, Keith Busch wrote:
> On Tue, Jan 24, 2023 at 11:29:10AM -0800, Bart Van Assche wrote:
>> On 1/24/23 11:02, Niklas Cassel wrote:
>>> Introduce the new block IO status BLK_STS_DURATION_LIMIT for LLDDs to
>>> report command that failed due to a command duration limit being
>>> exceeded. This new status is mapped to the ETIME error code to allow
>>> users to differentiate "soft" duration limit failures from other more
>>> serious hardware related errors.
>>
>> What makes exceeding the duration limit different from an I/O timeout
>> (BLK_STS_TIMEOUT)? Why is it important to tell the difference between an I/O
>> timeout and exceeding the command duration limit?
> 
> BLK_STS_TIMEOUT should be used if the target device doesn't provide any
> response to the command. The DURATION_LIMIT status is used when the device
> completes a command with that status.

Yes, exactly :)


-- 
Damien Le Moal
Western Digital Research

