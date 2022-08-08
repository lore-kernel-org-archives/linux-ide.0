Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E655C00140
	for <linux-ide@archiver.kernel.org>; Mon,  8 Aug 2022 15:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiHHPAu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiHHPAg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2022 11:00:36 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629EB7E2
        for <linux-ide@vger.kernel.org>; Mon,  8 Aug 2022 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659970834; x=1691506834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dWpdYZqudDgvmMuJiEXUtDU/7QHq5F7xyssCOzjahPU=;
  b=F5LPQq6V44QznJiXn2A7opGiqI+s4BKWcikxxhF+i4hyjpjIs7Li4VZM
   ZNeFO6tgv7yAn7k88/bYJhdaxu1PvENhuZpfw+I5CxiPszI9LasxVT6YN
   9czs4v7CeeoP/fzPEIfTvhMYjTlBjnxxhIdRMsDKpE0xP6SgGKXkROhVC
   62KenvHepRxRd3lv2p9CsfIU1tgbG4VpYwjAL+huxpAVcjwy2dbW9xsdb
   MtxE8dAcI8+6pR8vdA34epKnt+d7BxBnzv55F7vKAnwkAU8sLyuGoUu3Z
   UhRMKAw2EBdR2kKXNjDWb+MvQxZHB77xVbODSRoxOsUhXY7tdKQH0V3NT
   A==;
X-IronPort-AV: E=Sophos;i="5.93,222,1654531200"; 
   d="scan'208";a="312427347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2022 23:00:33 +0800
IronPort-SDR: Pn+XWhy4Yx+7+vLUvw+r3iWRmWIkU++Uz10xNHys8ZhaZ7Pdp1lVaBmhjvy0ZhD+i07TVupRmQ
 fc0vpITivTw74IYcHYGK9e37mf803ecdHott9lZI/P44g7WPnUfQsJhbfV32mbcjEDjffIoRt5
 L4XFuWWHUVX1MstjzCtph8LVhHSnnFVhBXRsX7Kk2354jWSZ0uy82T7Hb1gQph5eltLfTg6Cgf
 WnTHoEHZWosk3Wdwb6IwcIyp7LwEeMQpRgEl0fQ/WrX1nYWLSYBnLelZE77V0Y5k/JyRq6VPKG
 o9Qv4IO/ZHwxTzLnTQmPjkpq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 07:21:31 -0700
IronPort-SDR: AAyvSSx9nA0SPDgPXp+CF1GSPBaDK/8CpTlYU0div8y5XYC2eLHhrRSnu6s4frTd720YzvMm92
 AZpF+EdFK3sZQppR3FfCvGiFJHDxk1dSxX7Exrb13Jh4AJ2GItUPaZgv7HMDDirwnuCHuSFSI9
 A4yA7h8F6RAITYrGrm6Nx/3fFl73I1jtV+R1RmfpB3N2cZ+3WTL2xKUm1LDZQ8VuUuP64B+59C
 JsBgAnUsUASKdtC1zgMA0DwFOSQp10fbwPeHr5jiOe95RUBwhPlskJGQih+h82m9Y9lgghLbpY
 hmQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 08:00:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M1fX10kqcz1Rw4L
        for <linux-ide@vger.kernel.org>; Mon,  8 Aug 2022 08:00:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659970832; x=1662562833; bh=dWpdYZqudDgvmMuJiEXUtDU/7QHq5F7xyss
        COzjahPU=; b=Ijeg89YHTXel49uuubA/KrUoPyxSrVQzzvYOPhJpl/YB5YPTGHr
        +uJoTzaZjTFC0JKhCDD74aIqUg6Ocpxxh6xywVUFJMuDHfsytCvwLqnY4IAMov4b
        qq3QBiMl1kJNYq9BWa3gr2adNq/qCyl3swdERxemHMgrG2aqYffrnMHAJq2DBoWk
        fPnNNEHknjhlawpf9pX+fP2dvkoMtQFtRXqYmNsY7OClXvCis+zJRwZnmZgpUBOQ
        SmpuSmADP0bc0vEPXSgpch6axMUDDdZYWXJ+xXJgtObJRv0SHKqRZKHtIIFEQPsT
        apkFIRiDJTeIJuVoHd361MMv7wUZNnwBkmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ErtpSqTqA2pX for <linux-ide@vger.kernel.org>;
        Mon,  8 Aug 2022 08:00:32 -0700 (PDT)
Received: from [10.225.89.57] (gns5353.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M1fWz5ZRJz1RtVk;
        Mon,  8 Aug 2022 08:00:31 -0700 (PDT)
Message-ID: <88caafa2-6ede-0d8e-0449-72ca559201b7@opensource.wdc.com>
Date:   Mon, 8 Aug 2022 08:00:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3] libata: Print timeout value when internal command
 times out
Content-Language: en-US
To:     Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com
References: <20220804143519.12245-1-thenzl@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220804143519.12245-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/04 7:35, Tomas Henzl wrote:
> Print the timeout value may help in troubleshooting failures.

s/Print/Printing

> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>

You forgot to fix the patch title prefix. Please change it to "ata: libata-core:".

> ---
> V3: rewording subject and description, no functional change
> V2: timeout changed to unsigned int as in for-next
> 
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..0fc4782ef4f8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1578,8 +1578,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			else
>  				ata_qc_complete(qc);
>  
> -			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
> -				     command);
> +			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
> +				timeout, command);

Please keep the argument indentation to align with "(".

>  		}
>  
>  		spin_unlock_irqrestore(ap->lock, flags);
> 


-- 
Damien Le Moal
Western Digital Research
