Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DEC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Mar 2022 08:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiCLICK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 12 Mar 2022 03:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCLICI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 12 Mar 2022 03:02:08 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DED1C60DF
        for <linux-ide@vger.kernel.org>; Sat, 12 Mar 2022 00:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647072061; x=1678608061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uvjzLtZ0QuVOYXq3pO1ebVjYlGHyAzBNRpNQOKxDX9s=;
  b=oywzJjlmjxeVN10M9BU7qbvqWoNUuCwVsmZYoJcEy16IRDrOq7MbcEIi
   GxWxmbc7dbUM8XGrvQDcg65krSCWJlCKgGHCO1bjOcxW9sOtO4ss9borM
   7gor+3tvL7+J1p2TJozHEBgov57ksVUxMdIUI2L5JCj3mEzaNqA0BlgQM
   5kY1lPM2BBu/Ig1ZxL5n7UCmOwPQS1+6dDq70GbqYPNIVpzyPGPEUnx7p
   6zCRwlSxL76P/cyKiEa5G0tcvTp+Ce28WhtdmxK3Rm/2NJjO+n7pyGHeY
   u3aoni9w7jw7mfF0FuA0T4tax4TmB2FhThUHRiH0ogJD32Afd5aZuacjY
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="196114300"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:01:00 +0800
IronPort-SDR: tz0hcJvZamuKfMPMSel+Sxfxh3gJslW2XQveJYLR0jPk1JkzPTyryVS11+PpetQyVcxdUHiPa2
 ndmFAYtpPiYSEFbruEHsY9y2k+H2+M481yp8XzpsWZY5ctjKmo2GH8kp770Cjcy14gy7gqSGC8
 1CVMo4rJxJe9lA/TnK3sW5GxYg1qrYsdhfHhlpsD/jQxUD1IYmmcezMmpLyz2JrbnFaMkk+chD
 htsKVImX5brfTUPKHGrr3SJsebq3HlrgyEChOXY6WBz/76HmKKYZ9Pz0djEMQ/U9ZqMHQVmf5K
 iwHOXFJKVpoioVeZL7QdW1Jr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:32:10 -0800
IronPort-SDR: NVwHff78bHcNW+ElaMGPHFMFg+7kcIDhXmPf35LauH2jaulwcMFJnxkC6VPUJS+O5FcReW+zUF
 c2QYOde0oGok0E8GF029BHvnyuVbqshfB2QajWRPlsSSFcn2WnEHdd+6pFuzcg8wOJJH1QoXSs
 RrQbtsFV7dFz7GuKQ21COOq1nZEK2i1YII18M0swpaNTnHBgPsN01R1ndyfWFvMHhXpFY0Fghd
 RZhwAZ1buu76uMb5mBpBF8ybrM+n1b1WF0pwaPlb6oVWtrCLZ23MksTMjXL8JB7mJ5p/lD1fGk
 g6U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:01:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwGg1Btdz1SVp2
        for <linux-ide@vger.kernel.org>; Sat, 12 Mar 2022 00:00:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647072058; x=1649664059; bh=uvjzLtZ0QuVOYXq3pO1ebVjYlGHyAzBNRpN
        QOKxDX9s=; b=iexa23W1/b63APqV1nvtJ167i3NiHrMLOssPjIe61Q5MWZCyrZC
        T+x9sfu3duuK4dGzJ/3yFI4znEotyFG+2ctKGCKog6T3KNbxW/iWf11PVkr11nYy
        H3PHQP7E/lr73gpt9IVMqsHP2NYYlcShwK9KcovY3U4FjufSGAXJ/nRq9uMS+Sud
        R8XKypwhjWPNDMBt3AUJr44DaGNeVgPGd8OTXvwVMIo8L6qOtw5dTNYSDgAn8NZB
        AWdLiFRqz/jgad+8/u7f5c2DeYqNuUbRweaCobNWnp8a7Bb8roPTnMJfiOuRaDIS
        DbA1s65d0xHQgdeHrBWi3pCZ1N+aXwEurzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 01qQXVWYT9cn for <linux-ide@vger.kernel.org>;
        Sat, 12 Mar 2022 00:00:58 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwGb0tYyz1Rvlx;
        Sat, 12 Mar 2022 00:00:54 -0800 (PST)
Message-ID: <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 17:00:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 0/6] Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220311210357.222830-1-linux@fw-web.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311210357.222830-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/12/22 06:03, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This Series converts the binding for ahci-platform to yaml and adds
> sata nodes to rockchip rk356x device trees.

Rob,

I saw you took patches 1, 4 and 5. What about the others ? Are you
taking them or should I take them through the ATA tree ?


-- 
Damien Le Moal
Western Digital Research
