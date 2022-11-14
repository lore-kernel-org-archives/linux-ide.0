Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0227AC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 14 Nov 2022 02:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiKNCLb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Nov 2022 21:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNCLa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2022 21:11:30 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF1E02D
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 18:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668391889; x=1699927889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USex+C7tX1Vz/eQ8QPdHAbxa4WTa8ACk7pHOeJ5Sdn0=;
  b=IQL5Ix9wSK/CA8o/1WfUff1BBcVu3sihFBMYnP3zqvh6Qe68KD0FQaMP
   xnTcHHOGbM5mXNXxZp6D/uqclhL6RUPgSKUwFvkk1Z87UwZLIceVq9YDU
   E7PJXE858sRiwRXTFjQjbYl6MZr5D+rrPjYJQANsKDo6HzfI28z/ZUQII
   EWTq0xjW+whNHAD0rniPw3HiGa7cKjJrjEWRbrHKxRUMFF3z2Cplkiths
   VubuuBf3GKoN9qXnyISy5wzuenS+L3lEd899tu/uRd1zuArFscl7nbyRA
   u9geZi7lxt5ZMBUZu+ZxFx+c1QV/KRcEI3bhFxw4bYGtgN4P+3YMRloLF
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="328279090"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 10:11:28 +0800
IronPort-SDR: pUwnQrueXS7M8U5qkl2SZ52Fc6hellhBgPqITA9Qd9ZDQTscWQKFF3FAe9cLqmbb/Nm55fQyRF
 ckfeoxzFVR6q1AyYU7K4SOeh6dn3Zk8aAYR+Hbtel75k5rqEP1/oBEhj5KcsfhFDsskIjxINfX
 NlInWKU1jQsGydJdzgunc4u6XI4bt4Ayl85v2kR7T2ftfp1zPALu+3yjyzRJ2xatTrIc9XWuqL
 P9cEXmiTqH4jAidf4qpyIwxl+FrnuHPxrbvFvty/Gd2cpQajqY5wT1Y04dw5JHPVim3Q4pWAH7
 +94=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 17:30:28 -0800
IronPort-SDR: r3m2/yCyzHptWeCqQPIJklULb7BgnI8yt4jOp+Nnp5M0hpvuHslEWoh6hXuqjuBOj0+cdurM1O
 uzZPnmgDnmZ66F8ziif5eo+yEjZb8TjyO/IeGR7xctngKzZttj+8J9lQgWW1yXm4QhaaX4T4fY
 vgASuHLNDui2fZj6Rk2DNGKB5mloGE45zbfnZi0WTcuHtu1qFyWx6f7D0WD6iEinGNyG5a0mM/
 lNE+w8sMS4iukduurSGjsI8BfR78dnbTj8WJU4sXk7D4avTiBWK8sHdDfHoVAUUIoUI6vnnQkQ
 Ezc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 18:11:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9XqN50FDz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2022 18:11:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668391888; x=1670983889; bh=USex+C7tX1Vz/eQ8QPdHAbxa4WTa8ACk7pH
        OeJ5Sdn0=; b=gUHUsA2Ovczx9Xz9L6587IINRh6j3/folbTqf8NaK7+1JLiLNRx
        lyQw7LYvIBzKtfcnvL4k1WU7W6kthrQafNDdpKIl0yF8FmtOfrn81GkQkG4LK0+o
        ILmhPuL4296prVycxlnuEPLNHq+60UYAtvuLBmoafuh3hyBH+XVIbY2EoHn0cbp/
        6/dYFyzuaf0jGXQWst2zokeQfUhmFtKwWFCtp/r/BfdtnmMWVW3mpmMkU/FLMeyI
        KkTW/Y6aeurkbso5J8qMQjiAzD35wfuegV89OT12i2Z0xbiKbSFZJOMruRawN5BK
        ph8xM7xjPsWKmU/5sRQ4oACx1QbRseDvRhw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vNdeTCH42GU8 for <linux-ide@vger.kernel.org>;
        Sun, 13 Nov 2022 18:11:28 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9XqM6Y9Tz1RvLy;
        Sun, 13 Nov 2022 18:11:27 -0800 (PST)
Message-ID: <d9f8025b-2058-5ca3-0353-5c8bf67ff3c0@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 11:11:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] ata: libata: only mark a single command as error
 during a NCQ error
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20221111110921.1273193-1-niklas.cassel@wdc.com>
 <20221111110921.1273193-2-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221111110921.1273193-2-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/22 20:09, Niklas Cassel wrote:
> A NCQ error means that the device has aborted a single NCQ command and
> halted further processing of queued commands.

Nit: To be strict with wording, this should say something like "an NCQ
command failure results in the device aborting the execution of all active
commands."

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
> This means that we will generate sense data for commands that really
> should not have any sense data set. Having sense data set might cause SCSI
> to finish these commands instead of retrying them.
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
> Fix this by clearing ATA_ERR and any error bits for all commands except
> the actual command that caused the NCQ error, since the error bits in the
> taskfile are not applicable to them.
> 
> Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field for NCQ commands")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-sata.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 283ce1ab29cf..6b2dcf3eb2fb 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1476,6 +1476,25 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
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

Before the continue, should we check that this qc tag is the one we got
from ata_eh_read_log_10h() ? We should at least warn if there is a mismatch.

> +
> +		/*
> +		 * For SATA, the STATUS and ERROR fields are shared for all NCQ
> +		 * commands that were completed with the same SDB FIS.
> +		 * Therefore, we have to clear the ATA_ERR bit for all QCs
> +		 * except the one that caused the NCQ error.
> +		 */
> +		qc->result_tf.status &= ~ATA_ERR;
> +		qc->result_tf.error = 0;
> +	}
> +
>  	ehc->i.err_mask &= ~AC_ERR_DEV;
>  }
>  EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);

-- 
Damien Le Moal
Western Digital Research

