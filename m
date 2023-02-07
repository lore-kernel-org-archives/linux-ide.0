Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32038C636D3
	for <linux-ide@archiver.kernel.org>; Tue,  7 Feb 2023 00:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBGACh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGACg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Feb 2023 19:02:36 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE517142
        for <linux-ide@vger.kernel.org>; Mon,  6 Feb 2023 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675728155; x=1707264155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HEmolE1Uuc=;
  b=F5jMKMHEjf+qaMogdcblg/6XoEr7nmaT6MG91CP7Jfds8QjYkYkT8mwG
   z4asF/n0J/0QnguQmEOZhAVQo4BSO/cUyz4Qdfwxh5fJwwLJYOqAseIHp
   CeUzxRWcL8y+XBP38fP8UDRboOgXhb5WItpnjXMe8yw8P5m80faUpZtOT
   kECTSWRULW5aSGqHeSLOiqFGuFno1ZPpinBGeaflX50Lwz7TJqwSW+d6I
   igL6a9kIAerhi1Tdxsh/27ZnoxPD3m6PArhmSJa6ZMdHj+7P1AjsDQfIh
   qRLNHyefS/DkMky49mu3LIjcCW3cAJKpHlv9uAMPNE3nVo+wMuqJuJ9mJ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="220974928"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2023 08:02:34 +0800
IronPort-SDR: ychR06RbAlQ+E/uAuCmEeczQFWur7EQHvLJ9xz8wOuxqh520oBgAb83H61zlkJigCBLsRScSQv
 UcIdXa7+m1+IduYL2L6yjFyVmPnB+OKpBCiy+IdnbJj+n4XTCQp21DMqROoillehLOaFW2SZTb
 4+iTZN3fBMzwTxiZ5eyNk/mXETpsukFwO0qMRfu2kxUiDLOKFz2GMKDfYfmxSJ/rptV9nrv+v7
 xoNVr5W5L6LqUAdGUPsPruMXNPjePidAFZzqolUfgvKDunrrJ9Ka1ctDKF801O2gQnmym63gLu
 N64=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 15:19:51 -0800
IronPort-SDR: yVkx5m4z8jn3yEivDJgrgF7rKnbOlEBS5R64Wn2Ik7uiKwdCh+kCQZ6hFMD49M7AaLdnXJ8yBQ
 gd6Se137xRpQsbR2ljRXQkJiVPOeAHxqOIPStN2Y4D7hkuIHtDKB1zt2JRzzysCfLHBpF15hdX
 yjKwniHs5y1VZ9dvjw0f85mv8Y1BRbpRcRkmLqtFE0n70jCnO8FJkbsGwwlAC9yzkUV6teqKVt
 0hL/q7SYuIOqvZ2TdCYkyzHDFUT0U0r+43Hm6reGx7w0ka74uwgsVqbzGfNBurIfvWNpdtLJTy
 3M0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 16:02:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P9jxP6X8fz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675728153; x=1678320154; bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HE
        molE1Uuc=; b=HqIYs8r/GoSN6NzdbYUtYnRT7iAsoYp1CdgEooJ9d2YCrVFLfzb
        rjEttICX1G/oxDPb6AwDU7V2TQJB+HfJaf1M88xEH1vsUFzhMYbRnHaptWM7l3y+
        0N/93UZf3/zIpKVs1GgeYskEr8olM7rJ3MTh1mJzLj57GqlNjpfQF0p5wYlWq0S2
        Na4PZ8u2htHUX8QXv1HmrZ8E3zqd2Gmq/NnVSby3EuLZr2E6J1MHcfVAe7i4gJW1
        70gb/GfBIdcQvJCl82dQ2P89ZcTAUaYyEBY7mSFZSS0GMZKDQADgu59DkEkmqfXS
        7WQ6T4EXJatWSwa5lc9VZYa5cr6xtn4mFmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zoKTFVJhUQKU for <linux-ide@vger.kernel.org>;
        Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P9jxM5t2Mz1RvLy;
        Mon,  6 Feb 2023 16:02:31 -0800 (PST)
Message-ID: <605df8c8-ee93-9411-f90b-5b80102b8f79@opensource.wdc.com>
Date:   Tue, 7 Feb 2023 09:02:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] pata_parport: Fix ida_alloc return value error check
To:     Ondrej Zary <linux@zary.sk>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9uwqRothHhaOeDO@kili> <20230204205527.16716-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230204205527.16716-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/5/23 05:55, Ondrej Zary wrote:
> pi->dev.id is unsigned so error checking of ida_alloc return value does
> not work. Fix it.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied. Thanks !

-- 
Damien Le Moal
Western Digital Research

