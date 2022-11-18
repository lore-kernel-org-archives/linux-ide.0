Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ADC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 18 Nov 2022 04:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiKREk1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiKREk0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Nov 2022 23:40:26 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7627E2E9EF
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2022 20:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668746421; x=1700282421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2pu9mTNtqS7BaZQU/weoBxXDfppc6yRaH+ejt0i2jo=;
  b=H/eMLnkHne+0KV0ZgHIHaEKPoZAJ02YNBT64SV00/TAXHMtYD50wCrp/
   oysaB692qcJAoZm5m5b09i/Pfu5xmAy52vIeu7/Zrafl+kMYXvfpTxJnV
   utpR6ElrTgtBDcn+brVHpTi7Dq1mi4GjA48fjEPSMuAViGp0XBiHbokG/
   VZkQO8r/PnuUB7jDXHihesPcYqzJpJ2FjFWMyUIYSHuk091UPwuausQeo
   ZJt2J/+Mregu7xs3xmCckfv8X6QSEFewokrjr2WeTxrsDxOw72ejRAZ6E
   EKKHzXnVsWk9JBHYLH1DO8ozKdyrN4SlpmOBvZMxERP5cxFQUkKKjrgc5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="320923826"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 12:40:21 +0800
IronPort-SDR: X3fl74qdES+IQvDIpUOKNMfM+I7jrTTRTeaRozxHJGrjOR+Kj8vRaw1ishd8cyFdDeTh5eeMsm
 XUxa7fK+AphVhcKOzJhiM+3RJ5MlCrDXXHbgiJV9yUixocusG/IdA5yN2NuefHLW/SEFUyI9q5
 kIIIhqkcJdxKXdu1xSTK0WflTiY6J/unZSXNLKo47b+4aov+u/HEGqucBAFgKCThEjWvZT/zZ5
 YjXPbc7cAUJJObSt3InVBTZrmoq+7mNp+wOVcyLZX8LP2isyDNcfRyeBNDo9uA7vRzSt6OhFlu
 gjc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 19:53:30 -0800
IronPort-SDR: +2h2Swy5sC8E1gRpClZLxDmAf/yhQx/Z0rH5/tuiSeXDy2svYXoddv8RQDa2DnJRwX/N0PBxpM
 c9Bcwuv/mPvYJgUqyWtlByKZnzcPRmlkEQvkjGLA/KtkC78GJ+BEtrYWsukr2jFKcb1X046rIq
 2Wie9bva+ZmiZFYF9KNUB0iDzKU0Bm7tKrHXS8LU38XuzMwepSJX+lDRyBlSnZPs44XeY6BkT1
 BMeIAk2wpqaOiMDJtBde6HENLapFenT6zZSlaWbqoS3Ucv+c8iBzu1P3751OQ0lyEHf2WtySXb
 ZfI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 20:40:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4ND3xJ2cmLz1RvTr
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2022 20:40:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668746419; x=1671338420; bh=Q2pu9mTNtqS7BaZQU/weoBxXDfppc6yRaH+
        ejt0i2jo=; b=kczr7iIyGUZLYDVUS6vxMMjAsbErrbV5Uh+zt43j2PXQLnzBywO
        Royt8w8jIAcPoPtiKEtN7zK0c9jaSglZ0IBcabSzeMhvWUFUvXV0szxIhz8+AeRN
        XjLG+DI8Ctp5GCfyA1dppSlhW90mv44JyE3iKfynh2NMjK0MggwINoxiQm/Mj7Z6
        w3YIyup6h/9UBL3r+BAzBNMwBLL2kgw3Y4Kp1ROB0tvQoQ4tHKYqY1UY6jbW5XFF
        Jv3XEuv7PB0BdasHyPeDfFRdSxBCA5tZ5TgPuLdj9snhuyrdhzTCvQ3zj7VqaHrA
        TmEWD91YaYzFYqzHTbWvY9fBrKT3IHkqLcQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VtC-6JZrCRXB for <linux-ide@vger.kernel.org>;
        Thu, 17 Nov 2022 20:40:19 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4ND3xH2r1jz1RvLy;
        Thu, 17 Nov 2022 20:40:19 -0800 (PST)
