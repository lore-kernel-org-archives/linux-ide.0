Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3EC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 14 Nov 2022 02:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiKNCPQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Nov 2022 21:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiKNCPP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2022 21:15:15 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536FDDC
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668392114; x=1699928114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9PdPOceuYdr9VeZLiYR9kMrlnMvXlzHBJAXu6QVrkA8=;
  b=E1cbD53pLbQmnai8SVsyrfLNDkw/3Z4s00AOUwvM4/W9KUFbK2jg8Ve1
   Njc5n4ECrsiyL+WkzYPbADZT9pqFC66kuRu7bf6PRtOjUmK3VslnLfAHx
   zym49OUiqqKFTKTUHPw6RWSnxRcfcXq/zeizuSAdhmB4EHD+w6eazovkI
   I8heXb2e0xJBrkfM5QTeBAVNvWGRu7dnGRDOeR7SS7NiZKZig2uN+Qyql
   Hmcvu8rLRoPrToddYkEwgyUhxW/EXMCFcQ+ElJIsIa4jEVxr3mFrNVnvC
   ZCu3TwBWurvvE4de5+3Oz37zoC6utkL543GDyIw6j108B3CWmSNE0Cwr8
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="320522436"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 10:15:13 +0800
IronPort-SDR: 18R203K6AJwL0BvRuWpHm+2rDI3WlBUCZohE/msyKVqcM+NZ0+Kw79fZCc3adDRdYJjAHOD03E
 B5179L2YwApJnYW9OH5nn218yKMybeMB/DjVDoO0ylZNKrgTTU1fZ4pDcdEb2V8uqTfWDCKFeL
 aHS2QQab/TABPC1mFpOH0PrvUxa1+OFLe737xkqZXAj7AuLrgbUwpl+MDcdLFYLNPxEqo2qa2P
 Io9+POGH8726Y1THYbNcni9oGa5Rgzq00eaPDZluDrhpFbyBE7lD9EogGC4oXDw7UUZzvYTI+i
 Aeo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 17:34:12 -0800
IronPort-SDR: 8+3Ju2y6Wcr6tAtiroxJ2U+Vh8N11G74VnTZS7YNMTKJmtS/KILjM3eAbhSvi6dsr+cbd1SCBD
 tsVxON3Jr0OvRKOtkuk52gOjn+yahm2nu5eRptNmRk2wPfB1fey9Ud31ACfanOiapJhy+MkB0S
 ISWWj6EeF2tHaQYNOaw5uzsGavGNCcevV9XdVVL2PwmDWSyGMOcTVUyk5jnk9NTlCJCxceazqP
 kOgny7gybnvYRw1rJCX/DtpuWWwgpv3kNQTbbB83kXTF7LB+7OdSlqs4vWZ+Czxoq7xwfCRVj/
 A5s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 18:15:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9Xvj3GTtz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 18:15:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668392113; x=1670984114; bh=9PdPOceuYdr9VeZLiYR9kMrlnMvXlzHBJAX
        u6QVrkA8=; b=F+ZIPCrhOrlEuqWoqDh+yn3cB+4jztb1jKwLpPkfSwyTGTW4UEH
        iEsBJETMuC+XuR5Flqn5ephFqTNK3fEa+4Hc86QvVo2l+X7Lwki6PZT1H8N3M+bx
        JMTw3uKSnFNYl5MtAkGQ98lS72SfdUn3C+Di49aTLiZu7GJxszwEN3Y9ym9nKWO5
        rRaQgaq6ACFoJb0s/EKKdUxZSwFXeZmduu49LEys0YF91T4dpLp3RYj9l6MURAbz
        MQ9ep+B/ALYoluoBMSiZbfdUII4+ZbmCN2sil+ILX8OS8DxlC+iA2SPNP2Fmia9f
        iWSRfyFZhh5kZLRGK/CTaXhaN8odxFlXHCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ld-AlW5IXQwE for <linux-ide@vger.kernel.org>;
        Sun, 13 Nov 2022 18:15:13 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9Xvh5C1Fz1RvLy;
        Sun, 13 Nov 2022 18:15:12 -0800 (PST)
Message-ID: <cdef7948-590e-0630-5487-42ba01ada3c3@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 11:15:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] ata: libata: skip error analysis for commands that
 are not errors
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20221111110921.1273193-1-niklas.cassel@wdc.com>
 <20221111110921.1273193-3-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221111110921.1273193-3-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/22 20:09, Niklas Cassel wrote:
> A NCQ error means that the device has aborted a single NCQ command and
> halted further processing of queued commands.

...means that the device has aborted processing of all active commands.

> To get the single NCQ command that caused the NCQ error, host software has
> to read the NCQ error log, which also takes the device out of error state.
> 
> ata_eh_link_autopsy() starts off by calling ata_eh_analyze_ncq_error() to
> read the NCQ error log, to find the offending command that caused the NCQ
> error. ata_eh_analyze_ncq_error() marks the offending command by setting
> qc->err_mask to AC_ERR_NCQ.
> 
> ata_eh_link_autopsy() then continues with further analysis for all
> commands owned by libata EH.
> 
> However, once we have found the offending command, we know that all other
> commands cannot be an error. (Theoretically a command could have timed out
> just before the NCQ error happened (so EH was scheduled but did not yet
> run), such command will have AC_ERR_TIMEOUT set in qc->err_mask.)
> 
> Therefore, after finding the offending command, we know that we can simply
> skip the per command analysis for all commands that have not been marked
> as error at this point, since we know that they have to be retried anyway.
> 
> Do this by changing ata_eh_analyze_ncq_error() to mark all non-failed
> commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autopsy()
> to skip commands marked as ATA_QCFLAG_RETRY.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Flag ATA_QCFLAG_FAILED is kept since it means that the command is owned
> by libata EH. A failed command will always have qc->err_mask set.
> Perhaps flag ATA_QCFLAG_FAILED should be renamed to something like
> ATA_QCFLAG_OWNED_BY_EH to further clarify this meaning, and that the flag
> does not necessarily mean that it is an error.
> 
>  drivers/ata/libata-eh.c   | 1 +
>  drivers/ata/libata-sata.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index bde15f855f70..34303ce67c14 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1955,6 +1955,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  
>  	ata_qc_for_each_raw(ap, qc, tag) {
>  		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
> +		    qc->flags & ATA_QCFLAG_RETRY ||
>  		    ata_dev_phys_link(qc->dev) != link)
>  			continue;
>  
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 6b2dcf3eb2fb..18ef14e749a0 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1493,6 +1493,14 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  		 */
>  		qc->result_tf.status &= ~ATA_ERR;
>  		qc->result_tf.error = 0;
> +
> +		/*
> +		 * If we get a NCQ error, that means that a single command was
> +		 * aborted. All other failed commands for our link should be
> +		 * retried and has no business of going though further scrutiny
> +		 * by ata_eh_link_autopsy().
> +		 */
> +		qc->flags |= ATA_QCFLAG_RETRY;
>  	}
>  
>  	ehc->i.err_mask &= ~AC_ERR_DEV;

I think this patch should be squashed with the previous one. That will
really correctly fix the EH handling of NCQ errors.

-- 
Damien Le Moal
Western Digital Research

