Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E59C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiBPHTx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:19:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBPHTw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:19:52 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D3DAAD8
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644995980; x=1676531980;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qoqVeR3ocTyilLYy8EhJvVOpGtScwGFaLw39GCyLRBA=;
  b=U1rub+anT9p9NzTPWoyDw1ZziiXo3nEUIS0Z2Za5Qplwch0F9xq7aK5h
   6vu9oKhakibD5hQ/8u/EBQ+eiyCfZ5eMDWbzpBOVDlJmcxwpuSIicGJVx
   NndVDDvxaJxQlxSIGC7Go69MsYiO+KBQr1NHoegVwdZvJg9FvkUUVSFql
   gtbQwg9HIjlO/IEKTs7KFHF7cBCa2Sk/fRsXA6WKlUaKKAHKWgg9CGDud
   1xYMwGJZqdJRgHOzbM4rYT1nJ8g1DEpHw7I4D7uhi7kdGQm8zfPTcmycC
   CqU8YFfb4WlX7vMVwl1eR7V3e99ssnyxs8KO5lzjt1VDRjz82lswSHJjh
   w==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="197895601"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 15:19:39 +0800
IronPort-SDR: 02qnHWw21ieGGqhbuCbgkcKmb34SEum+w48jkSDypEkyiqpt6RN+bfrxd7UmneoDPjbhGbPmxU
 KSm1ZFcQDkEUOFlp8UtYpKVmtg0ZffXtKOBg1RZA3561aVZFrrGo50X09slIGF4fcMfV70BIpg
 aZo+L6aCrNG9etDt0/o2GIITWprB9lhnm5Hi9gv0h8A7UQ84TyzXB8Kx7ux882tYum3RUY1fEG
 DAXh49+FQgcR+k7jwSg81KGiHYYTihEhI+nQ1ry/iQL4FwacS/AS7/4VEQnOgmSJ+TQEzQz8KN
 aEVo7YxHq3gite8WkEBjHOGs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:52:28 -0800
IronPort-SDR: FcZnkH58jGPUVTlu8zyMvz5P7dp97N5fdke8N1qYgm66jjQRMVT4sAUE22KlmKXKhwGjbqOz0Q
 9hqBt4btNxa/6jLXcv7v3o6Rr1N8WxJc9HkPkx9ZjCZjAE24NKlwoC47GTklx1yM79w+vYPnWN
 95mpiIXc+1kzAnQHrY6oCB0zZ0u/BQOJmFi/33jvFoodG/UXCX5YFU/U79UEyd/CrM6Szpk/zU
 9Nx1dbQn4M5sgL61pIfCIET439UDGRSwffiw6TU/tW19HYeEyD7GnA8AKzdh10jpLa16pTIF/i
 t9Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:19:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz8V43yZ4z1SHwl
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:19:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644995980; x=1647587981; bh=qoqVeR3ocTyilLYy8EhJvVOpGtScwGFaLw3
        9GCyLRBA=; b=RlJtoJqodt+MOUZFYezliFTMkYNvKaYF6VMsF23Hsiv92tWpkML
        FNWqSUyCpAYuY7oYscI3vabTIYjp0ZmlbUM8nmaxV4rkOPIn4yt6reQGLBXaqyBL
        mqymz9CygFMig2INdG4h6jLIe1P/Rbi0dYQLzxQXk62fbiGnvQ0YzI2RuLtQXrco
        yYE/n4JTJKF0VEbaDDoysvN+Wfy2CYdXLgsEd1F9YUDeGX23D0D4pH0ZLev/gk8i
        8z/a+4Qx1a1qQqOzph+gVH8ncyxXwML7eYwCMDqIuJ285AhZIKfL8ZlcRYPvgaYt
        HdTD2HZH0LtP33PaYGGB63TNbWzMLOlEuYw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FuWOSckdsB2E for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 23:19:40 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz8V36Whjz1Rwrw;
        Tue, 15 Feb 2022 23:19:39 -0800 (PST)
Message-ID: <f1d5afac-c75d-b6a4-9de6-d6ef7b2ba2c4@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 16:19:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] Disable the fast interrupts in the prereset() methods
 of HighPoint HPT36x/37x drivers
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220210192214.14205-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220210192214.14205-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/11/22 04:22, Sergey Shtylyov wrote:
> Here are 3 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. Disable the so called fast interrupts in the prereset()
> methods of the HighPoint HPT36x/37x/3x2N drivers -- that will allow to
> de-duplicate the PIO/DMA mode setting in the HPT37x driver...
> 
> Sergey Shtylyov (3):
>   ata: pata_hpt366: disable fast interrupts in prereset() method
>   ata: pata_hpt37x: disable fast interrupts in prereset() method
>   ata: pata_hpt3x2n: disable fast interrupts in prereset() method
> 
>  drivers/ata/pata_hpt366.c  | 13 ++++++-----
>  drivers/ata/pata_hpt37x.c  | 48 +++++++++++++++++---------------------
>  drivers/ata/pata_hpt3x2n.c | 23 ++++++++----------
>  3 files changed, 39 insertions(+), 45 deletions(-)

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
