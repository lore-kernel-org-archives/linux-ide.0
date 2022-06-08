Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DFEC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 07:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiFHHio (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbiFHHDl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 03:03:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5C115241C
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654670852; x=1686206852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AshAkPGVRjPNRpK7xNmyiqDFMwQiYY8Q4AwUps1BADk=;
  b=MyynZRdcVSHeGE5NuhhZToxHpujX/YtVOs+50dZ5rDpu+wr34TueHgBY
   AkzHUuO+H2y1cXRrIenEesTRy4On3/la0wvsTq3558ONn4+xUBlZsYWoF
   vChsSWwTUJmsdQV/3nMDKqfnYOHnwx4BCNL0s2kv3GoVyoT3zQcPLlnD4
   p5UQwhi3t1ATtmyBVH5S3sBNXYO+0iJmQcbb9oT14IByjaYDYqPP5lEnp
   oKwtdJGzTFdeGloyyanj9ncbY8hy9Z3PTiXOdXoS/PTYGXhpi9KuqWeFn
   4LTulnUragLXF/XMrvFI3247NbS2P6AEl4WoBKr4O/VqfnvUmgRvOYvs8
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="203351865"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 14:47:31 +0800
IronPort-SDR: 48TByQYpd81VYg2LZdb1KjpMYGHDk2ou+qXcg96S18/O2cvFuyBsPeK75/cy11cUssW2yQjmYO
 OVCHtR/p/WMxOFYoETfgRbGUl5iA4Z5ZfusMVhwLmplVRIqfgZz4hJQBD16bKEHGs1t6Ere5Px
 9+PHDCa3z25PDTgaJibe1lRV9XoRp5K1KIyKdwaYc4pkK2qOid+Ie/mMGSSocNKlUXyAeCklyb
 iQKmV5Ut8ci+SBkxMGgQgTDdnxm52gMrqua531Mz2aGxTgvjK34EMD/04u2pEyDBPZFZ2gbdNq
 oxkq+4sZIC4Qmg1pf3uYRhR4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:06:15 -0700
IronPort-SDR: CFdvI+XEKU9tKKagLp72LJ1su2FwBw1cJod94StKCZtIp6P81qB7MCeeb9g47vHp4cFKWeXIiw
 +JPRzcv+x8wq+oKh582FxiWVbaotivTHqglmQI/34fFE0wdUe2BQiByc6zWVl9cSxQy2P1jJdV
 vOnFji3cg7EAKt+PP6uKcL2xtWPuv9o8OL4t1KVTncVeDqgBz1XTlMa+PanMzHT63S7owPYR/2
 pqIzm60i0H1rsSz5+cFKRV4aUgzPdhXV9kB8G4KYTU/2cvewbapbPo28KP33t8GUTVJduD2Bhd
 RD8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:47:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHySj3bf6z1Rvlx
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654670821; x=1657262822; bh=AshAkPGVRjPNRpK7xNmyiqDFMwQiYY8Q4Aw
        Ups1BADk=; b=HtDL89HRbptufvAyQXNnspk0K0Xz1beUXwq2pw4lZInAhZzeI/D
        rbRwopDTlGBpKfdwM6pV75DPs9fDHqhKl5nWoJdsiBDuszDBE2qhMlZuTWGnDUaa
        X9BPmBO5T7pzh0mQ76MSWqt5hbjBTJCHey68zzFS10nhgvCGbvyURmyyjYhNigso
        eXq6Z3+Dy6scC95+lc6YAtAoMtdBT3JUWqWZgQYJshWEYQXciY+6in6owLYKxYdc
        iMRGqipEtlOiakGNG5uL3nS/eKW/D0ApxNcyciW0YLQHEHScVfTywslmPPQPwTxt
        E/DEBJ9kc2+6F1PdxeJT2XMdKM0VEi6tP/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v7VCayoSiOUp for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 23:47:01 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHySh5ymCz1Rvlc;
        Tue,  7 Jun 2022 23:47:00 -0700 (PDT)
Message-ID: <d3b75cf5-d417-56fd-af21-bfa347f008d7@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 15:46:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata: Fix syntax errors in comments
Content-Language: en-US
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220604142927.15286-1-wangxiang@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220604142927.15286-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/4/22 23:29, Xiang wangx wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/ata/libata-transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index ca129854a88c..3a71107169ae 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -9,7 +9,7 @@
>   * and various sysfs attributes to expose these topologies and management
>   * interfaces to user-space.
>   *
> - * There are 3 objects defined in in this class:
> + * There are 3 objects defined in this class:
>   * - ata_port
>   * - ata_link
>   * - ata_device

Applied to for-5.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
