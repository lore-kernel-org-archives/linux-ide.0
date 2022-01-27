Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF9C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 23:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiA0XgW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:36:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19356 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiA0XgW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 18:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643326581; x=1674862581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UKXzrQof8NaOxPmgnzO1mhwHUNodPgS3KM3hAoXe8WI=;
  b=V7k4MOyXtxtcNj0010a/0qTWMjeAjORKCC9N0DZB+M6fN949y4dVRJYK
   GSsrs+I29sbV7Vxz0pR5TyCES/L/BShMwz+kQnWKJEIe+qJwj1aywm0WC
   IO1gCtF2uZ+rjRqXp1kdv0A/oP0LdjgrrwKig9bnBt8t8KYyazRX5QgZ5
   0JK+kVAxVDkp3QNjcC3mXkiTksWHhu06G88oTel/iMraPvudOgVTPhWv1
   6XSYP82wk4UQwDL4YONPiwL8CMxl69zHUv5aBpKJnsJcTXlDVA2qS/bFX
   a02vT+qaWGqzKTBDRXsbhKbmeWVhrlpau2rayr1AptnNzbfWdfpCE0N/x
   g==;
X-IronPort-AV: E=Sophos;i="5.88,321,1635177600"; 
   d="scan'208";a="196377390"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 07:36:21 +0800
IronPort-SDR: GfrZ7CVK4LWFlfNaEDZ9GfEkWNRbsLGbDYq3SJvUp9FHACInxr3EKLTo4v/tOjJovfx/AUbleH
 DXIxzSk24pJFJ1U1gLabDt69HEUDkGb/Jhyu8H2Mbl0sDDxH0Rz3OGMGsg5e3N3SWpRpElDtbI
 aWB4o+2VpYigxSMTF4HsO+kkHGmciwN46TdZZfFvi4zgxQkOmSY7A3f2fhO5L3UKvc8Eas2Kiu
 0IcS0Mu4W4jHV8nKSEpTY4lVsV92LsTQk1HJoQeigAX6dilcVf+8M1JQmgUAf9f6x0rwVzOEhz
 1XEgFRVAUdUKcFUbc+ZOwujx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:08:25 -0800
IronPort-SDR: N7eOdzLPjx0IQ27bC049DeCLP3QJ0ZM5qgEr4KDEnPQeNWoG2vAnC04o18nEEBFmqoK6ekZ7DD
 HruxV1k7MYBZTSEvkcMOzB1BzkA3cN4oAXgeE79cOAuvU7JQY3iZMBY6tMGxdEE6LO3DawCbHu
 7d6KKlx9bUywvD7HAgJICEn/iU+44PYIK7RXLfgoIIKgEQmkK1zskgl45Ndi8SE7a8VMVTKDP/
 hMhTQlYJuLjA388NNbBWsGhoKPixTyuxSYPVzeXDucCdPVRFNK6Brzw9a3xDi+sQBQYiJDevpR
 GHY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:36:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlH6F44Xjz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2022 15:36:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643326581; x=1645918582; bh=UKXzrQof8NaOxPmgnzO1mhwHUNodPgS3KM3
        hAoXe8WI=; b=Nxv5FNMr1+o5ssEs1jZ/AYQoEL2MiP6W7oVyb7YLKiTbKLBkgMZ
        4R5JaLXpBux0kO5+Vpsb9VaBKaIlQzV/mUMEva3ViFhMXQRqamlhKslL4/n6e2v7
        H8kipuQGXGrZUIsLu4V5Iy+GjMc1JM5jwcrevivgqgVuWpT0uOVdio+8tM6yYBie
        MYGheQA66n3vd09IbhO+djGNqvkwvvoAOuKKM0ZLoiZ8o4D8o+u8zgcw061+HrDe
        /rdRmIxFU1NPUPgITQGA3E4znfBGFwssn9+dzh1mzWyt6v7YOEH/gCdtiENHWxVL
        wFY7FnQDhZKzGGuqfpLZnuQ8x8UEuUIbUHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ia77e0Mx36i3 for <linux-ide@vger.kernel.org>;
        Thu, 27 Jan 2022 15:36:21 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlH6D5h0Yz1RvlN;
        Thu, 27 Jan 2022 15:36:20 -0800 (PST)
Message-ID: <ba528fae-5c5b-f8cd-25e3-02cf84a279de@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 08:36:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_pdc202xx_old: make make static read-only array
 pio_timing const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
References: <20220123222246.5801-1-colin.i.king@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220123222246.5801-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/24/22 07:22, Colin Ian King wrote:
> The static array pio_timing is read-only so it make sense to make
> it const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to for-5.18. Thanks !

-- 
Damien Le Moal
Western Digital Research
