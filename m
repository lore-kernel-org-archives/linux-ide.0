From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: ata_dev_init_params() fixes
Date: Mon, 27 Mar 2006 17:49:16 +0900
Message-ID: <4427A70C.6040101@gmail.com>
References: <4427A4B6.4090504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:21661 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbWC0ItW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 03:49:22 -0500
Received: by pproxy.gmail.com with SMTP id w49so1219532pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 00:49:21 -0800 (PST)
In-Reply-To: <4427A4B6.4090504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> ata_dev_init_params() fixes:
> - Get the "heads" and "sectors" parameters from caller instead of implicitly from dev->id[].
> - Return AC_ERR_INVALID instead of 0 if an invalid parameter is found
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Signed-off-by: Tejun Heo <htejun@gmail.com>

Thanks.

-- 
tejun
