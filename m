Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB1C43334
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jun 2022 23:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFSXXn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jun 2022 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSXXm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jun 2022 19:23:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26564DA
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655681020; x=1687217020;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wlBtrmb2IAthqvnfmXg/8HH2vRdnhBbuYVp8//KTt+Q=;
  b=dFBAYoDMTQ5VouhOKTLGHA3nun2wBle2O8+QXG1/EZUEZc7ZkAQYjhlg
   vpN6qyW39zVNY4c0ju6AC49mEW6ki3IAdCWrw6ol4J+Moch++LE4IJLup
   yJvfur9vvE1iecyS3pHiIJ7/tigQlugowBUU9AZByv7atjjajKouuOjUm
   EURv01MUuGpNXohzvwmUSjszBHbTvXInt9LdDeSGL4CjnahsXMthRMO74
   RIzhkZBUfNj9rsaijkeZZlc9tEeFpDqucVkcIagN5T9zBp1XF7QJbtOIV
   xRi6PTUt5rQboiffk0MlsWrM7VrFhmA5EliuaoXw9hpDxO1qJi1NTVox7
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204331880"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:23:39 +0800
IronPort-SDR: HlAq66glUDkEOf6z0mNv/eBDCtOgMIdwmKhaRAiwXkczTdy5P2Q8Zlig3OIDGk/gjLeUa9Y9EH
 5wfw5z2kNtmCqreVIZMKfugnmqcjmqjVr8GQUqWsTl7V4qqsHLASnwY16nWT+Iu2keXtq+xnzz
 OCzyYrRPBqDWhkc/FqsxIE1qB84s0FAkOi1nIc3HUrUThasX87dy1lq4zH9lq1oNDQBX+dzxR7
 FE/3zAeixcRDgsrHI4lJyYIazul8WEnk8CUyNoT/KgvG62vDak45b9d/+W2d6K8s5GN5AiB+HQ
 7NulCdkW74pJi4wlpi0NS+vD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 15:46:11 -0700
IronPort-SDR: SKVPKiR7Omgr7rdgy8Z88budUX9rdZPmLv2w4oZDAaYyaUY0RgYznp/ALntehgQfdFpk5KO3vQ
 f6TVx+YxbYDP0O8O+HyJT9kCF2zNyvX4nzhG56zpv8ONH2GdmoEdz52L3MzHA0Dw1bT9eJl5ou
 5obeJomuy5451zuleEDl9KUD4VJqxmfU/Q0l97PrQXzNQYp+MRajAKVXo2OFU/UAPXODi48Odl
 CJ9PDN7X/Lp0KdeGcTYAfSmpqIIQOcPZHVPhplMRDNwZP3r1r8fjqbf2Mu+77TDfSL2wv70HZF
 0t4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:23:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR83b1gWLz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:23:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655681018; x=1658273019; bh=wlBtrmb2IAthqvnfmXg/8HH2vRdnhBbuYVp
        8//KTt+Q=; b=Zsty/NGg18ojvTi/YbXtUGPaejPotpIDu1pnmfZClFhdbqTSWXQ
        AcGr59Mggx1iwgFaHf0Kz2FRRpd5tdyrqN6suYblALQfWIH6PGuhZzz7IafetVrB
        +h8waz2g5PkaPu/+nUf8JsYXdjal638Nb1Kdn0woPcO9cmQZ8V9u2KwJ426Yx07b
        KRreQr7RLsiEXIGU2L7EIKJHwejA3z84pytJLSOogbXE6FCw8ChKbvcIY+3m4Hyz
        3uNjPuUMnh0OY0y4GyUDBRshmAVV3Q49XJ066RvpDYCIvS8Vmmqp5+/x4hb/WtlL
        m1ThdKbFPG1XhvPp/tQsLHCqJ+rvbN+lVXA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WP9KOxnT5VVM for <linux-ide@vger.kernel.org>;
        Sun, 19 Jun 2022 16:23:38 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR83Z3s7nz1Rvlc;
        Sun, 19 Jun 2022 16:23:38 -0700 (PDT)
Message-ID: <6520dedd-9973-94a4-b594-6f522fae61c1@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:23:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
 <20220615193821.9235-3-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615193821.9235-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/22 04:38, Sergey Shtylyov wrote:
> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
> milliseconds. Then follow the suit with ata_exec_internal(), its only
> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
> caller  that explicitly passes *unsigned long* variable for timeout...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.20. Thanks.

-- 
Damien Le Moal
Western Digital Research
