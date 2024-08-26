Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1363C
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645436; cv=none; b=RjYFaEBEltApl3I7zdtXHIRmM8cOWNTrzVox99l5KMwj7Jlh/hYHp07nyqhd9cQA9DjhrT2wgZyuQg6qcF+eBAENzZ/QEHuWXeCb7sxY6b35T0Xch4NfUy5Mvy12dqbMRHW8+6lPDHmuvexOBqmxeFPd0wviqhG11lLz5nQ7JJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645436; c=relaxed/simple;
	bh=D/cwwAsBSJc8Z279aleCfL1a3e2llSKcjhtP38J62EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuWaNZDRKXAyzFfNw/8iFikOW9RjhsVV+YVumP7bnaswq6Kvg6U7bgQ8iquIdAiFlVQ3Z8o2RIq5Pn1qH7WmPc/mxU+3DXQ2Z/TrETtjOcx/CjoOiyscjmMlmpnS/wJaIbPGrdmyWfNBJnExLyAZENu60ftTPSNCXmODuYbcegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQizxhId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQizxhId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BAEC4AF0E;
	Mon, 26 Aug 2024 04:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645435;
	bh=D/cwwAsBSJc8Z279aleCfL1a3e2llSKcjhtP38J62EA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vQizxhIdzSAc70WyTI86TllfLy2PlDokOB1P2uuycdMcFxUo/dRHYf4GkucMH3JV8
	 Ui0kHO+ffgzIDwnYoOn1YVethIYGepAdnTGYkJgA4VAvuFONYyswkvXGFHtPKf2iXr
	 pBnoUggcDRtaTHli+IUxmccr7OGz8YFBKVdUxqyVLZUKA920x+D200ugNbdrrUFf4W
	 BzBfFZbPltNVl/MjFUyB8wmioUWfGD0FfqZgbKwK6fraJT88puXobdNqkZVp6Fn7IQ
	 Acpyr2CL7UUE3s68d1oFcT9umhgjPTUs8JqClo1dBr5lRz2KSs/gTzTgOHUEtIy9/8
	 jUB9sXPYS2dYg==
Message-ID: <51e7d53e-2a15-4401-96f1-bb6300bff535@kernel.org>
Date: Mon, 26 Aug 2024 13:10:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ata: libata: Remove obsoleted declaration for
 ata_sff_irq_clear
To: Gaosheng Cui <cuigaosheng1@huawei.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org
References: <20240824121449.2522086-1-cuigaosheng1@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240824121449.2522086-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/24 9:14 PM, Gaosheng Cui wrote:
> The ata_sff_irq_clear() have been removed since
> commit 37f65b8bc262 ("libata-sff: ata_sff_irq_clear() is BMDMA
> specific"), and now it is useless, so remove it.

Same comment as previous patch, the writing could be better. Furthermore, I
think the 2 patches should be squashed since they are both modifying the same
file. E.g., something like this would be better:

ata: libata: Remove obsolete functions declaration

The function ata_schedule_scsi_eh() was removed with commit f8bbfc247efb
("[PATCH] SCSI: make scsi_implement_eh() generic API for SCSI transports"). And
the function ata_sff_irq_clear() was removed with commit 37f65b8bc262
("libata-sff: ata_sff_irq_clear() is BMDMA specific").

Remove the now useless declarations of these functions in drivers/ata/libata.h.

And a single patch to remove both declarations. Can you resend with this change
please ?


> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  include/linux/libata.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 0279c0a6302f..6552e90753ae 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -2006,7 +2006,6 @@ extern unsigned int ata_sff_data_xfer(struct ata_queued_cmd *qc,
>  extern unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc,
>  			unsigned char *buf, unsigned int buflen, int rw);
>  extern void ata_sff_irq_on(struct ata_port *ap);
> -extern void ata_sff_irq_clear(struct ata_port *ap);
>  extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  			    u8 status, int in_wq);
>  extern void ata_sff_queue_work(struct work_struct *work);

-- 
Damien Le Moal
Western Digital Research

