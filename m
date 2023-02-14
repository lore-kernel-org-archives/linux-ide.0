Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D315C636CC
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 03:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBND1R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBND1O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2023 22:27:14 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44C1ABE0
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676345233; x=1707881233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C2DX287fihxIx3zZ1XYsGz3AZwndKdwrpwX0k0QUAWQ=;
  b=qyd2u6AQbaY8TF3mT+kv88eN4VNNtT/DI7yFvu+bOsVnsOu5Y0zLw0pS
   kfNYzIEcAseYW3uun5jnQNLD/LqfdVZ+5MTUUxsltifMByAqSsbK0a6tu
   3r+VdRsIWLkFQFLZBlusuOpOYlrnRJ6Nl0pJ2N2smNFxzfbmzmhKHXHh6
   XBxdI8fpBokLle0bg+dAxA1NPJ/N3zQOovC6Bxacti8Crj5yezUhbO1rC
   2h4PjZj4jLChZEzTJt+A8dYyNUtFw1BgCJ2eXEY3U4fTnI7olRAwtgUrL
   pFmUK6DVc0Zu8coCCrySME1UuUqEAWM1EpLoq0VfW8yCrMtne12rVYz2c
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="221534002"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:27:12 +0800
IronPort-SDR: DdB8NIodpIihHWDcc0hvbi0n7bIEVG4xU71BLqWAl3OcfrXdkoWLmUjoqi0lFTGMDtTerOKoxg
 2XhkVUVOyPmgOAzmqw17jdDzQVBlGGbT+bXr1Q99Ya6ICvvZ5jRQbn8JwnJNBEicXRqQDvTLAo
 8Q+yjmiw1MhyCPD9xa4wg3O15U1VgpdIcs4uxJI4cCfz03Ekdv9WXRgcEdz2bWeWAfC8CNqbO2
 J2HwcAGRw0IxflLDOvc7eK95CB/ggJmalcIf3QPjwK2zZG2c1071E1EQi+cG4gn5HI8s8AcsGg
 QqI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:44:20 -0800
IronPort-SDR: F3orgrFt6pXG0V6sigbLSdpRl3v5aAKMDhxHvEgqh3GssKOJn9gesyK4M3VEYu7yBrGJHlLS0z
 VDEDJa47WYQUIGuW2ebs6r8NEy+o4JMPLmCXf3ccMogmvrdzwDbPxJq4Yu+aoa0hUwMVMHe8AX
 ZJHGeniwNbMgjFozfYbbTFio6BR4ZcugMI6H1VgCLChQXoNWuaFvsw1m6blCGFLvFMeHEbngRC
 8nxpQfbYyl4SB7uGWxXo00QMUoUf+x0LtnPk8vVxs6OtFRoOVYMqpEb8Pp7LSM4EMVlIXrkLi7
 2Jk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:27:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG68J2KPvz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:27:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676345231; x=1678937232; bh=C2DX287fihxIx3zZ1XYsGz3AZwndKdwrpwX
        0k0QUAWQ=; b=njZNJbQ5di5LnVdvp1bpA7hocbJUDtSzeOAyiShtGuoRSppSJ5L
        OH8eXe//apqqv8YlltI89f4HIg2p//HQpsCtaz/88vA3zxaY6Y6i/sqtd1121C5B
        Tf6PVZ9BrGzKNJxVDyG7fZQrHNkPjunDhHT7fom3nWduwMxB4/jB7tDhgpI30341
        YR0kOifWPV4AGcyqxxP8LmKwZZW1zvdx86U58e+30aIFv4kiiXT3E+BYaNc79TLE
        diDUONFdl0Tn1FcdzsOteakeMIyLMhvSgTfXuhztjB8FY0d5dFjZSpXHc8/+rAFx
        XRZQc2bFXqpJRlevmjqV3OxLIjIRJ4fjeew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eBYyi-D6hj15 for <linux-ide@vger.kernel.org>;
        Mon, 13 Feb 2023 19:27:11 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG68G4SGXz1RvLy;
        Mon, 13 Feb 2023 19:27:10 -0800 (PST)
Message-ID: <f67adf9f-2fa1-efed-afa8-04c5149a23ca@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:27:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: ahci: Add Tiger Lake UP{3,4} AHCI controller
Content-Language: en-US
To:     Simon Gaiser <simon@invisiblethingslab.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230213102450.1604-1-simon@invisiblethingslab.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230213102450.1604-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/13/23 19:24, Simon Gaiser wrote:
> Mark the Tiger Lake UP{3,4} AHCI controller as "low_power". This enables
> S0ix to work out of the box. Otherwise this isn't working unless the
> user manually sets /sys/class/scsi_host/*/link_power_management_policy.
> 
> Intel lists a total of 4 SATA controller IDs in [1] for those mobile
> PCHs. This commit just adds the "AHCI" variant since I only tested
> those.
> 
> [1]: https://cdrdv2.intel.com/v1/dl/getContent/631119
> 
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> CC: stable@vger.kernel.org

Applied to for-6.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

