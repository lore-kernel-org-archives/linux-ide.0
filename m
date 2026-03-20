Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0901372B5B
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005900; cv=none; b=CKV5Aprt0ZBlIhclBQNhbrv9bJfBxop/JZbahDGvoHpKSnygjq/IZGDxnFo5kw/wVLhY3MENdDJN6TDHhqelq1hDfN0XK2+qLNH309Dmbpdm4GNYUwykkJKFUsJiIRGVDAKv57nFYFtVzT3q+UqlHuZDpovxKaKCDCp5571H93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005900; c=relaxed/simple;
	bh=OsCwAy8MSXTkLmp/ktMVDKdDbqYHEIzt/8RHxzRbDJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvv6ImFuqZ5rmcksF572trpDEIF4OVcv70xmPGWxRaHgug3XKXF9SdB3NwVKZMjS1vGKFvIQNlZHp1usrZU/0d8Klpy/AC+R+4N3v/v+sBO+Za193IctLY2VZZr5XMYqHNPYTZlHq8V5h8EcL5noWqHEi6wnZt4jq736OkW4ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEVIPSkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEVIPSkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11BBC4CEF7;
	Fri, 20 Mar 2026 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774005900;
	bh=OsCwAy8MSXTkLmp/ktMVDKdDbqYHEIzt/8RHxzRbDJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UEVIPSkS+wpuiOU7ABcbftWVWfnKDDu5qJ2zgrKAnycXvj41eFvulLze1E6V6W5u4
	 P2Zru6KItvg+02XGmBkwN/NpPLp4tEnOKYFPj+2NcIdHYersOCd5QRikRFyLnTtYgJ
	 NN83f0NbalvskjjUywGw075mZS3dW3FaIxmBSaZo/iEnn05WcBJnfSyZBBpqnfUv2m
	 GD2ox3eHcpajvwwOKz/L+iff9nH6jXwYEK8oOr1F79hhraoud4dwHsD+/15Mkb9aOB
	 gb4ZbU0Of8b4WMpFqWZu50ujEyBEvMN4gQ6Aou8YSqXNdMJM0vVuKSMqWCTXk9yZpV
	 DOHSUDo6o6e3w==
Message-ID: <3d762a01-4bfb-4e23-bffd-38e70018119e@kernel.org>
Date: Fri, 20 Mar 2026 20:24:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: refactor ata_scsiop_maint_in()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260320105950.286341-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260320105950.286341-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 19:59, Niklas Cassel wrote:
> ata_scsiop_maint_in() is currently quite confusing to read, because it
> currently only implements support for the service action REPORT SUPPORTED
> OPERATION CODES.
> 
> Thus, when this function is checking for "invalid command format", it is
> not very clear if it is an invalid command format for the MAINTENANCE IN
> command itself, or an invalid command format for the (currently one and
> only) service action/subcommand implemented for this command.
> 
> Move the service action to a separate function, so it is more clear that
> the "invalid command format" check is actually specific for the REPORT
> SUPPORTED OPERATION CODES service action.
> 
> This also makes it easier and less confusing to add support for additional
> service actions in the future.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