Message-ID: <3f2f4518-1cfa-8872-3f5c-049a2c92aa99@opensource.wdc.com>
Date:   Fri, 18 Nov 2022 13:40:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] ata: libata: fix commands incorrectly not getting
 retried during NCQ error
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20221114172200.1475962-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221114172200.1475962-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/15/22 02:21, Niklas Cassel wrote:
> A NCQ error means that the device has aborted processing of all active
> commands.
> To get the single NCQ command that caused the NCQ error, host software has
> to read the NCQ error log, which also takes the device out of error state.
> 
> When the device encounters a NCQ error, we receive an error interrupt from
> the HBA, and call ata_do_link_abort() to mark all outstanding commands on
> the link as ATA_QCFLAG_FAILED (which means that these commands are owned
> by libata EH), and then call ata_qc_complete() on them.
> 
> ata_qc_complete() will call fill_result_tf() for all commands marked as
> ATA_QCFLAG_FAILED.
> 
> The taskfile is simply the latest status/error as seen from the device's
> perspective. The taskfile will have ATA_ERR set in the status field and
> ATA_ABORTED set in the error field.
> 
> When we fill the current taskfile values for all outstanding commands,
> that means that qc->result_tf will have ATA_ERR set for all commands
> owned by libata EH.
> 
> When ata_eh_link_autopsy() later analyzes all commands owned by libata EH,
> it will call ata_eh_analyze_tf(), which will check if qc->result_tf has
> ATA_ERR set, if it does, it will set qc->err_mask (which marks the command
> as an error).
> 
> When ata_eh_finish() later calls __ata_qc_complete() on all commands owned
> by libata EH, it will call qc->complete_fn() (ata_scsi_qc_complete()),
> ata_scsi_qc_complete() will call ata_gen_ata_sense() to generate sense
> data if qc->err_mask is set.
> 
> This means that we will generate sense data for commands that should not
> have any sense data set. Having sense data set for the non-failed commands
> will cause SCSI to finish these commands instead of retrying them.
> 
> While this incorrect behavior has existed for a long time, this first
> became a problem once we started reading the correct taskfile register in
> commit 4ba09d202657 ("ata: libahci: read correct status and error field
> for NCQ commands").
> 
> Before this commit, NCQ commands would read the taskfile values received
> from the last non-NCQ command completion, which most likely did not have
> ATA_ERR set, since the last non-NCQ command was most likely not an error.
> 
> Fix this by changing ata_eh_analyze_ncq_error() to mark all non-failed
> commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autopsy()
> to skip commands marked as ATA_QCFLAG_RETRY.
> 
> While at it, make sure that we clear ATA_ERR and any error bits for all
> commands except the actual command that caused the NCQ error, so that no
> other libata code will be able to misinterpret these commands as errors.
> 
> Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field for NCQ commands")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.1-fixes. Thanks !

> ---
> Changes since v1:
> -Squashed patch 1/2 with 2/2.
> 
>  drivers/ata/libata-eh.c   |  1 +
>  drivers/ata/libata-sata.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
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
> index 283ce1ab29cf..18ef14e749a0 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1476,6 +1476,33 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  		}
>  	}
>  
> +	ata_qc_for_each_raw(ap, qc, tag) {
> +		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
> +		    ata_dev_phys_link(qc->dev) != link)
> +			continue;
> +
> +		/* Skip the single QC which caused the NCQ error. */
> +		if (qc->err_mask)
> +			continue;
> +
> +		/*
> +		 * For SATA, the STATUS and ERROR fields are shared for all NCQ
> +		 * commands that were completed with the same SDB FIS.
> +		 * Therefore, we have to clear the ATA_ERR bit for all QCs
> +		 * except the one that caused the NCQ error.
> +		 */
> +		qc->result_tf.status &= ~ATA_ERR;
> +		qc->result_tf.error = 0;
> +
> +		/*
> +		 * If we get a NCQ error, that means that a single command was
> +		 * aborted. All other failed commands for our link should be
> +		 * retried and has no business of going though further scrutiny
> +		 * by ata_eh_link_autopsy().
> +		 */
> +		qc->flags |= ATA_QCFLAG_RETRY;
> +	}
> +
>  	ehc->i.err_mask &= ~AC_ERR_DEV;
>  }
>  EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);

-- 
Damien Le Moal
Western Digital Research

