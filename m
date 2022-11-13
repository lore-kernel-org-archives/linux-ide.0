Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74BC433FE
	for <linux-ide@archiver.kernel.org>; Sun, 13 Nov 2022 23:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiKMX31 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Nov 2022 18:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMX30 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2022 18:29:26 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F46261
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 15:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668382165; x=1699918165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ls9hQt+lxjdR81yzo7Tym71L3DnGEQ+GNDfIHWzpK8=;
  b=Mi6D8UL7gz1h2mry0yIz309101WuQg+s1UgGOgmyMHzmneKrbdf72UA8
   LGB1I5vuQu8KXHkpIACxiwsheLDkWHFe8nRJXp/5iE4ZyEpcYzgLsN+Bo
   7UihRYP4q9/5HUJF8NGf646s2intyXXYnwMkONjJbxQkZdNQK9ZCmWcqq
   d5bVph278oLM/9OUnBNdfyN9PS1u3PY/h+SgVnzv/AgThCapLB8n55acK
   +Q6xpuM2mCn+xRfmfgM7DUy9tpDGSp86pqjblkCEYicJFd21KmYI2Tczr
   KzWDMQN++33mbsEKATfscbxXfnZb0WxMdx6ipf9IGzBBHsFl4V5zddf3U
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="214441176"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 07:29:24 +0800
IronPort-SDR: WGYhYHZ2Wit021bQSvLyvDgvK50IUMjSKCw0XeCxXZz/qoGqA4cNxKIyrmIxRDCWPUpoySMto4
 JayM+WVUqZyFujD734sM9Yi4WrvQsjzJ2cVZTIcD4p66LUZArAfi1Ydpvbc27FU/wF6OEjJCYu
 Yq7WjUuWpVxeAcd4camrIfaZ/wEoJhoHRlHaFgJQrjJvqqgWgLoXzfRplSWRiNa+OfWydTLvec
 buVWaeQ5uNrLV6eUCCio11BWWQ2CCRYcNnQWN0Fm9PwhNCEDZ59Je5yjJYQRWC0trZxc5QV9sH
 /M0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 14:42:38 -0800
IronPort-SDR: 5Cory515QGPhK7g90XEX3Zi3hFJZybXB/0jnYcpzu0Uoyc5duM+lqwqhpgseOcSq+k5zXMrq0C
 9KMz9u8MsRkInSbTiYChUZMsTAbwMpS9gsdN90uw/IlNvgZfsuLYo9Y1+s9d1yvLEJ2xKiJYHX
 Aq5vVHl7cPh0LLNQ279tmhXeHLP4+HrUJsMdYnvWp3UjgkNiQdVv/VfR8sfFwqmylVERzDUYhi
 zq2hBHrg2effGmVaKPA0MU1yKUCjCYJ1hZunHVNOyBBPdKUXIzx3+pP7Oun+rn3elqxxTxa4XJ
 db4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 15:29:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9TDN3Hfrz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 15:29:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668382164; x=1670974165; bh=7ls9hQt+lxjdR81yzo7Tym71L3DnGEQ+GND
        fIHWzpK8=; b=OHBdV7iS+fhHcMiLou7YXBhriHt70OV0cj3B8N9HaNJ+Yvy9Inr
        l5uQXP1qOfR12B7pZYv2z4pTZDBqAXtauF7+5/HzggsJVRDuAtMfIovIP9ieY3pS
        zRrMFIJYdXnPBHX8RCyBIPkItOM6aBM86rLG5Xa06SrL/ScUKMoM+XOrGzVS3hZh
        ZqlQG3420c/bPbYm1674ZoKGEgBg+QZPUu6iBDQ+hsp6x049h0E6M7o/G0RwT0NO
        ERCAAGLwLczmubsqSsNE8Gjrxc4cw8Zll3+8Njm08yxjFvXro2qDXHA22cBR5nLk
        Zv+U4No5H5udGpjnIQuaSFx6gRnG9hMpoPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vTJhZGl90yc4 for <linux-ide@vger.kernel.org>;
        Sun, 13 Nov 2022 15:29:24 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9TDM2v6fz1RvLy;
        Sun, 13 Nov 2022 15:29:23 -0800 (PST)
Message-ID: <ab4d249a-a99f-3d3f-6823-240f8aca2da8@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 08:29:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [patch 02/10] ata: ahci: Remove linux/msi.h include
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.374088146@linutronix.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221113202428.374088146@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/14/22 05:33, Thomas Gleixner wrote:
> Nothing in this file needs anything from linux/msi.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ata/ahci.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -26,7 +26,6 @@
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/gfp.h>
> -#include <linux/msi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>
> 

Applied to ata tree for-6.2 branch. Thanks !

-- 
Damien Le Moal
Western Digital Research

