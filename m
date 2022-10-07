Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB3C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 22:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJGWeA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGWd7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 18:33:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8253ADFB7B
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665182038; x=1696718038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z1MxOxLuwQzlVoWw8JPHXQP4E6eJDRaJDA21mMWTD2c=;
  b=SIQPzjw5Ys2MaXOQ3wOLltr9uh5zGk0rSeDfpEvHSEAR2RUHI+bNIWJK
   MtDPVzeD57OoCiVN2L0mPMAH6P2B5uT7WOwOD/BkYQ9Mzq58m70ypdi1e
   EGVYp9xYTuOEE8l9QabQ6RwVSjZ5eBle6xqtRYiqhcVy7HPvWDAiMf14d
   8vt6eiMMd3mrZNI8V6U6paQsPYFJr0/1zSgkk0byoQpi/4lKp6NNy97R1
   eeEzCgoKBSUP21V92Crk6X8SevwE88rodIQwLxIabmxn1PHK1A0aqtxUL
   OsAEMO5LYa+mITACJM0QVV8YbysPNKoFF3aiV92oSOlx1PweTJyoM04wo
   w==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="213668491"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 06:33:56 +0800
IronPort-SDR: 9gDl+4T3PoxcRcYO31l1QeAyFj8fz7pRKlRI35EEU8jPkbEt6lriJlZpgMEPji2N9xu2WgBBk6
 PfEz2HFrXr892arnZfRkjL8VRRjPvR8DcNy/+guMeyGiaRNJUhETzB5cruY7+tc38I0TwJAwNw
 /oiehl1S+nEt+pxEw4Ng7JEryGuCrQV8Mq5XVdz19eW/MGIRKXtRfRLfI9mTHvW4bNXGsGT9EA
 M1MU6mOkksdbNDlKqfd+CC5I8KqbZQWQOf5FThHoS1Dvi0jP3rYkfwvqNb4PN9EARt3YzODaSf
 v/5glDxCa/u4LPYxzNHeDiKC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 14:53:41 -0700
IronPort-SDR: tnrgGYfvf0XmRc0JdmDuWBXnlRA0kk2kneEp8W5tJejgkVwHLgPs6Jjh1Ke4GsgePJigjH2l++
 ts1RU7LsuP5srYheF3S6JR3kNvKVEnQ5XXhp3fpurNDCXm0bOOp8ujOwzPQlxdiOY++53+Ypw0
 X1KbeVh8ChnemkEi2mKUPbj/4wH85vl+8OvAS5EoM+/1ieJvGatiY3UlzyTochvnItl8XUnnau
 HRli7URjg4lrurzYwdrTvSaJkY8gXWSYtfTIeWxOJ60neUzlhM1hWW4OvIixPO8JRLv+gDBvqP
 Ydw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 15:33:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MkjlS3pMHz1RwqL
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:33:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665182036; x=1667774037; bh=Z1MxOxLuwQzlVoWw8JPHXQP4E6eJDRaJDA2
        1mMWTD2c=; b=iy0c+01KAhx65N8FvREaV06xsCPmFSOPlc6Xe2tUoGTH/a5Scdt
        Ah1/Ujxz++RQAB6H4qTL/BWryhMB9DZoGibjWRB0soWMAvd1yS0+6UONtf2RMtke
        XvD2Dgwdu1uPyHRxp8hniVHSqjKQV6Tgukfu5ENLBdU8Vb7wZPUeYeN+264gGtxs
        2bPH68gfghmW5AmSxqlCiPaV02mOE8AylReo8khgrdhhJD9UidFPCTMR747fPFk2
        qm4VY6cvKUH1guG2/7euW9DEBovWKVUQogSACgFWIID9HW4FMsrEHGssivPL00Jn
        bVufGGvxndZt3nEoyV/7ZTAK2BwyCdB/sQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id saZMmw7gKadg for <linux-ide@vger.kernel.org>;
        Fri,  7 Oct 2022 15:33:56 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MkjlR3zcVz1RvLy;
        Fri,  7 Oct 2022 15:33:55 -0700 (PDT)
Message-ID: <ac65e0db-05a8-65a1-4439-c1021e23d022@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 07:33:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     john.garry@huawei.com, linux-ide@vger.kernel.org
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-5-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221007132342.1590367-5-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/7/22 22:23, Niklas Cassel wrote:
> ata_read_log_page() first tries to read the log using READ LOG DMA EXT.
> If that fails it will instead try to read the log using READ LOG EXT.
> 
> ata_exec_internal_sg() is synchronous, so it will wait for the command to
> finish. If we actually got an error back from the device, it is correct
> to retry. However, if the command timed out, ata_exec_internal_sg() will
> freeze the port.
> 
> There is no point in retrying if the port is frozen, as
> ata_exec_internal_sg() will return AC_ERR_SYSTEM on a frozen port,
> without ever sending the command down to the drive.
> 
> Therefore, avoid retrying if the first command froze the port, as that
> will result in a misleading AC_ERR_SYSTEM error print, instead of printing
> the error that actually caused the port to be frozen (AC_ERR_TIMEOUT).

Beside ata_read_log_page(), are there any other path that do a retry after
ata_exec_internal_sg() fails ?

Another note: this is patch 4/4 but I did not get any patch 3/4...

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1cf326dd7c41..6ae5787103e7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2000,7 +2000,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  	if (err_mask) {
>  		if (dma) {
>  			dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
> -			goto retry;
> +			if (!ata_port_is_frozen(dev->link->ap))
> +				goto retry;
>  		}
>  		ata_dev_err(dev,
>  			    "Read log 0x%02x page 0x%02x failed, Emask 0x%x\n",

-- 
Damien Le Moal
Western Digital Research

