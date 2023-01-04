Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0377C4708D
	for <linux-ide@archiver.kernel.org>; Wed,  4 Jan 2023 04:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjADE3l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Jan 2023 23:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjADE3k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2023 23:29:40 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A976F594
        for <linux-ide@vger.kernel.org>; Tue,  3 Jan 2023 20:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672806578; x=1704342578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/GIX1fsparj1ywUJMI5wuRyFdxWCwM+xwwoKR6B0A4c=;
  b=mXU+W7f6+jHmmxy44TTgx7dlE/9gfftZ4/nS/JGTvSNNiG7lP57Rzd0p
   yckH/DVggwMwDR1ShxZO6G7eBt1yFCi5dptwCi6IKT/DWl8MK8rFW0rDO
   tqcny2vRK3YBKU8FJxiaG8UtJ3x2cSpQXjO+VXznOfIZ2zy5sN7lg40V8
   jB6ZacUVvjt9uXxiVh34GUgnOBxVcHrUy02zkF0tsgQjyOgFYV0c1mcCJ
   vFh6JckEQ+zSYlfzGYibhP9vh1/hBpbZb8w3fQ7lKN0iTWXpcAGoxgxuB
   cSbbSPKBY72J89cTSvcX/2AH2EDzfyNNAwa1MvSMzTlwC9b1YpDeebBCd
   g==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665417600"; 
   d="scan'208";a="225035663"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2023 12:29:37 +0800
IronPort-SDR: 2LAY/cvUa7UyqOslALDbHk0lTJYzauf9Fhtlj0yI9aLQ+E7TBTfcm7STUKmYzHaxEec5mCnwSO
 Lc2FtY3bk3GKSAHiM0s8KVHiobROFp0do0hQnLAApghflwf6lmecn/cWJ9Ks9HmLock/GIUk+b
 j43gtRsmh6fdm8O++CnBxv8GpIJFxf+n4s9hBpw1wYQLJ3OtgrotsNQZmyLO4e36OaRq99SdDa
 84FB4Pi/JlzYtQSKmN0EV1AunLVOSfZg/FLOBV6JQpTH9kIAq1q4GalMs3dACKnznHEhdf5DhP
 r3E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 19:41:50 -0800
IronPort-SDR: 9cvoBB7u00qjsRy+QGWUJ6S//GMxxNASai2Gs63hbEoT8ZybAhvmrIpqFQFXbS6tkdwy4C0VHb
 lfkbTPmo4nKos2HilXOXcE6n7JR4wiAIQeHrvjzUxvW748eHL86j+w4BkZCTPy6QxdL+YJL7CH
 GxU7LMRxaVrrFMDYQTb+q3dhr8zPE1MKXU3wGZfIXIbv8mKJtr05DI4BzVT3EWo/nnIdh6rd80
 Ho0OXWtUDszA1ArC8v3D8EEcUPx0iYC/OEZZR3nK8wf5QTWB+YsxlwhD/bZ9BDtZJ/NdD+KiZO
 ubo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 20:29:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmxTF0FGPz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  3 Jan 2023 20:29:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672806576; x=1675398577; bh=/GIX1fsparj1ywUJMI5wuRyFdxWCwM+xwwo
        KR6B0A4c=; b=LwQuzwD5rCg1yjL3ZoS5goZYaIXKbojIchx03hDQp+Dr+Y4mi00
        P0vBWsrm1Bkql0WYIbhEuM1FETronr2TyeTBXG+e6fWAcvFkzKZ4R0KwevoeAeh5
        o/YjgxaX3TXTZ7PnLAxT8IchonCaMRDHMx2CKdXNSRWMC44MY0J8gH0zlBPFEwkP
        dGxm/bKyZJJalZUhBYrcdh9rVGl0zYlSi4pQ6f+k2ePqHUZ4xH5ppzPu0AUz0g6T
        Y0NCGafkx0VVZwPEAq1Sf+FMwbCiAS3Z0/ca4jU/pJeRBiGwov3Xath6HE1IsvCh
        8Dz3oKIhXeaDDKFMfu7RauSzRGXITwukdlg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hUOhO5S5h0gG for <linux-ide@vger.kernel.org>;
        Tue,  3 Jan 2023 20:29:36 -0800 (PST)
Received: from [10.225.163.5] (unknown [10.225.163.5])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmxTC1hdYz1RvLy;
        Tue,  3 Jan 2023 20:29:35 -0800 (PST)
Message-ID: <02d139a3-1886-dd6e-8812-dac4d292f064@opensource.wdc.com>
Date:   Wed, 4 Jan 2023 13:29:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215153749.1947570-1-haowenchao@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221215153749.1947570-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/16/22 00:37, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL just return. This patch also
> fixes some comment style issue.
> 
> ---
> v3:
> - Start with a "/*" empty line for multi-line comments.
> - Correct the commit subject
> 
> v2:
> - Check ap->ops->error_handler without taking the spin lock
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>

