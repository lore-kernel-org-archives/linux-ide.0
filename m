Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CDC6FD1F
	for <linux-ide@archiver.kernel.org>; Wed, 15 Mar 2023 01:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCOB07 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOB06 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2023 21:26:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5871C1A65E
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843616; x=1710379616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AOLVY8ScLhOLSLHr/VjLvAiC26pb7LJQs/YD3vXc8OI=;
  b=Pp2L8n+C1+jDBDr8t2hJCjPoSFupVBZrWCKEk/KHeDvbDu+xI/3i4XJM
   s9YTTOpeuxtcQ0qGxuy0HHKU2laPh0Zj7C7TMUZOHQIkDnjXnIuBpLj2e
   +EqbkijkS9rbSNEiQfJq0FZXJVr8JLPB6Cttn8lYRzbGP4qsgVuD6Mca6
   qCjm2j8fE+A4/zy2qFLj3rjGcRIUAF/q847WkzeoWX+LyglNsOlkdZPR2
   yRgSicy7w0dpXKHjTMipHVVcKu3geDC0tWxWUczBFvC+0tcv24OZ68g/I
   Vdl8WYbSv9qCoSEtjzb7F5jCFyV7QmDuqC3GqpHcYl7kMNGFfVvoe+ZZq
   g==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="337671825"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:26:54 +0800
IronPort-SDR: uxQbR2zB6OLzJF3BysA0mB3jBgd0tbkOmV371o8pWwnyVta/Cn5rpwc/WkOqXzDDAuti/rGCTQ
 FbBE6RU+9HtP4198gqihM0mrEoxndWqnL+mcMeYMUQcnvIV3JQOPdf4k8PkX9kOd+uLsEIEbA1
 Y5gVDUaKb1TCih1h6W5QvczwwmiFCARTfAKmgTWOLANolIOod75kLXKyTdDqRx9GQH9HDUY3Et
 ZUItviJT/gzNlEo7lEgEBEnFq0CR4bFXp2NCIrum8ZBj4eNG2IWJTjYXUsTIDe0toez9IHbS4N
 wHI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:37:41 -0700
IronPort-SDR: SLOQ82tCp8rbREI/Ptn00X+bQMhvib8HBt27TvbjMSws28jXUAVGPQ/TfP2wm2rRi5SZcsg6Hb
 sA+Y46GqPh3Kiu5NWU8qXmEKn1XBh3cLig9DuRgYtP4M4UEiZseoEZbiMP94j40aQlQzxD3Rqj
 EnA4zFD1zwhQXBamkGHtHzoao9G59Bnz1FVKCBWL8CCeLCjsXGi3kVJfYwCacRhpnaM9buXe6/
 cPR9+92HPLDrvRdwzd+/k1MMHXsMgrLIFbImo+A+Ibbg/VJxGLwd0d+fiqtRtx+PQ5MQAOBfNh
 HeM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:26:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt6666CYz1RtVp
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2023 18:26:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843614; x=1681435615; bh=AOLVY8ScLhOLSLHr/VjLvAiC26pb7LJQs/Y
        D3vXc8OI=; b=rdpJw30Y1fiXHSXoIUj1CirsSMNQQrW2blOBtl+hLqoJBbmTupm
        Wtek/7LLWelcd8SB7ocHF8J3jXrfrwvALOJknPPLmFOPrbSsyFEh2qlLe28POFpf
        2nBI38Zo2hesIBCR215un2dBZdCIEMWvzUYIa8ki94mPt7JEYoJx92RNmWitVb+4
        j3PfurWSanRiyp5WiIrctPloeS2ubGlu94WfXv7EY8XwfWueGQBOY1Ow6jefm79e
        uhX5sV/V/mylXbd5vLY91yiq0anHo+VBfX3gkXCgYBZlba+sgZswnvEpDGESVYef
        UO0pfd+rMXikQSf9X+6gGqP5fPPLLVHEkrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id btW589wvEkDu for <linux-ide@vger.kernel.org>;
        Tue, 14 Mar 2023 18:26:54 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt644vprz1RtVm;
        Tue, 14 Mar 2023 18:26:52 -0700 (PDT)
Message-ID: <16cc37a4-0d97-9881-9a30-a3a3efa2c244@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:26:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ata: Use of_property_present() for testing DT property
 presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230310144700.1541414-1-robh@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230310144700.1541414-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/10/23 23:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.4. Thanks !


-- 
Damien Le Moal
Western Digital Research

