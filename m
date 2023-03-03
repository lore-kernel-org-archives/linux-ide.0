Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FACC678D4
	for <linux-ide@archiver.kernel.org>; Fri,  3 Mar 2023 08:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCCIMX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCCIMW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2023 03:12:22 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E11B2E0
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677831138; x=1709367138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4WOsAfpITDveUkLlKm0C8SxMPp9Wv2/hWv9cOYmED8c=;
  b=aoZJc9Byxl+LEn6F4POXV54uakR9oZ7MoYZi12xzL9Rnlo8y7BiwHDpF
   rHTSwM8rh9/hvkWvMuOJ5LhbRyFgETtxOc/OaIxhGI1Cph/eRjs8dm1jk
   6IMthSV06+nBV+D/w8ld5i1QwTzgjnOMc9spb1O3ur1TdyjyzccjqUokQ
   1sYE22k8TBF/nJR0OvgiCNliFV9/UunwEkeyvLJWZTjlS8EXD34mHqeGm
   xNK4Fwv0bE5TTS0Z1EnUe+FKX1BIZMd4UNL8GGbuQY50lFfUftinU8JiR
   lIR757YCyDAawthWt5flsZ2P0CDERkZdhWOYX+xM3y7XdplHFM2dPI40X
   w==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="224494463"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 16:12:12 +0800
IronPort-SDR: SH4nphYuU9xbmx8L4SiMUjKc5+Kz8GlRvHQxgyI9LJFmGr6CK1SiLqUOjqyqzJfZA64AUMaiGn
 GMlbQdceXwIWvyjiSM8f8DtbwE/Z6NUW0ANlrF+qDWaW/dn/NC3ojec2DH5zL6uIbE1A8FdAyh
 qi+tgxxLcKvrpSfHOuZ1P/pX668GHB1LlU0hf0QdED9VwiqrJBlL7Vx39aL1Aaze8xqnfotI0c
 iK7KPjGYDpuDcrLqO/tGUByic5Vqo1HUbhrQkRguJ8tq+e5CZtQECsM90tqC5vpk76YAEbd++o
 B88=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 23:23:16 -0800
IronPort-SDR: po3uDLjo3KsDiRzZwRsPPuKL0PjfUddP3EwUyHNF3lId9BcdePkzXYnrlzsT7dzaGUbgtLtUvK
 HbceIvh2bsLoW9ahMWnMXcBZm94h69T8oltLtIs0EPhmh0pHa5XUmR0jRbRlo2pXk+kNmaCkao
 T3aFlDhBatsb3p8R0Zu7t42oqVU+4cQ8HjlYXRbK1DFNVUEwp4EDYmfCx0MQCSPxrIzyX3Uqs2
 lCiraKa4wTmhB0urv4NiNf5xGReAtLyqlgkXpuTr8qvDO5aby4MpuiA0knjh5OkyDVo/HnfayZ
 /Ro=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2023 00:12:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PSggJ5gQ6z1Rwrq
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 00:12:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677831131; x=1680423132; bh=4WOsAfpITDveUkLlKm0C8SxMPp9Wv2/hWv9
        cOYmED8c=; b=rKSoaoekCp7gDKYIuDHi1E5WDIjLw9z72q8c/HZhDXZibORf9pF
        YtCA+3zWjDk7K32qUuqLSVaqJpNFkEy1zv5JrrLGkjyKDB+CXUK9Ae844chPXM5m
        S4zcpQaj6wrIv+f2AjshPE1fJzDkmtuShV2q1RjFFXsjL9y01Ls0UVnz15aSKwUw
        Vkt3NLfKbExN4Sfm+4iwuNffr/HoccJFJVJIak7w3yKCFBd+r1TYb1yI8er3DgLi
        g/g3LUWPGZVEe+zMzw2pcgmKoy/PokQKjhenbNherhliXzhrCPBA/MduxeMjVWNO
        4BF36ogH7ROC2QTsJGdY0EgYZkx+sOb5RlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id od_kiJc7KEaa for <linux-ide@vger.kernel.org>;
        Fri,  3 Mar 2023 00:12:11 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PSggG591kz1RvLy;
        Fri,  3 Mar 2023 00:12:10 -0800 (PST)
Message-ID: <414d105f-4197-9bef-18cf-f44d422ffd62@opensource.wdc.com>
Date:   Fri, 3 Mar 2023 17:12:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 217114 - Tiger Lake SATA Controller not
 operating correctly [bisected]
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Simon Gaiser <simon@invisiblethingslab.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        emmi@emmixis.net, schwagsucks@gmail.com,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <ad02467d-d623-5933-67e0-09925c185568@leemhuis.info>
 <fa07d882-499a-4d49-8ab2-679298f16c54@leemhuis.info>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fa07d882-499a-4d49-8ab2-679298f16c54@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/23 16:30, Thorsten Leemhuis wrote:
> On 03.03.23 08:10, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi, this is your Linux kernel regression tracker.
>>
>> I noticed a regression report in bugzilla.kernel.org that apparently
>> affects 6.2 and later as well as 6.1.13 and later, as it was already
>> backported there.
>>
>> As many (most?) kernel developer don't keep an eye on bugzilla, I
>> decided to forward the report by mail. Quoting from
>> https://bugzilla.kernel.org/show_bug.cgi?id=217114 :
>>
>>>  emmi@emmixis.net 2023-03-02 11:25:00 UTC
>>>
>>> As per kernel problem found in https://bbs.archlinux.org/viewtopic.php?id=283906 ,
>>>
>>> Commit 104ff59af73aba524e57ae0fef70121643ff270e
>>
>> [FWIW: That's "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller" from
>> Simon Gaiser]
> 
> BTW, there is one thing I wondered after sending above mail: was it
> really wise to merge this to mainline two days before 6.2 was released?
> Yes, the change subject's makes it sounds like this is a hardware
> enablement, but the `Mark the Tiger Lake UP{3,4} AHCI controller as
> "low_power"` at the beginning of the change description shines a
> different light on it.

Yes, I made the decision to send this patch as a "fix" rather than a change, and
that was rc8. In retrospect, maybe not the best decision. But the patch was
fixing issues for Simon, so...

Anyway, will follow this. I requested more information on Bugzilla. The issue
here is that it may be due to the device having a bad LPM support (there are
many) rather than the controller itself. Need to sort this out.



-- 
Damien Le Moal
Western Digital Research

