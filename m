Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A7CC433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 23:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJGX4V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGX4U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 19:56:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242E23163
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665186979; x=1696722979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jEpPGQkiS8zXB7IjqSSfj5PH+spWk9puVSvKEqbixDw=;
  b=DkkXvnJwmTJaVoiHSvHr8uoOnLeJOF1QlxEXUyPy2dXyinTh10o72mKz
   UqJePTZpKpjvMpRxE8zgpY4YW+azySLPubPJN0zUAiy8K7lGnwhHri8tm
   boMCt8+gXPKFyDgKKQz0mEaYQDiHKWG/0xUjfiLGwAG454WbaWyGGfQAt
   XfGXWHg/UrZuJFctijDR3+2sD+QlDNrfZLXnIHZVUrE0Eq4IFEHcZxENr
   WZWFsNfhdxKUO7Az/qgatbiHPz24lyyRzfLaoRjKGj69QmdeScPhoyevI
   9wIAVVWclc1ms8004/gKyiASqi1cDFNGBJdczzghgTKrgItAS8Jt1s3qM
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="218452766"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 07:56:19 +0800
IronPort-SDR: I543T+X5DYA01iTj57qeFb7MPAk+rGm/rVcZl+YbXHlHa/nKRSBm6UsTVy8OetEshR1ypvhAq3
 n1apIjgyy4OdGlxGyPFIwHwbw5pID8Uu6YTnCEvRgpKj66UKgqOw/lw6A8e/GXpROx3rageR4n
 kTaU+AQO47XRH7Nx/mbu+kCivE3OGmS7P11ws+1F1ubXl3535VRlWIHuO+fDYC9Ev8pqQH+2Vw
 1yl7XChLVEKYt7RFggQEQGXoHLFdWalqAJ2A5nYWJLYgFvSwtWvqFzU01UZ0mUGEfXOaXlcogS
 /DteVAYNw/z6H+sJlTp+H6KY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 16:16:03 -0700
IronPort-SDR: Iy9EdXO1tHgh9UJNvRhV78KGzgSbJ16g0zh+so+u8jfVOMsTJKQchELNfqb1gq6UD5qZvIPwtQ
 zai/Qi67mLfQaW+DcR+o5Y3qXRRCQsNVZsP3hOpxkj/3m4TCAqYzRUit8HxFLfBRLNEXqmEMLi
 0bUxdfNZ0a+Ou3vn/4qkBxP5yaCdAW9jysSvSDgUPiCvErNH9g9k2Y0Y3cYDYffG7IqmmQlY0h
 obw6JFFC0ITjC6qErAvu1q14KM0+Jqu3c0rcJr7UquDQEoZ7WmpKxVisfpIqLokicw+n7ulHAQ
 pI0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 16:56:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MklZV5zhnz1RvTr
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:56:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665186978; x=1667778979; bh=jEpPGQkiS8zXB7IjqSSfj5PH+spWk9puVSv
        KEqbixDw=; b=ZBGsqtkXbn0Qn7KMOBQviywfT0ZZ6ZCbBf764GqtsgbBqjWXKCr
        kFvnM+LBlGuvVWFU3c8i3DI3unXc7p1gSC5Q6u86PRxKqilcbxRFMaMSFFr905lo
        hfbauHCbkwpr+pTo7iWAnNfYrCPiHv7+1j2yD40gBjmVU8wmxYe6BcA3z3TpkE9g
        k92udYxQsaGw+QrdzER5gCZhF8ghHR5YN0G10XX5Lv3fl1PC4iE1PY5/aTnCYRqZ
        RrDEumgFZSL2tDTCMK+qCSsoMKxPsyYWwHdCtb+xONTGLJibWHH63VdnzZEORkr3
        NsmVMedu89MgTNau6eg9LmtHbfUmqZGYcFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0R_mrmFM3adX for <linux-ide@vger.kernel.org>;
        Fri,  7 Oct 2022 16:56:18 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MklZT5dZqz1RvLy;
        Fri,  7 Oct 2022 16:56:17 -0700 (PDT)
Message-ID: <850610de-423f-1ff3-077a-2243cd012005@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 08:56:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Mikael Pettersson <mikpelinux@gmail.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-3-niklas.cassel@wdc.com>
 <dac5c025-1f77-9972-977d-cb3d22023db4@opensource.wdc.com>
 <Y0C7TcSfZezZxMcX@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y0C7TcSfZezZxMcX@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/8/22 08:50, Niklas Cassel wrote:
> On Sat, Oct 08, 2022 at 07:31:00AM +0900, Damien Le Moal wrote:
>> On 10/7/22 22:23, Niklas Cassel wrote:
>>> Clean up the code by making use of the newly introduced
>>> ata_port_is_frozen() helper function.
>>
>> Looks good, but I think this should be squashed with patch 1.
> 
> I could, but by that same logic, shouldn't patch 3/4 also be squashed into
> patch 1?

Well, I didn't get patch 3 :)

Looking at it now, since patch 3 are changes for libsas, better keep it a
separate patch, and we can see with Martin which tree to use to queue it
(it probably should go through the ata tree).

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

