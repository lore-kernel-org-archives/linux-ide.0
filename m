Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DACAC54EAA
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 01:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAWBPK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAWBPJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2023 20:15:09 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42254126F3
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674436508; x=1705972508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LuyJfJNm5m5Jpm5aU+fmbU7EjQu9MnQinDOZWZl6LMo=;
  b=SlAwpZBYFBfeJOyWSWCepnK3C5wIZjympVpK40W7Qh+VfpGHqDCBWrJT
   v637wnbVZuT2uETojU1AHxvD1TxhH42LW076zGJ+R+KVLisH3sxv40dfC
   gGoONo7V9zT9G/9ApXbF1bqB7SULV9rFdurRxPzCenefg1Y5YFVHIkS9i
   jvdGmxmcDZGqfpU1z9GtdcheP3uP9OGUozg8It4rYB7gbVsztXsA4jU2N
   7ogJ0Q09qN8GcAnR6dsEsHITD5s97A0BSWh3Zr3UdQO8KuNSrFZEPDF1C
   8ITtwu4d6LUOiFt+iy6+7Y65olsXvtrG31xKpvp+KKyXediEqUhwo1aNf
   A==;
X-IronPort-AV: E=Sophos;i="5.97,238,1669046400"; 
   d="scan'208";a="325809181"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 09:15:05 +0800
IronPort-SDR: GdgBN9+mv6+OY0JLNw9iMibVholMNflK83aWzl2JsMqnNHsiEtwZ/TW1ZqnJrVba2BrUNKFKAe
 0jLxITA+omYrxT2mnKyoaSdHGTJ7FqoRBQTROeOWw7LoVECl6cLBBamByocgVLAbAU3CAkLE/U
 3isZMRJBuaVsQbwAfLGtlUIn49ztWiUmLcqlL8EkiGw7xHNDkaReMwf+9iVIhJ+0MDsmHdMYaC
 9pt1Kwx9CpTREMVrlihCng8YiDscX37tyYIgcA6IidWDvgDGK7m4+VT08y583r1yR50dwX+ECG
 fBc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 16:32:40 -0800
IronPort-SDR: O4NVwe/2aPgg3SJKXLVrHO8HInFZnvoacdLXiR0wz7UGCJS3eqxiHrz6bIZg7UKKHShKwZOPP2
 sxKWLAbceORzGt+51ZmieBAJyQie4Q6zq5Epm9bNZtPGmu60z3wpoVB5bxf1PrewTmXnUPwxtl
 s+9gdQ2im0f6I6vEZA/rUqmci/NdSv0eAnct9rL3Bhyx+KvLi8zEQOxPcvsB+PjPp1yKm0N5hI
 r0/MCM9lOiZOXtkisAvqmEuS5tAQOO0/CJs3Cx6r9YL1vBoHwYzrQ09S/KhxfADHDV94TcEMnA
 SmU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 17:15:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P0XG12fmXz1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 17:15:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674436504; x=1677028505; bh=LuyJfJNm5m5Jpm5aU+fmbU7EjQu9MnQinDO
        ZWZl6LMo=; b=JM1/DFvqlMOlc/TfZhjLWeE9jxx+TKJhhVK2qBWIGFM+YpgmUp8
        qz4Iji6xp921vG/YLvxdKPLB5dLgqL1BMEiVL/GZjTdLL33LfpP63KDsteIl64z2
        23uycPOhH9edc9ha/iR3zRY8tGb8R+3fxdhIZ19kwPQ/WnYkVSUn5yOqo+VOrABQ
        sCAGCo2PlOwr3smT1ji6jDOJpyjXtJVdXG0E8LrZrXhBoeqldF+DfO6jkHScB9Gp
        yBlZsg/SaKQPjb7jstkx/Gp4HJiCh2VF6x+55wC70ziS8xN5xWHqbXwtJAuVnVdT
        YK1ho9cYa3SEsdj/QzfPWvZtF41VNbeSePQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u4e9s2gjirY3 for <linux-ide@vger.kernel.org>;
        Sun, 22 Jan 2023 17:15:04 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P0XFy6wPpz1RvLy;
        Sun, 22 Jan 2023 17:15:02 -0800 (PST)
Message-ID: <bca52f5a-ee84-b5d4-1f81-1466233c5425@opensource.wdc.com>
Date:   Mon, 23 Jan 2023 10:15:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
 <20230122075710.GA4046@lst.de>
 <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/23/23 03:24, Jens Axboe wrote:
> On 1/22/23 12:57=E2=80=AFAM, Christoph Hellwig wrote:
>> I suspect a comment in the Kconfig for the old PARIDE code to point
>> to this and maybe even a runtime warning when using the old paride
>> code would be great.
>>
>> But except for that the code looks awesome, so let's get it merged ASA=
P:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> Since Ondrej is probably one of the few (maybe the only) user of this
> code, why don't we just kill off the paride code in a separate patch
> right after?

+1

I do not see the point of deprecating it first. Let's remove that code
directly.

--=20
Damien Le Moal
Western Digital Research

