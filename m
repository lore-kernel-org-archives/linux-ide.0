Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105E18FDD5
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792379; cv=none; b=gno9ivYPAuCI+gGq+enAzy157B+XMfoCHM8jXaTtmuYZH55jWVIK6Sc1yPMcMN7NMAeLNj9Z82eC7FzXf/EXgrLht1e/NE6wbWUUiD1VIgrAc1CbFor8A1ar9uA6iTn7InWlSS+G7k0usiZFgqXbM34BJm/knFPpgwdDdB/AklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792379; c=relaxed/simple;
	bh=EuO74YTpxKt3REwxFUwSRlV1f7CBHqkOHmO/Pi2Zjsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YegfyVjnolXlsoDlvK6fZaPF7xK62J/E6KOXJkEmAMRp3xA6REGGJNH5yhT4vegJwtp9x+AYG+oEE/aGBdnFCG+psM3hyJeMAiwmhx6D4itcEf4Sqquo1dEwc2bt6ku1LAw954atIsu2DzDncn8j7SvYyTCMYrb3Sgxj60TcagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/pEjuos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/pEjuos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B8C4CEE2;
	Wed, 16 Apr 2025 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744792378;
	bh=EuO74YTpxKt3REwxFUwSRlV1f7CBHqkOHmO/Pi2Zjsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/pEjuoszrFhaGRmYN9UxyFZY3hirCJSJk58XqKhkTKB9eVaj8tyI4O2amM0aQafk
	 fps+hNp17lmeGpYhAIVuTotQ4bavFaECy4GDC2Kg28fv0cQ7NTrN1ImmZgfbMk7tPW
	 RQ32kHIsgohf1dkWpUbN3Sp/Sf4DC6wOFYywYQH4GMOaSTQrIEPgAvflaOSA9U9B/2
	 Vee149iqONbkbB9mDwsPwMuFydoqoEzMYafKktHe0pU+xIbKLkm4tRcJaOXZgyfNY5
	 B509+POoEexz0kRJ36dwxCjqDDnmq5sPbjyrWnyG97LoKSLCOIJQJJnjUsKuAZ8/QF
	 +gzltjMmzTLQw==
Message-ID: <ed8aca96-896a-48fa-9cf2-b0a50f3e4ef6@kernel.org>
Date: Wed, 16 Apr 2025 17:32:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ata: libata-sata: Use BIT() macro
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-8-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250415073013.414987-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 4:30 PM, Niklas Cassel wrote:
> The BIT() macro is commonly used in the kernel.
> Make use of it when converting a tag, fetched from the Successful NCQ
> Commands log or the NCQ Command Error log, to a bit field.
> This makes the code easier to read.
> 
> Suggested-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Patch 2 changed sense_valid from u64 to u32. So I think this patch must be
squashed into patch 2 as otherwise, the first use of sense_valid doing:

	if (!(sense_valid & (1ULL << tag))) {

looks very wrong to me. Even though in practice it is not going to be an issue.

> ---
>  drivers/ata/libata-sata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 076953d18db9..4e3034af285e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1545,7 +1545,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  		 * If the command does not have any sense data, clear ATA_SENSE.
>  		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
>  		 */
> -		if (!(sense_valid & (1ULL << tag))) {
> +		if (!(sense_valid & BIT(tag))) {
>  			qc->result_tf.status &= ~ATA_SENSE;
>  			continue;
>  		}
> @@ -1634,7 +1634,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  		return;
>  	}
>  
> -	if (!(link->sactive & (1 << tag))) {
> +	if (!(link->sactive & BIT(tag))) {
>  		ata_link_err(link, "log page 10h reported inactive tag %d\n",
>  			     tag);
>  		return;


-- 
Damien Le Moal
Western Digital Research
