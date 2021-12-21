Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF68C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 04:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhLUEy0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Dec 2021 23:54:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50122 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUEy0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2021 23:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640062467; x=1671598467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a/wMZz9CrZXLjivTFTZZRqGAfks9G2lpHxOQXEEBUzs=;
  b=R6/9vjxPDAVyT2XHlCNJcWBpGG/YTYRdp1kPZ8McdQmRww9VzmfWID+L
   4r7nHSwJ//SClR7ntwcuZTmq+9nYLCy/Dac+mg3q3GAcEjewUc00e6t99
   PfvVjs0fk9tIOVKwlCLyKSuvqwwKcoHAKRGhxFC7JiTZT2Y/foA6WQ2/m
   kH9PbZBGVw2DlHErp+uMTc+o/jZv/T3blZXGSyB/y/SbLJkOQykElJ1/c
   Z+dvzeO976roM50mrlvpRmiD5GY7ozT2V54cMFqeOYtsm0FR2oL55fHq5
   +ZGQuzs8ACfG/GPLlxZ5gKRtnRK6u9ZIukgJlrLksvYqG4pR2AyHgLD4G
   A==;
X-IronPort-AV: E=Sophos;i="5.88,222,1635177600"; 
   d="scan'208";a="189764683"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2021 12:54:26 +0800
IronPort-SDR: k07+A3QBZDrgS/+FMWMgGmJxmMoqfvGDT+H7CzorEqkR+ttqffpdrWNW9tn1huOBmbt5XdANFz
 HKFkMWsE9GXr+BN3qOhCRMGMpQ/EMuRwtY5hxI+IZzOi7G6ykRc89Rod6cSGzYUC0WgCrlovVN
 ZflnDuvdCjV6AInB4T81TrLvkdguXfjcGX/pNtjxogBqAhkH0J2Jkfw0TRH1J/sycuy3xEKi+k
 sihaKEcyCo9jcsjX8PTX8v4Jk8arbBKBsvxR4D/2whYpLzc424Z99VlxQPIp2vFHjdFLI2bjeO
 ITuMLTjFJWmSVUlQWwKfQ/ui
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 20:27:14 -0800
IronPort-SDR: F3o1yRxDutJHRKxPvbRy7XBQmmUx7ual29iHPkvNd8ze0Vbe93gbC5kO2S3UHaytxk8o5pZVDZ
 W4+GaN4NGo/UEE3Tcl7ILW2t3xPg9fIuz1gCL0oC1+KFAMpYMxEhtYz2pxiGM9jHbJDERxTJ2e
 FxKtWkAboJmw07caW+2qZdQG6Ak4X0sqqGbkeqyche1LKXXYfSGvCmkgqUI5k2ORmcskeNz5EN
 ztlU/NpFWfM9HQ7PIzlxQltKWM+TZhckuWm2Od+sRwtwNRuSXFnzHi6erRmb+e7uIKZIKcVZpf
 RRc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 20:54:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JJ3yn3VTfz1Rvlf
        for <linux-ide@vger.kernel.org>; Mon, 20 Dec 2021 20:54:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640062464; x=1642654465; bh=a/wMZz9CrZXLjivTFTZZRqGAfks9G2lpHxO
        QXEEBUzs=; b=DqEeyvBKk/eFim4n/fx4v3DSxkHaZvVT1+KW1hyQ4g7OBxjYUd8
        RWf63nMkjyFITTKqsWgGLk+/St/NLTGvcM543Ds68oxWFM59EXmIESDINRiZuwkz
        fFHXokJHM45K3hJsFfD/Qzv3mwBZZb/DaexTZkOszsIxVMRYGwjw21clozFaiWdD
        qGUFHQkRVxPZHiEvJmaoapsRe4+NW3trGdYqa2IOT2wx0MDQyn5BWpuG4sl9RWbG
        qx7CMUZuHBg/IuEzj7tbNzKIr7DmXi4s0EXXp7vdfWut3cTvbkOLFuEXgF3hb8Z4
        5N653r6kvkil6m6jteqR3+sFntrRXlNKqUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7swJR9In-e3N for <linux-ide@vger.kernel.org>;
        Mon, 20 Dec 2021 20:54:24 -0800 (PST)
Received: from [10.225.163.32] (unknown [10.225.163.32])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JJ3yl3b5vz1RtVG;
        Mon, 20 Dec 2021 20:54:23 -0800 (PST)
Message-ID: <e81624de-95b5-f5ae-e0fb-9019f9fc3944@opensource.wdc.com>
Date:   Tue, 21 Dec 2021 13:54:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] libata: use min() to make code cleaner
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211220113358.472974-1-deng.changcheng@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211220113358.472974-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/20/21 20:33, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use min() in order to make code cleaner.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Applied to for-5.17. Thanks !


-- 
Damien Le Moal
Western Digital Research
