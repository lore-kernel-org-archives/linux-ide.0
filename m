Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F51367
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105674; cv=none; b=QQZScpp17IrfLI06W7bPeGpiTvH1H4qxc7f8+7WQStu8bhui/1OqjdzBGMLI+2JfeMq1cKVHmxG2oezEEMI5fqyvfaEnMbv+wiuFslM2DT+3ND9DJaKPqsAv43wBJ4ToeYtp+xLZxAOOX0YLTfmbpwtZtbYFJJ1CNj4nU/jr+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105674; c=relaxed/simple;
	bh=bS96Kx03+1VodOEGuq3Xb6I2xub4tXykptaCMrE7MkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGja57ImwrCR1z0mXA9jcbnZ0lZOEOmpLj5o49Zmtlva4d/12Iisq2LvcZqsfSr+Kq1ioU80izfIM6ONb0APMfhNkZvhQko/r7/mjCNOJRUD6C45hp3BL8fF+8zanwICBAwEUndKlwcUt7iirCvCsr1LGvwfH+D7qDXXuprEB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0C4FVfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0C4FVfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3155BC4CED1;
	Fri, 21 Feb 2025 02:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740105674;
	bh=bS96Kx03+1VodOEGuq3Xb6I2xub4tXykptaCMrE7MkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0C4FVfEdvw52YnmS6XGKWbfzsxMR4pjrdh46ibNuekMkwoQROSSvBz8o3fUj+Z5o
	 RXvGfihjFc9onhq05aVNNkq+1xki2ku5BB9rSZg3U0G7GTtkQXd703mxUknp6lgDiT
	 VhKL6f/ZRJKWHxmqvUZlYlDphLC55wE3pxe7W8BpsJ8Qo9ju+gKG1xD10/Vs3+7nNy
	 VZzxQFmts0anmr3cpiOcz+og4j+Nl7bRbCVBcUn89f6BzpmHHvJUSPaFO7K2vSeJxO
	 yUnxHUkYOLryP2bX7mcYRh4VIlahvrcJRgxBW78qyBLE6TLqsetU6jWOEjQtvweO8y
	 XmAJPRMPN0iDg==
Message-ID: <2604c41f-8f93-44fe-96db-f965071e5296@kernel.org>
Date: Fri, 21 Feb 2025 11:41:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Do not use ATAPI DMA for a device limited
 to PIO mode
To: Niklas Cassel <cassel@kernel.org>
Cc: Philip Pemberton <lists@philpem.me.uk>, linux-ide@vger.kernel.org
References: <20250221015422.20687-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250221015422.20687-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:54, Niklas Cassel wrote:
> atapi_eh_request_sense() currently uses ATAPI DMA if the SATA controller
> has ATA_FLAG_PIO_DMA (PIO cmds via DMA) set.
> 
> However, ATA_FLAG_PIO_DMA is a flag that can be set by a low-level driver
> on a port at initialization time, before any devices are scanned.
> 
> If a controller detects a connected device that only supports PIO, we set
> the flag ATA_DFLAG_PIO.
> 
> Modify atapi_eh_request_sense() to not use ATAPI DMA if the connected
> device only supports PIO.
> 
> Reported-by: Philip Pemberton <lists@philpem.me.uk>
> Closes: https://lore.kernel.org/linux-ide/c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
