Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D74C3DA7A
	for <linux-ide@archiver.kernel.org>; Mon,  2 Jan 2023 23:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjABXgr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Jan 2023 18:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjABXgr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jan 2023 18:36:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B84E385
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 15:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672702606; x=1704238606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wulzcQ+TvPmOXHbzTNAgLrZOMI8+oI1+KtOG1TSNV9g=;
  b=rKAedylBilGyXjoY3Y+97kS2IFbBmHmWYGS5m0u7tRp3Q/MVToX7Cs4v
   cmTSFhtTCMHF3CAiStzyGzuS/uMd+wmeaUfb2w+m6br+rvu8SZPE6aqqq
   pfHIsMsZZgNtVy38/Lkb+jrjNiuKvDOWM2CwWp+hiayL8HVpj+ifzLy8M
   BoX/Dx0nUunmbTbFy5PduazAsTWEY0j7+9gsGY8OsYwP66BdtF6BnToTP
   oT8KOKl9VXRTrmCYprmczGEA0awfIDiEJymx43xlNZRT7EN/gzJR9Bbdh
   mW8+W1v2xjO7KLl6HVgQT/UBdLEYuhmbeIGYD7tsfpc9/CvynPSvpaEoL
   w==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219780401"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 07:36:44 +0800
IronPort-SDR: Fff7itc92RELeztcpJo8NEs2SYOe0ljUHFFh9UAPh4CyOIM7DxUfsVPZAd3KuM5o3Jl2CaiYz2
 6ciglvxAwLPp3ye5yQ7rIElBwqryTPCkzkA+pOlSCEt4Tea8xR6NhdE1PSxIg4w48iX6twdtIO
 ZHO5pQ+dxybOfErwGm0vUhkUOm41aeFc38ETkl7icA4MPHqdvHYmvTBrDmMmQCz0RZj6ctLY2d
 S2J8Cg1xXOFjzI/J8s3VZ7hfAiJc8K93dSdCKWDLQ9Z4UkG4Gjr0J+6q1CcRa4H5f5zViBKhMQ
 QX4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 14:48:57 -0800
IronPort-SDR: cWL3Q8fV8q2+ND1/lJqwHz5hnP+4cctcKP5usEY2fIWYbOn3PVjCh6du8ZIhtte/QKu9zpoVk5
 9mIjjKi6rQ9rBjENSXpPwfD3UHDoLk9SVUleQ24s3mRn4wMF3XJB2PZ22VPeQ3MW40Pf+SXsWF
 x4cvbUk1wz6x4ikyzYfHpMA71KTFaARn+yoZC0cH3soXxJkTmRB3n2Pjvj6LwUJE6X37LHr/32
 WCRUbYPDD/1eDzB9pxsp+DoBFr+Y6nXvLPqiJsXnK125DQZ8yMFgXkchtZmfuVln2PANyB79Of
 iYk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 15:36:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmC1k5wxCz1RwqL
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 15:36:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672702602; x=1675294603; bh=wulzcQ+TvPmOXHbzTNAgLrZOMI8+oI1+KtO
        G1TSNV9g=; b=UC/JbcjOE3kP076MKGmcHc3tF98oiTOyT8KF6P/np1tybqTdb2G
        GLILKArwWA2/tdP463ZAAtLNdV3Pu8ETmRo90YziWj/lpoLPjQsiSDWfo6hgYIGN
        ehhMl4tlC0096wCbainDCbSWUixEhZxclbW1WDhAMOlcnD8mHC/jv7VTj7Alhybg
        mwDj7mOQESr0z0C/yMVyuEpagxxQvXKYLO+Tm+uef4/9jVtze8MS/y2N+qiIHrME
        uiGICstC63YSCPG7r9o4PdOq3ACNKkrmMW6U0nCrl75c/mIIDQAgWzJlTYgCn6OJ
        QsvoM+0q+wBwEVJUjz93riWaT2VT4DAz2pg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aB9b-AUkAxQS for <linux-ide@vger.kernel.org>;
        Mon,  2 Jan 2023 15:36:42 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmC1j1r7jz1RvLy;
        Mon,  2 Jan 2023 15:36:41 -0800 (PST)
Message-ID: <3bdf330c-8930-af2b-ef95-f0c10ae75814@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 08:36:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215153749.1947570-1-haowenchao@huawei.com>
Content-Language: en-US
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

Missing a Signed-off-by tag... Please resend with one.

> ---
> v3:
> - Start with a "/*" empty line for multi-line comments.
> - Correct the commit subject
> 
> v2:
> - Check ap->ops->error_handler without taking the spin lock
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
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