Ah, so your SoB is here. Wrong patch format. The changelog needs to go
right below the "---" below here and your SoB above it. You added a "---"
above, which tells git that this is the end of the commit message and so
your SoB below it is ignored. I fixed that up when applying to for-6.3,
together with Niklas suggested edits. In the future, please format your
patches correctly.

> ---
>  drivers/ata/libata-eh.c | 101 +++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..56820b8e953a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -565,13 +565,19 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  {
>  	int i;
>  	unsigned long flags;
> +	struct scsi_cmnd *scmd, *tmp;
> +	int nr_timedout = 0;
>  
>  	/* make sure sff pio task is not running */
>  	ata_sff_flush_pio_task(ap);
>  
> +	if (!ap->ops->error_handler)
> +		return;
> +
>  	/* synchronize with host lock and sort out timeouts */
>  
> -	/* For new EH, all qcs are finished in one of three ways -
> +	/*
> +	 * For new EH, all qcs are finished in one of three ways -
>  	 * normal completion, error completion, and SCSI timeout.
>  	 * Both completions can race against SCSI timeout.  When normal
>  	 * completion wins, the qc never reaches EH.  When error
> @@ -584,62 +590,59 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	 * timed out iff its associated qc is active and not failed.
>  	 */
>  	spin_lock_irqsave(ap->lock, flags);
> -	if (ap->ops->error_handler) {
> -		struct scsi_cmnd *scmd, *tmp;
> -		int nr_timedout = 0;
> -
> -		/* This must occur under the ap->lock as we don't want
> -		   a polled recovery to race the real interrupt handler
> -
> -		   The lost_interrupt handler checks for any completed but
> -		   non-notified command and completes much like an IRQ handler.
>  
> -		   We then fall into the error recovery code which will treat
> -		   this as if normal completion won the race */
> -
> -		if (ap->ops->lost_interrupt)
> -			ap->ops->lost_interrupt(ap);
> +	/*
> +	 * This must occur under the ap->lock as we don't want
> +	 * a polled recovery to race the real interrupt handler
> +	 *
> +	 * The lost_interrupt handler checks for any completed but
> +	 * non-notified command and completes much like an IRQ handler.
> +	 *
> +	 * We then fall into the error recovery code which will treat
> +	 * this as if normal completion won the race
> +	 */
> +	if (ap->ops->lost_interrupt)
> +		ap->ops->lost_interrupt(ap);
>  
> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> -			struct ata_queued_cmd *qc;
> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> +		struct ata_queued_cmd *qc;
>  
> -			ata_qc_for_each_raw(ap, qc, i) {
> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
> -				    qc->scsicmd == scmd)
> -					break;
> -			}
> +		ata_qc_for_each_raw(ap, qc, i) {
> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> +			    qc->scsicmd == scmd)
> +				break;
> +		}
>  
> -			if (i < ATA_MAX_QUEUE) {
> -				/* the scmd has an associated qc */
> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> -					/* which hasn't failed yet, timeout */
> -					qc->err_mask |= AC_ERR_TIMEOUT;
> -					qc->flags |= ATA_QCFLAG_FAILED;
> -					nr_timedout++;
> -				}
> -			} else {
> -				/* Normal completion occurred after
> -				 * SCSI timeout but before this point.
> -				 * Successfully complete it.
> -				 */
> -				scmd->retries = scmd->allowed;
> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> +		if (i < ATA_MAX_QUEUE) {
> +			/* the scmd has an associated qc */
> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> +				/* which hasn't failed yet, timeout */
> +				qc->err_mask |= AC_ERR_TIMEOUT;
> +				qc->flags |= ATA_QCFLAG_FAILED;
> +				nr_timedout++;
>  			}
> +		} else {
> +			/* Normal completion occurred after
> +			 * SCSI timeout but before this point.
> +			 * Successfully complete it.
> +			 */
> +			scmd->retries = scmd->allowed;
> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>  		}
> +	}
>  
> -		/* If we have timed out qcs.  They belong to EH from
> -		 * this point but the state of the controller is
> -		 * unknown.  Freeze the port to make sure the IRQ
> -		 * handler doesn't diddle with those qcs.  This must
> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
> -		 */
> -		if (nr_timedout)
> -			__ata_port_freeze(ap);
> -
> +	/*
> +	 * If we have timed out qcs.  They belong to EH from
> +	 * this point but the state of the controller is
> +	 * unknown.  Freeze the port to make sure the IRQ
> +	 * handler doesn't diddle with those qcs.  This must
> +	 * be done atomically w.r.t. setting QCFLAG_FAILED.
> +	 */
> +	if (nr_timedout)
> +		__ata_port_freeze(ap);
>  
> -		/* initialize eh_tries */
> -		ap->eh_tries = ATA_EH_MAX_TRIES;
> -	}
> +	/* initialize eh_tries */
> +	ap->eh_tries = ATA_EH_MAX_TRIES;
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
>  }

-- 
Damien Le Moal
Western Digital Research

