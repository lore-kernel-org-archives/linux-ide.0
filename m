Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA6C25B08
	for <linux-ide@archiver.kernel.org>; Wed, 17 Aug 2022 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiHQQnK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiHQQnJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2022 12:43:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28D85A9D
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660754587; x=1692290587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yrba2/5d9DHaB5d9HOAvkuXBHfeeQjpyE+nVk0A2pqY=;
  b=SDWfmG9vMKTVqD3W2AJvNpI9xudAVewlYhBINI3uI7++lT0H8VsxrSpO
   W28MiQ3QvBDA0xQIxtsJoAO/E48D+E7GIGpMlV3JP+ErAiyNwWee9mUn8
   pc9e9HdCSZWJs5EttvmQjNIegxigB1j//5RotsD0XD0IjCU7yivaaDhP3
   1XNetLyeNlNUvLBdSswidMgCj05Vh7oVyufZhai8tHRRpcvqfm3IurSnD
   lS67ber+09bXDa/6YNsdD2jv6Hw6kFhB+06z3e5BvTTfbZacTB1Wm1yFD
   JjZgJ0tNt7864SRMw1X1gte3ZwP0EaDtRV4jYfs/4NBS+TaciZnG0+3pr
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="208957692"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 00:43:07 +0800
IronPort-SDR: AtxtzWupfBUMH/E29cRx5t1cLHHtzUBfCyhUN6o/zGkg8iZPZCaHudH2L3gMO6lhQiY9EMWcFG
 4wFoAAwXh5MMdKNoRlYWjcSrn2FSvVHsFzp+EkRbrQs1KB/UbRIJ7+NnvD1wP7BhuiVI7Fg2rS
 pURVg4vu61JfTBTUZ4d1io64MLwvKgWlGxALsJfVRxdWxiG4iEZpHr3/pfeYDjppaMj2l9XFsr
 EqyRWu45M0kL9xhC/BOiRpwAGVZpAyZBDxEMdPKWxqfewE3LVmlgdR2UT69CLH6lj5MCbITQoC
 mKAu72tb2yNT+8SuKd7H5ZTB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:03:54 -0700
IronPort-SDR: KD5kQP4JxYsd7HPKmdQvee6Dy/A4ykfvoIewXxwWrJWBVk3AiZxeNv0yZMNY7aM0GH5BCzF/Mw
 yCjra8yiWunu2qYPUUenwlWDmFS5IjwgZddlKX4HzHYsDkeI3x4lO0eAbjgndk3+VLuUubb5k1
 8dJEIO/IhggeRSzfNMV/9RY1fX+zeEuy62DNSgaG5lR2JSpc6oAkiHdngO1qPJUwBHu6eVvKoI
 KHVbZbSEzWErzBZ//8XJTmUfVhCcH4mS3Tf9MMb6mg7l6Sl5SB6EIM28O+wfbcp+Di9rVN/ORY
 ALU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:43:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7DNC6tF0z1Rwnl
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 09:43:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660754587; x=1663346588; bh=Yrba2/5d9DHaB5d9HOAvkuXBHfeeQjpyE+n
        Vk0A2pqY=; b=NYAkJ0KIsTDw1jSZ3Y4C+0JhZAM1g2rz7KbH19qCTyNNoBcECid
        SKx3uVrY3yqYR6ipvoRZjxJbp9KZ63FhNMiwQf+d7wjWd+UMuwQl0Qkt1mSeJTqN
        vgWuH97iWLG3istuS5mGJPg4f0E0AL2TRC9RN+7+mC7RYx3TFC6Nl8fHAz8APmXj
        8ZNZGoQrtu+9IdafR55JLAxnHi/WwGTdZnfU1J1n/RHGOcctJbS9y+Ko7YSkaeTf
        eSkOdumKm0nSkjzvn1OiR+e2V6RamC+Qejx9bsyQ/FXC329OKpNcL3SAqnW9dTpI
        QpBElsBu0e8Obc+3dk8hv+4IYtJTFVyaxoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A93oVwKr7TQy for <linux-ide@vger.kernel.org>;
        Wed, 17 Aug 2022 09:43:07 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7DNC3vLYz1RtVk;
        Wed, 17 Aug 2022 09:43:07 -0700 (PDT)
Message-ID: <e6c84c32-6737-86e4-1e3c-8828864fad04@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 09:43:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4] ata: libata-core: Print timeout value when internal
 command times
Content-Language: en-US
To:     Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com
References: <20220810175909.14485-1-thenzl@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220810175909.14485-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/10 10:59, Tomas Henzl wrote:
> Printing the timeout value may help in troubleshooting failures.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
> V4: a whitespace change
>     a switch from an an infinitive to an -ing form in the body
>     a fix to the title prefix
> V3: rewording subject and description, no functional change
> V2: timeout changed to unsigned int as in for-next
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..9478194740e0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1578,8 +1578,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			else
>  				ata_qc_complete(qc);
>  
> -			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
> -				     command);
> +			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
> +				     timeout, command);
>  		}
>  
>  		spin_unlock_irqrestore(ap->lock, flags);

Applied to for-6.1. Thanks !

-- 
Damien Le Moal
Western Digital Research
