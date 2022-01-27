Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2293C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiA0Xfz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:35:55 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60859 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbiA0Xfx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 18:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643326554; x=1674862554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=joVDz8/kDfcvQwj7YtINoD9H51dhQI5sBaq3HaVkb6M=;
  b=of1189XhK5ESvCLqrHqOThE4E4zDxl+8BoxwJ0vSI7UM/IkwfpzxkcaK
   Elskuo4RvRL4mV0FBQF+H+plOpJiiUzW6cH/6FBHezHC5rLDvikQ7dDq7
   nlm6Trwm+NrW/eonK8jeJ15LVq5aW6REuHULS1eZ1djypbQFjDk4KaZyE
   xEiWz9FSEQkX6l9VkP5FXKO9Ng68PsE9lQ/gjgEnGPzlry/s2ufuDogtc
   8/lsVdpK9pFDOHfllN82i9bm0/YMpcBsytjReBM2rBne6qoAWL8VPGSF1
   gbe3Q+smdGP4gQPdF+S/RX/xezjZN6Xq0Wx4xTluwM3IMGNf4DUxieIyL
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,321,1635177600"; 
   d="scan'208";a="192572179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 07:35:54 +0800
IronPort-SDR: 6uwkrC4PvDnMrpAzpAND2P0Z1+HiyOpnGoRNSXSJfjGuaDpqUMGm2sBBym+REqF+orw61IUUYk
 1RUBWl5OfgOmx1NqsGhZBrYCB+joR+9aDTzl5ZaOVFNqRSDCnDlCAvSZ55yoLThNN/QUnEaQvV
 6lalgh1MDDSTPd+HirjSykluSB7jYQgHEHIBQi2T9jFibXu1m0U0WpZN1ykKNsOfYAFSg5vCBo
 fv4Cc+T3VRcLlYHJG8wYLyOp5E2orRz24CWk5MjZrwTiVKKKLGNFZeDP/uq/2d91yCl6YdKrcy
 g3TsiwW3DUKA/3LExsHOsOEs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:07:56 -0800
IronPort-SDR: 91tWQK4Zymj3LtMuMbFWBBAo7A93ad/V7HbyAq7rcvWMDIG1ACevjMDN08Us3xdDSb7zA3Sx6+
 KGV8UpM/91jhoqGbJPAsKvinG20BgixAmbkwtrH8CJGFkgT5MT0ZYMkzKavMaUBfPo5Qm2L2zm
 jz/gSP7nYQFKkPT8EgRFg6uJho144w8Pxbcv1HGTd0RQroKt5mUGRpb5d2R4+0BRFXpswqqgEM
 fg1bm+WqFZIO9cSBABK1iFsldRjc6Bpzq9J3xklv1S9JSdswJ9lpcpnrHveYXZHOv7KLxa8p+f
 WXE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:35:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlH5h6SJHz1Rwrw
        for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2022 15:35:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643326552; x=1645918553; bh=joVDz8/kDfcvQwj7YtINoD9H51dhQI5sBaq
        3HaVkb6M=; b=Yph6A1fRi5O0ZWTcnNxQkbGTrZSJ1BLFs09kmR4Ox9OCrn2OXIp
        Z7ehxOdOtTGkxPGFu48xw04XpmNBkJ8bUnaBnxAPOTbGG38ldLREjcUUbZUIsGM+
        lZyFQB9DsxF++Dhyn0KIBrH8q3A7kpP2Hnr73nr1ssgah5FYH2oWif0SpWMZuESq
        ny7gTnXrBLi9w9GjURkUicyVy5ZSA0iBzsBWmwGDILWDp/JMnwIICRV/ZT7+IyKZ
        GREV/XIxUZK2GUVDGg6atEHQO0TTxqFCPhjOtg/iyg9YJa9iJouivuwATWCHlAxh
        JFXvtzIMcejd4BeRgHMzSj/8rn8Gq0CF2Jg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MCTydomSAuOg for <linux-ide@vger.kernel.org>;
        Thu, 27 Jan 2022 15:35:52 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlH5h05sHz1RvlN;
        Thu, 27 Jan 2022 15:35:51 -0800 (PST)
Message-ID: <bf7d86d9-48c9-9d74-60ac-d8600f13393e@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 08:35:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_atiixp: make static read-only arrays const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220123221622.5543-1-colin.i.king@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220123221622.5543-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/24/22 07:16, Colin Ian King wrote:
> The static arrays pio_timings and mwdma_timings are read-only so
> it make sense to make them const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to for-5.18. Thanks !



-- 
Damien Le Moal
Western Digital Research
