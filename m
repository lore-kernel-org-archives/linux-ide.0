Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BBC64EC4
	for <linux-ide@archiver.kernel.org>; Fri,  3 Mar 2023 09:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCCJs7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Mar 2023 04:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCCJs6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2023 04:48:58 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC31027F
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 01:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677836936; x=1709372936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uIoGKTM+botEjFPFMsCu6mxNY93QEUww5QbbHkHHhtI=;
  b=MazYiViT8D8e3mC4fyiSMt0asVUOeWvW59iHSSvzeM/g8l0ujD1KwENc
   ELLGngNrHUoPXhro4ZXc5XDSn0oRJYOnREpSLcGGEz+/luW6UCG+cUYLV
   +a4Ss/gRXjbimIbQEZvZcnitZszLn+tCLx2GR5uH3ZD88ZzzbgkWiXWkd
   9n+IkKkt7DfFumwXFPV7C/X+QzdwOuWKM021pbFuJMRRu6IoZW+LszYFz
   gzk3OxRFHKdHtSVRUmJzPZg/q3k+WrW7462icc/rchjM/sKIqAZFc45Mg
   g5hb2OUXDV+0F/IifcA8m7t7d4CvzeaestkZGjx1gsiXEcpQeRFcE/Kq2
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="329046052"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 17:48:56 +0800
IronPort-SDR: UhygS6Q7ZAYtQFhZXM1bACWaO8o0Dt/EG8EEZQuxxQZm8A0FtHYhRcS995kNSagiI3HkpJHWYh
 G0YAV1vf1MJIOTZ2baxx117rseTud35gAT7DqFTfX7u+tsWZA8pshtYgBX+qmxHgP3k/f+xR/R
 aPbddrkJk3iUenw724fmw/JK2Mn3sEoxv5mxm2/hLzR+LXncLWsTVtKJ2pcufKMdOw/ZCB/ytM
 J5/y9S6Y4kDdNtp5fBW+kkbm6GuRTqvx6Ttdpe9DqbeeDUeBqCuuZ2Tukr6XcIbRMM8ahBK2jU
 XPg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2023 00:59:59 -0800
IronPort-SDR: X2AJyAWi4NRBQTZcJyOG46ShetF6yS6tihirydfQEADh2T0C4WbYH1cbFFo6/YCgtbK3lFwuRZ
 XOj/USYrg7YfiCl4AzaKoSD41g+px52LTb2EjZmDKSvPKEwsBUCRjtohegaUP9cCFc4u6A90Ql
 aOje9wTGKHefVgW4vVnXYVcF+NRtP01pAVimyIeIWQWrNMQzefA0Ek99Of7fmnPIRi9B3wIf3i
 ndJVSbQkK9n4OSoEXDbIRJu52oMGxQJvIvZcs+5boVBSMxxTwb8rE8D3SySYhv5J6ROwbw/2+K
 zdQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2023 01:48:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PSjpv6Kzyz1RvTp
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 01:48:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677836935; x=1680428936; bh=uIoGKTM+botEjFPFMsCu6mxNY93QEUww5Qb
        bHkHHhtI=; b=qupa7oQRg9BOLX4qEG+sh+IsrkELz8Lg8XNpWttJmF+iGgYJbIz
        9ARw8CzOip9WdFO2Xx52cEIQBRUdXF39Om+RmOKO+az5wK0f+zmLKf9HK6Q+w4tG
        qu2aBAOwmVY/W4D3+qIAlzhN88z22PtfRsFdUTvvKX6KgXbfCn8WWUC6rlj+nA5R
        Dbi971vktYK6dO56VzfwcUKutLq2wgsYLRqTk8Je9BSzK98nkvlCcX/xMjC95Zit
        bVCzXVAmAwXlfRPDS8zabb4hwBJU51FpVAH7FsOb6wAV1/YWpbEJJYeyoMcZijem
        dN6TKgI2aGMJ0DaynHZzqgYLNIWKmIbZzHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y5GSMvFlBeVZ for <linux-ide@vger.kernel.org>;
        Fri,  3 Mar 2023 01:48:55 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PSjpt1k4Yz1RvLy;
        Fri,  3 Mar 2023 01:48:54 -0800 (PST)
Message-ID: <af6a355b-3ac2-a610-379a-167e87145368@opensource.wdc.com>
Date:   Fri, 3 Mar 2023 18:48:52 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ad02467d-d623-5933-67e0-09925c185568@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/23 16:10, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that apparently
> affects 6.2 and later as well as 6.1.13 and later, as it was already
> backported there.
> 
> As many (most?) kernel developer don't keep an eye on bugzilla, I
> decided to forward the report by mail. Quoting from
> https://bugzilla.kernel.org/show_bug.cgi?id=217114 :
> 
>>  emmi@emmixis.net 2023-03-02 11:25:00 UTC
>>
>> As per kernel problem found in https://bbs.archlinux.org/viewtopic.php?id=283906 ,
>>
>> Commit 104ff59af73aba524e57ae0fef70121643ff270e
> 
> [FWIW: That's "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller" from
> Simon Gaiser]

I sent a revert with cc: stable.

Simon,

Let's work on finding a better solution for enabling LPM for that adapter
without causing regressions. I will need your help for testing as I do not have
this hardware.

-- 
Damien Le Moal
Western Digital Research

