Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DE15B125;
	Mon, 19 Aug 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065315; cv=none; b=mByPiBsiaPrlYwI6lkySSFluNjbSmPuDnIeUWhBE7qiUeA1WZeUlf27nrdhZwHIkD5r7Pyr/qgFj4zO6j1FFXBVmXKnuToW6hArTS1khf33o3LIszw4PQDcpPvYwSwA0TqqJFRQZRlWLGK/rgNVxOBD5RqCmfGIi+niGJx0lFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065315; c=relaxed/simple;
	bh=RKjobX7+cX15lxVhF/xFB6okKKom6P4UVqu82yq3zr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJKN4qMfOjvh+FDhqmAISuJ6oZOPDtb6AxlumPHfRgU4DMDTFZCoZHTd3q/wcvOvleRf8utOhwj5h6nx6qy//NK1FydrBXuXZ65BDtjk6JOTmk/hhCDKVF7jnBWrtGZKfGI1qHp6dIMboxZdTwGwQ0zWkZkDhUXeGGZrVgXURGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+uG3ule; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+uG3ule"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A0C32782;
	Mon, 19 Aug 2024 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724065315;
	bh=RKjobX7+cX15lxVhF/xFB6okKKom6P4UVqu82yq3zr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+uG3uleWXjeur9lX+9XwXwxgSHehaXUwK+vFzMctal4HzHStOMls2jxPEzk0Wjfo
	 Bu/h9UZC0pCV6jNe5Bg1rHMUO8gI/M/5Sbt2+B40OcTSu8N5wzCYg1qQKGFtqvVkUq
	 QmWI8CXEu/xi4bPLtz2PRSnXB7VeXD/RsJ8A7ohg03DWcpMEDbEFNquRY2BcrxfGEe
	 TbLGt2xeH91Lv1R73kGteOt/rnUy6Etc2p/1FmRHxdxp/pFcM/4sryD40sFRa5Kqr9
	 flmplLT4BzvhyUrZQbpk4w94J1Bapnux9sHIHeqxHWXP045OHXcRJcDhPmjoSFIx41
	 qFykD+krjPjtg==
Message-ID: <737ad178-1198-4103-b1ee-46a67ecf12e4@kernel.org>
Date: Mon, 19 Aug 2024 20:01:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ata: pata_macio: Use WARN instead of BUG
To: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-ppc@kolla.no,
 vidra@ufal.mff.cuni.cz
References: <20240819101913.489513-1-mpe@ellerman.id.au>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240819101913.489513-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 19:19, Michael Ellerman wrote:
> The overflow/underflow conditions in pata_macio_qc_prep() should never
> happen. But if they do there's no need to kill the system entirely, a
> WARN and failing the IO request should be sufficient and might allow the
> system to keep running.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/ata/pata_macio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Not sure if AC_ERR_OTHER is the right error code to use?

Given that this would trigger if the command split has is buggy, I think that
AC_ERR_SYSTEM would be better. Can you resend with the change and no "RFC" ?

> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index eaffa510de49..552e3ac0d391 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -554,7 +554,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
>  
>  		while (sg_len) {
>  			/* table overflow should never happen */
> -			BUG_ON (pi++ >= MAX_DCMDS);
> +			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
> +				return AC_ERR_OTHER;
>  
>  			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
>  			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
> @@ -566,11 +567,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
>  			addr += len;
>  			sg_len -= len;
>  			++table;
> +			++pi;
>  		}
>  	}
>  
>  	/* Should never happen according to Tejun */
> -	BUG_ON(!pi);
> +	if (WARN_ON_ONCE(!pi))
> +		return AC_ERR_OTHER;
>  
>  	/* Convert the last command to an input/output */
>  	table--;

-- 
Damien Le Moal
Western Digital Research

