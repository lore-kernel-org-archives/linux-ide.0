Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F2C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD361B2B
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKOJVh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:21:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10307 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhKOJVU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 04:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636967906; x=1668503906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tdJIZez96uAYSrf9+CutoTspckmKf1T/muIr048hnOA=;
  b=h07LKbxAX0tfivVkbUqUwPDyjYoztq/ZDOqJJkA5gBBahyIzrhr4X1sb
   UyCGWV0YRz75BH/t1Ir1BoYrKNNXBz4VEH359c52gD9+XqwsfMMleI02S
   TSlzhYweznhCldqEzm7oVKp0yxiNIhEsS5N/ACkXgKwdHgx0j1b1MY+w6
   e7szR9mRcOAhEBlvQnSY93McZYdWJhZoALaWgX8vzojfeX0HpXRq/X30R
   m3LMJqYWr1yq//2WpXrmxEO9bqq5gQuZwQExum/f7Oa4W8c147hxGAGkG
   FoeJ74Skef1FdUNNvaTF6iK456rq2tzP/7OAbcZBHbI08ID915svYnfDF
   g==;
X-IronPort-AV: E=Sophos;i="5.87,236,1631548800"; 
   d="scan'208";a="186615401"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 17:18:26 +0800
IronPort-SDR: xK/TjM0qt2ghqAIJSaygWIN5Chm9MGWV/3jOgUSuJyXmFEgPYBqiTMyrVqqNgyW9IEJqBfuMCq
 d8Iok29nX9EqD1dGSfA/oweLJEu/CzOkviDh59BcxroG/FaP1hsBhx7dojypaSoudm/ZMCN0Ar
 +YDsScg1i/fw4l1Gmhsyd0tA6g8N5pXJjZRHmkG28aDWWQhQ8oXVJILQkta9QPo00OI022SRYd
 bSaweTIaQEQ2uoaXNfHYjy3YR/BgadV47Mn+JT6w/sPMohGY3d03HqbVdk8CV7o8OSSbUjZCqn
 IXq7j4T9MUUPrExXDx+88XDN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 00:53:30 -0800
IronPort-SDR: 00+3H9CGEQ4MkILXRe3IZtXXt9HoVzbl+5nNky/kwDucwLa0TYJDUclCEK5N/AEbwLBVcJ7/GF
 tdHJY/wmKDJrRq6ZfaJBIAtQ1YDUbcZQCFO3ZgQwnxbXCx7K+8vV1ydXS5eagdHvAui8ajwTsf
 viRp3GfSsS9lqzkXEyPSMxR6Xum2pdf+pQfG8nhwMYhWby7mUtPlDKU0Lo/ik3xBj86+qJnTRY
 9O3bvrzM8+y41cOcs4TZukTSFJliFfMpKE8xEmdaGwEDmTISpXCGfSgdliDwAkKgcxYS2OlOlm
 iSQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:18:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ht3X148f3z1RtVn
        for <linux-ide@vger.kernel.org>; Mon, 15 Nov 2021 01:18:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636967904; x=1639559905; bh=tdJIZez96uAYSrf9+CutoTspckmKf1T/muI
        r048hnOA=; b=fmJXsnbRskqadozXiIyT9Ley1xkguQc9gGC3/13Gtr5kIGDtumx
        lAKOG8W2yb8gKi2h9/gCLwl61kihQIy+UBBici9A4PKKVK1p5yz3p9I7i/+G4ISX
        uSfQGzgaBILdNX7wsA38aFszkahdnCe82gDHeN5xwB8mSxNEeNc0aXBUZZEb/Z0t
        ejJsAWCKjsDPHLvoapgdbgdE8cTqzWm+30ZIpQYbi66jaMRbsN3Pcr8YFp12D9f6
        Fh+awUMvxeI7huXPwYxvI1JFWEbRyc4Gj+0qF85+pJ4vIkbMWS2q04hzqXytAC6X
        E2W2vqu6Q393RcNau82HZ+qLuhlR9fNv97A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xtueo_h5lR5C for <linux-ide@vger.kernel.org>;
        Mon, 15 Nov 2021 01:18:24 -0800 (PST)
Received: from [10.89.84.145] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.145])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ht3X02qdqz1RtVl;
        Mon, 15 Nov 2021 01:18:24 -0800 (PST)
Message-ID: <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
Date:   Mon, 15 Nov 2021 18:18:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
Content-Language: en-US
To:     "Nikolas L." <knv418@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YZABtvQab/M2CCQd@msi.localdomain>
 <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/15 17:14, Nikolas L. wrote:
>> This error is not fatal. It simply means that the drive does not support the
>> INDENTIFY DEVICE log page. Nothing to worry about.
> I suppose it's not the reason to log error, maybe warn or notice.
>> Attempting to read this log should be avoided in this case though. I will send a
>> patch to fix that.
> Thank you! Got it.
>> However, the files you attached show that you are using
>> kernel 5.12
> According to almost any file in attachment, I'm using 5.15.2.
> Error happens only since 5.15, tested on 5.14.16.

I posted a patch:

https://lore.kernel.org/linux-ide/20211115060559.232835-3-damien.lemoal@opensource.wdc.com/

Can you try it please ?

>> You can ignore the read log error, unless your drive is not functional ?
> Yes I can and I will. Entire problem is just about redundant noise
> with error level in kernel log.
> 


-- 
Damien Le Moal
Western Digital Research
