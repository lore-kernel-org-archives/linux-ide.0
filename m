Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67043563E1;
	Mon, 13 Jul 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927927; cv=none; b=ttZTD/e4gHjbOWL0LFj+/Ui3L3fy2mnb3zCXTj2BzYn+iw5k8RBBQnCbSGIcOtaCWK0QZ0hxlYwiAGgXPnY+VnebL6EYvd2s5ejuUZQrogN1U/vWbrLARaSgo+brQ560LLG0UxowZ7iQiAC8CR9neMIgsy/hLFy9nn4O0rTvASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927927; c=relaxed/simple;
	bh=m6tlIpafs8Mf8ENv0RMDlKenvpTnGqBw8Vi39+uLNj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiSDQbxJ0JuaIjHQewggrRtuSp7ViyOm/Qvb6z7QKm7T/dKcRWX1nQpYKy9QCEX0HvishXhYiFSWrCU6XICqzxqwMijlel3qSX1hhUYha5uu3S9NmHGIkAH9UX+DmKYBjeUmFpT7ojiWNvDLDdRq8Zw6QeWD29nzh480wyAszwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+joVUaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+joVUaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3395B1F000E9;
	Mon, 13 Jul 2026 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927926;
	bh=BkY5lSVXjKDxAV/Jehljo9HiRmKqwBoqY7UbTx+m0WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V+joVUaDKUrH4FXhyVlBpKk97dXoiqBMu8YqfFMSQB7AHBgkmkOSiNLB78E/FNmEC
	 nHi3FWdTMJJPszbkGlmIzW5MKuc8oJ5x1Q0Ymyb5TfreZgXDJxkyyHdvDgTbc5WyPS
	 Uhs14CnFVaCHKZVhTZ4C7LM7GRkevA957ZBGusQyCHYdRIIOTiM5wkrs/FDmqlaRVO
	 THbU2hDVzfYh26uEzKDXD+oh3YdhoynD59UrBZ/iWx/M/FHReGJPnVf749zo3nZl1l
	 RosBPeXbUuQ+hv+ASYFm+0+BGtn4WsrpC07xxWz8DiGhdAIYgntC71dlmrxcawh2CO
	 rWXIuurSQs+pw==
Message-ID: <7c69e55c-1877-4bdd-aa18-9154acada32f@kernel.org>
Date: Mon, 13 Jul 2026 16:31:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/4] ata: sata_dwc_460ex: cleanups
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Jeff Garzik <jgarzik@redhat.com>,
 Mark Miesfeld <mmiesfeld@appliedmicro.com>,
 Rupjyoti Sarmah <rsarmah@amcc.com>,
 Prodyut Hazarika <phazarika@appliedmicro.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260712213728.824420-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260712213728.824420-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 06:37, Rosen Penev wrote:
> Fix various issues flagged by Sashiko against the original submission of this driver.
> 
> v4: remove interrupt fix
> v3: Shrink series to Fixes on the initial commit.
> v2: sashiko fixes.
> 
> Rosen Penev (4):
>   ata: sata_dwc_460ex: use platform_get_irq()
>   ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
>     registered
>   ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending
>     interrupts
>   ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion
>     bit-scanning
> 
>  drivers/ata/sata_dwc_460ex.c | 38 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)

I applied this to for-7.2-fixes, but I reversed the first 2 patches.
Thanks!

(if you have time, please send further cleanups to address the other issues
that sashiko signaled).


-- 
Damien Le Moal
Western Digital Research
