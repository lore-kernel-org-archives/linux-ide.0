Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC00C61DA4
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjA3XWJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjA3XWI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 18:22:08 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FEF2A160
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675120926; x=1706656926;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=W+VBRZg/vKdC+trIRTk1i9ClPSYg/J1+3ss2KiZJzrU=;
  b=gHPdsdMzAuYEBBH64Wx+z/03xesYc9eQPftniW3Fnf+8+1K7bjk6bnx+
   RcMZ+IjEPk0EvZ4s/ytPCVcDRda2TVK36MUjLPEbDLpMNTtnbnAFRRJdY
   a1SUr5cA97z+S/CyZPZ7Uf3Btzmxs7RJ2ZDpHlx6qzSY7rQdPvyJWNT/G
   RvyDVabRuK5CZLa+BKuNh6wjMrkQMwHxwdRwUBP7JZznxvH+O9tcyeHIE
   7hVocbNZVxA6kddH8VEGiaRPYq1z6BN7PbM+QmNwIwXcy6kKdQ0hBZ/8L
   RalRAHZh4+1OcySBxQ7AUy6cMwzNxWYGMNJVnTs4Z/QRcueEv6BmJgL+6
   A==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="222174017"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 07:22:03 +0800
IronPort-SDR: l7QQV2lIg3LjFYDloOxhWJg162VfFauk2PcTFMDOBVEBwpJGlHTNwzPHLYv+R6uuSipHxwV081
 yO8oU6WCXVWLPzEpuCygkFH/2ikemMtHtGV8APE9ncnos0U7iUbqezjA66rYHUZnDea57dIcb4
 nj8zzm9PmJbdu0rM40THiQJi7HPLAohF1IlddQ9fGH8v2tETG4hg5ORlfZNeQJegy8/mWL51BN
 hHdSJm4xAoccK5ZUYt4lXlsDEVsmn21+0VO6bYHXDRaKVVlnYRAL79sU77uNU1jI6vIA042gkZ
 19s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 14:39:28 -0800
IronPort-SDR: v3T2jVUFonv9g3lEoxreJHlQBw0LbQrDBPA7mI+WZMhJ90ehASWycL4n2D+3fGtHC3Fdq2xsEC
 4yaxUsUTyCisS82QjeMRK+fCud5Zi/IYiNKqJz/fDzc3Mb/Fh9V7Gd4S+ADjUnZRSMDbyBfVhi
 wPmpi3QG3ppaD3m/t+2ccbpPDMUpUGnesSKify37I2SgBiUN3jVEIrbpWu0sE78DHkFepGqbHI
 MtTVR7N2muGyxTOPs9TxAzABwHyGR9CZrrL7Bj+xfhpouJNlZXpISpNwP9Wid956R8yi1zAzpi
 O4Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 15:22:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5PMv4f2bz1RvTp
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 15:22:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675120923; x=1677712924; bh=W+VBRZg/vKdC+trIRTk1i9ClPSYg/J1+3ss
        2KiZJzrU=; b=lJG2yiMgFk6FEF4flGx3ph1Img7miC2zpd9chf72JnggO2tKl9h
        KruncfiV0Dsz5S+6FHAzw5ZnpQOPmsZ3eXU6d6h4zLzqfxiOWc3O0PZXCNanNR1f
        1/kDxCjXieZZqf0049lju7zahlGhlGzf3+48SqF7X3UhjktDb9bCdCfuECZ5KL/N
        8SraoIkAixZNz4Hc5cLgQUYM6uICnqWBUH6WV3th9zawmQlBjGzm63UG6op+2oQ7
        O7eOEUv8iuQtUpU2ku8inM5qnlXX0A6S2iylZ1tUNQDQPTCLjJ+eQJ/ZrGrf0fYp
        gBk7ODPArqMALsTU5k1Z+b4P1e7bgmEGmVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dJEvpE79gSxE for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 15:22:03 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5PMt6bypz1RvLy;
        Mon, 30 Jan 2023 15:22:02 -0800 (PST)
Message-ID: <1831eb01-5c84-54f1-7950-9b8e9bf0a046@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 08:22:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <3c508c6e-5377-bb2d-64df-407f73a8170a@opensource.wdc.com>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/30/23 16:37, Damien Le Moal wrote:
> On 1/30/23 16:23, marius@psihoexpert.ro wrote:
>> January 30, 2023 4:39 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
>>>
>>> Apologies for asking you to test again, but could you try this simpler
>>> version of the initial tweak:
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 884ae73b11ea..2ea572628b1c 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32
>>> spd_limit)
>>> */
>>> if (spd > 1)
>>> mask &= (1 << (spd - 1)) - 1;
>>> - else
>>> + else if (link->sata_spd)
>>> return -EINVAL;
>>>
>>> /* were we already at the bottom? */
>>>
>>> This is a partial revert of the commit that created the issue in the
>>> first place. But better check this is OK.
>>>
>>> --
>>> Damien Le Moal
>>> Western Digital Research
>>
>> No problem. I'll test everything until you find the best possible fix for the kernel.
>>
>> It works:
> 
> Perfect. I prefer this version of the fix as it actually does *exactly* what the
> comment above the if/else hunk says, that is not force 1.5gbps speed if we
> already have a recorded speed. But in your case, we do not have a recorded speed
> (link->sata_spd == 0), so retrying with 1.5gbps is the right thing to do.
> 
> I will write a nice commit message and post.

I sent the official patch and CC-ed you. Can I add your
"Tested-by: Marius Dinu <marius@psihoexpert.ro>" tag to the patch and queue it ?



-- 
Damien Le Moal
Western Digital Research

