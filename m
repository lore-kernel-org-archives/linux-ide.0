Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B48C6FD1F
	for <linux-ide@archiver.kernel.org>; Wed, 15 Mar 2023 01:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCOB1l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCOB1k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2023 21:27:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95462C64E
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843659; x=1710379659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qwAtZoP7xvSgcHN363+jUE5cgyYDhp6d/HHlumIaPx4=;
  b=i39RPoke4ZGsjuGkrP6XIOjvNVVZ8vPksDDhL7mn4cmutxutJPoBeuge
   /VWvT5To70kHIj2FpGPMD6EgMTznviGblREtYGVPMXp1kYXVh3V6CGirk
   3n//3qkSwFq5KEvIIl5sjENXLFjFmToYltT6Krd8ptNNvZrowdazoT+Nn
   FYMAxMUc3vDVDS5YGEX5ZJq2xtT4LeRPdcUn9KEi+8Zlqre+RJnKc+Be2
   UNUSqftVGDxNtxUy/fTYBGAd6yoJ93irIWQW+7PJs/4THnoy4v4qzB+Kk
   yJn7nzIxoqxyaKZ4ZldUhcFeeIkoQcE0E2/8R8yxtxracYa0vMpPXSjBs
   w==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="337671861"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:27:38 +0800
IronPort-SDR: j0gdKxU3RQFV7LnqgqAnzyCiL24l/NrsYdOH8KD41Q29grNpxaqPc4pZ88fL3I0/pmvrsJtldd
 FjscMQhMAMaq+dYxx/CdHDwgbKqBeJBABvmxrQ32PUd9LwTo5EM3pvYzHiFxZGyOL/lxRL0MHj
 sW2qS9ZlwrugNPs/boow5l28oBz2L8dLkASDCOJlD3WwBTl/nBVF7y2GSaJDsuaxGqFhFJqjft
 GLttqkY3h+9MKGjWNvp1KrPlWxZh48av4MlS2Oppj3LM6s70vH2zfq6QQd7xNShX/mQ9nYMWfA
 B28=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:38:25 -0700
IronPort-SDR: y2J1zemVXDU+Ms4tv93mJdcQWW02hU23mMyDqb5Wc9TQEERbai5uCSJ60eB6uloFMmYvguTGif
 dI+IVFHW2aRgo/xdQ006akBIN17zt60X7ZQK+yrDUzm8mmQIyl01VDXbcqH1ZMJXuImiia7Vhl
 yGQMxy7qsp8uYoUO6Wc6CohXesakAtiHqPkD2BIjYwRjQCraks553vONIE5dvd9kO4LPiwzpt4
 aeyNqZVbIsYVb5kD2jv7q7DIQM2UdC0MSLRQiS4XtQxOv9uXXGIphWcfwGu+M/SvAioyJO4Puq
 2O8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:27:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt6y3948z1RtVw
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:27:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843657; x=1681435658; bh=qwAtZoP7xvSgcHN363+jUE5cgyYDhp6d/HH
        lumIaPx4=; b=hww0MhteHuQE2OdTQgZ104gsvu1dm95/Sgs5XP1tYfw8W4Wyo/p
        pnI2T1XnQlx2yQE5HBC0pwdUPgvGPAzJGV/+4hcLnLrc7xLjZL8YFOFuVdVGXlQb
        AWrA6gMkBEaPLnOB4Wfv3lrZMgSUlXCVtcaq+f7TpUI3OIf4vHBedoFyCA8hrC1u
        o7ftGMYVJ+5uzMr8nUFTSO/ttvsCrMQtQxmEH2f5Ju6LwZiYxz5wiX42ozrMD4Fh
        sTYoxzlUZ0bhHKjLQBx0e4aKELYcO2PYXdWcHkxQwk9QTLiKl38B1SvjkL/3bBNG
        I0W4YW6JeQEdAc3xYJVjhsBVin6k++zOHKw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vkJqV3fN9yYn for <linux-ide@vger.kernel.org>;
        Tue, 14 Mar 2023 18:27:37 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt6x0Kkyz1RtVm;
        Tue, 14 Mar 2023 18:27:36 -0700 (PDT)
Message-ID: <80210bb6-edc3-450e-4816-9fe0c4b8b07b@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:27:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>
References: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/8/23 21:49, Geert Uytterhoeven wrote:
> The Freescale QorIQ AHCI SATA controller is only present on Freescale
> Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without Layerscape support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied to for-6.4. Thanks !

-- 
Damien Le Moal
Western Digital Research

