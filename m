Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19ADC433F5
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 07:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiBDHvg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:51:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14406 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiBDHvf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 02:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643961095; x=1675497095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OU69SPUa+l83Mu45cpLpffTedY3GSfdNyoABwXgUlNg=;
  b=pl1U6BmZtOqyrAnBR4sHmeEj69VA1YYTjb4FubcnCAoUtvWj2Gl602pH
   9O6aItV8rfGyG9B1/H8O7O/ams+zkPog0gteqL/tSvd6eMIffy/CVa+Hg
   CHxVSLQXdmyMP534eCNLNY+uS8OJzmERs1vLvGQvD0/lYvpyUQpB01nzj
   lQBmCg15mcxagaS2eAWmoKVSG1CBCINDS6E4Q5vuPWaYofmzF6Yg9XhTS
   RiCxu56cVou3+k2+y/gpwfc9qvV9REuZLBxBUNNDjlR2uBT/ejeACj+qx
   M+6NgALdNmv+ss9q215DMT1sZNUFgbF2iMwPeKw6TVziwL40KF9KccIoF
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="196962752"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 15:51:34 +0800
IronPort-SDR: gP5QucSu5Uoyw0XED/qlrxmTHNPsaKqoHzjrB2k/QQZUi3nI0sQqs8B8fIRxGR+O7kF+Pl4bZ6
 cFs/Ef/WKtY0RyZNL3V1jC90xLTi/cqsoVPnK3aFs8JcyeF4kkvNbw6ao/WhJ/dxRPwvxxX59N
 fjJdRfmLlwSY7vIyyB36Ub0MUi5lhHDQRtjw2w6bngLhACcVf4Z5kKhwX1rgv9EyFNjGqc721A
 bQnSMrOSTz59C/l5zOwrPCLFvOS0lnBkGHkA9k6Z3Obhs5x1v3pUtucNSZmVFazmz+jCOyuS1S
 z7ot/H/exW66hO2c5SCP7ogc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:23:30 -0800
IronPort-SDR: P2Zw/BOtWUj2+WWGbzZbN25y3n5S75yo3UKBubEljyJj9T5E44RDEi1IqqO5yutKWzeWKdl51N
 GgYOGPVUOrSKbXLfciTEc5sP8djLg9B7cqDVu6gCsfjTC+Uq/t1klyxJ8iwVM/NiLSdTlDvovW
 D9N2r3LfYwysubi3bZrOScmw82cnHh13tJDUqEOlJYmXqWcmnM5BROhN4uTLBM13SHwuI3ldN9
 z8qRlaVd4M0ICZ5tWgqmsNNZu6YaqBnOKnBCCmZNxlUqnfWTWxp4gSN3pZi4ExCdZud0ttZnLk
 dEw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:51:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqnmQ6Y7Tz1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  3 Feb 2022 23:51:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643961094; x=1646553095; bh=OU69SPUa+l83Mu45cpLpffTedY3GSfdNyoA
        BwXgUlNg=; b=BeFR6wGozfxGiIYz7H5JPW0yIHI+Yih3kiyPkqNhy+cmU45ZnQ/
        udiK+7p4YfpxiUZDGreic9gS5LSjfi3/9PuOT+D9UZX/PUubWcBIVul6iyBfyDHy
        hgZsZ6c1l4opf381t+j1As2ULX5Ci/nx1BcRXVr/kwVVaYZ5d+Zto3M70HOfrFOj
        3nsba/r6eTMrk7qBUYrSn9MxxgtVPE9e7HB43sE5RyKMHJvJqknVzdgEVNc+H8rH
        i2vMTzxbwK5XcMQYUVujfwTzVRgiLL8lMj79KsJRe3fa0MaR0osArM5nonPOhyXX
        hdXgMh9YmTG0rsqc8tp3XMVJ8PPuR3QUimg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IGwA5FEs623y for <linux-ide@vger.kernel.org>;
        Thu,  3 Feb 2022 23:51:34 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqnmQ0wfnz1Rwrw;
        Thu,  3 Feb 2022 23:51:33 -0800 (PST)
Message-ID: <edf57911-dd28-881f-f723-cabb3557dd43@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 16:51:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-core: Introduce ATA_HORKAGE_NO_LOG_DIR
 horkage
Content-Language: en-US
To:     Anton Lundin <glance@acc.umu.se>, linux-ide@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220203094135.2437143-1-glance@acc.umu.se>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220203094135.2437143-1-glance@acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 18:41, Anton Lundin wrote:
> 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
> introduced additional calls to ata_identify_page_supported(), thus also
> adding indirectly accesses to the device log directory log page through
> ata_log_supported(). Reading this log page causes SATADOM-ML 3ME devices
> to lock up.
> 
> Introduce the horkage flag ATA_HORKAGE_NO_LOG_DIR to prevent accesses to
> the log directory in ata_log_supported() and add a blacklist entry
> with this flag for "SATADOM-ML 3ME" devices.
> 
> Fixes: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Anton Lundin <glance@acc.umu.se>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Applied to for-5.17-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research
