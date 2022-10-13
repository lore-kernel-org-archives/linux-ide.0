Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8588C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 13 Oct 2022 05:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMF4f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMF4e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2022 01:56:34 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52821285C2
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 22:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665640593; x=1697176593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QJzUPWjBRzDrZnxgC//C5t7Ufi9qlwbyFKrKzT02xgs=;
  b=khb45nSc7lfQiWtVKCAjnwNX0lTDNUH9noVm1x0dxCQKu1rtqVmnLR68
   HJmeGl8zQbk5GqBqbEZ7QSbQGmdhE0RruwdHJW+bbqCtnTrfVwXIwi5Jz
   nrsda1rwPYN5U98060Eys4BHyFI4HKtEBMjxSxiLq2dcODPdSd8VRF82J
   ScJE5UTGRVnJs5gN+yCjL2LI6gwi2lHUqV8WMlJb9rnnlLoNcRz4UMnFN
   xverYo+KaQ6bv+G837L2elsju3SYMhZkDmhgDiQYP647uuVwUzf+IwQhN
   OjGjr7vvpxepHUpl12Uy4M+zF6MG2fDoeoXjWCnHy4Hlczo02tIySL3mw
   g==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="325772451"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 13:56:32 +0800
IronPort-SDR: MTwlgIA6HdXv+GOSWweTE+G8/yquczacb6IoV19NjOHo6BibjY/w2IlwixGRFigbMIcLaYxUhg
 ZMwn213O1QrJNObW3nD9IJr2CwURc57EZe9X2uCUArg7ek6ALvpEhHn3Bjj/RVsqhUvUw6ky6s
 w85b+WHzpEVgowXnQcpzphQ54SEVDS/UH1XF/ie8ChWZrOprd5+5DJvyF884O1bISrYIIAM9tr
 q9w/A9aSodS1XfQq+wk6ELcq/DhwbSCBbgG8S1ksfi2Gs0mR9QnT7yflJ6eQoPSHSIC6drFMpF
 MxD/46SbgbNGcuvpWznqxYkd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 22:10:33 -0700
IronPort-SDR: VphdnGSdRS86AnBbtcfa0tbs+S+SlQTPgR/7V/a8B+s8Cu0i3NEc3Z+epEh4kvuh3k0yshh2Xp
 04Voh7sm3TQIAD7R4cWxUrqaE/Dtmvw2fk4w5nFVNATqMyxtD1I5DBz2xUgMVdlXIjD8SuT3p2
 JfS4pT8Bt7FmEbrpjSLJFkDmclgzeb7RKJ4gL9/BP3TQl4IFhSM0XDC9sTa31t4V5pPPCmmwIF
 eVOCyYaHpL9EEc5UssH66EYu1g0NEnzL97rny2SqptuVFNFTF8o62lQ9us0vU+rj0+/HbpooKp
 X5c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 22:56:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MnzKr4dc8z1Rwrq
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 22:56:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665640592; x=1668232593; bh=QJzUPWjBRzDrZnxgC//C5t7Ufi9qlwbyFKr
        KzT02xgs=; b=nhipVFkfPgzH/NeGynZpIdAW28UhEpidS2eKz0NaYyfz8fHfBEI
        IsGHZwR0WVN8QFked2Ju7tVMdgC2RJ+OUXK65XJTVO4ZVPmmHDSpTA73HYarHz+H
        s8+FXU2aTGP44a574Fuddg4QAoHVccj2NxmCatWkvTANgXPwnoDCbSGJIZtKKQDf
        dm95/xC+5fisdN6l7H5NL75gp1ZRUe4EjoMXEx+cNlboPkmapV09ygeAilQzGLo4
        gj7KwpUNotZkS4Bf9C3MIG3CdiTyOSsYkbHZCeQoUe1xrKoNuccnKBSZTzwUJfli
        FM0Vd2CZf8MplX9OOrTX9RtCeLOLjRf8qqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ByVnR3I8KW5G for <linux-ide@vger.kernel.org>;
        Wed, 12 Oct 2022 22:56:32 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MnzKp6Jslz1RvLy;
        Wed, 12 Oct 2022 22:56:30 -0700 (PDT)
Message-ID: <68788b58-1e5f-c629-e9cd-f198b50e6019@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 14:56:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
 <5877338.lOV4Wx5bFT@steina-w>
 <fe62c669-01e0-52bd-fae2-69fcbc375c23@opensource.wdc.com>
 <4442509.LvFx2qVVIh@steina-w>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4442509.LvFx2qVVIh@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/13/22 14:55, Alexander Stein wrote:
> Hello Damien,
> 
> Am Donnerstag, 13. Oktober 2022, 06:20:16 CEST schrieb Damien Le Moal:
>> On 10/12/22 22:30, Alexander Stein wrote:
>>> Hello Fabio,
>>>
>>> Am Mittwoch, 12. Oktober 2022, 15:23:04 CEST schrieb Fabio Estevam:
>>>> Hi Alexander,
>>>>
>>>> On Wed, Oct 12, 2022 at 10:11 AM Alexander Stein
>>>>
>>>> <alexander.stein@ew.tq-group.com> wrote:
>>>>> 'ahci:' is an invalid prefix, preventing the module from autoloading.
>>>>> Fix this by using the 'platform:' prefix and DRV_NAME.
>>>>
>>>> What about adding a Fixes tag?
>>>>
>>>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>>>
>>> Thanks. A Fixes tag seems reasonable, but I have to admit I don't know at
>>> which point auto loading stopped working (if it did at all).
>>
>> Given that the alias was wrong in the first place when added for a
>> platform driver, this I think should be a fix for:
>>
>> 9e54eae23bc9 ("ahci_imx: add ahci sata support on imx platforms")
> 
> I was hesitating tagging the very first commit, not knowing if it did work at 
> that time. But it seems reasonable.

Yep, I do not think this will hurt...
If someone think I am wrong, please scream !

> 
>> I can add the Fixes tag when applying.
> 
> Thanks!
> 
> Best regards,
> Alexander
> 
> 

-- 
Damien Le Moal
Western Digital Research

