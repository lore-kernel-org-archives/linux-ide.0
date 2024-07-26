Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4D17A592
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992414; cv=none; b=ObnXDLy21NwasPpBdtfDoRjSUEYPEmJOhq4iFe+UQXvFw1ubAj/wh+uzF1Z10iHOp9B74LsGscr8/7NgDsW8aYgsEwV4RX2vXAUpdRgKrcSiTuusiQz7Mjdd7GOiqOUS0P8u9ZuswwGPMDPu9ojUPPuBH1QTCBqktuScKcdyxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992414; c=relaxed/simple;
	bh=Pax58sW+jlhe+K8eoAdwtbMM/nmbiKJcvxiKArT8ACY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDTui5UOnIG6moWmhOiN1VkhPTSKXq02EoVUSKMa3QCXSATFjh25yiYBlIEw4F37KpHHOJPn8Dz0QVb8Ax9rMByDgAf1wIRD6uQfv+DDH9ZB8E1dXE7sBqh+HpmFo1kkjR51d171/SS6p488AZcxpNic4HAsqoqnRo1Svt9yTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOWK0DPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOWK0DPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C1C32782;
	Fri, 26 Jul 2024 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992414;
	bh=Pax58sW+jlhe+K8eoAdwtbMM/nmbiKJcvxiKArT8ACY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOWK0DPH6aZIAx3PCOJIRwWl/QfW9JUIlhaSUbwmFOMdOZQdu4AofY93SJQoOq7sR
	 NxTU+MlatlAdyi4efKLV1uFvkFuaRzJ1jcz4Iq/O4Kzgr2CfNRJQhy1hb3Wbw4/Tum
	 /flHy3xl5AOJN0YRWmRk6JRKpiTTzLm472IvmRYiu048rwlm03thP8IbmHSPHUiKjO
	 Fyz098GS4W+LhBc1Uux8jExhrQ8J0Vazn6QfudeAkd165dAITBIPTEGYcm/hXkl0Oc
	 +Qr7ndQNp5wkJvOmZWvbswfunAFtU6p8jMclE+1IEdhRGepiESTtBg2FiLFsYTcy+v
	 mG0RzK8+J5czA==
Date: Fri, 26 Jul 2024 13:13:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 09/11] ata: pata_cs5520: Rephrase file header comment
Message-ID: <ZqOE24W8gYx86ef7@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-10-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:52PM +0900, Damien Le Moal wrote:
> Remove the use of the term "blacklist". What the comment using that term
> refers to does not seem to exist at all anyway as the driver does not
> have such list but rather only a list of compatible controllers.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/pata_cs5520.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
> index 027cf67101ef..3163c8d9cef5 100644
> --- a/drivers/ata/pata_cs5520.c
> +++ b/drivers/ata/pata_cs5520.c
> @@ -8,9 +8,9 @@
>   *	PIO mode and smarter silicon.
>   *
>   *	The practical upshot of this is that we must always tune the
> - *	drive for the right PIO mode. We must also ignore all the blacklists
> - *	and the drive bus mastering DMA information. Also to confuse matters
> - *	further we can do DMA on PIO only drives.
> + *	drive for the right PIO mode and ignore the drive bus mastering DMA
> + *	information. Also to confuse matters further we can do DMA on PIO only
> + *	drives.
>   *
>   *	DMA on the 5510 also requires we disable_hlt() during DMA on early
>   *	revisions.
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
