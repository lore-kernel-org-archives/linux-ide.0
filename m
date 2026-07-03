Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE40433E8C;
	Fri,  3 Jul 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059437; cv=none; b=XFDz0g/UY300uyZ0I74+ANRI1dmGAmSLOFHi3SbyPCMs8L5e0tjk3DrsR75mZWjmYJ2a7BnA1TgTa9tG3kZuuwR9qdI8Gx/TYttSzeJwmCgOufH3ZlwOS2kGlWdnKllTL7PWd9/iM9b9VagCxOaXPVR+YqsuGtWuY8eTmfQvYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059437; c=relaxed/simple;
	bh=fzU7NaBCFYE+w7b8CRtDuZJSMw/vmMLzdXUfuoEXoLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGnKpDSphl3RF76ZCNDVMblH8zEDC70qM3iApEFJoSi5upuo0nimjPkW0qTU7beulCAFsztlL1UczdTGDxdcafYec5whQjvcWGz5e8kU0VuO4LBg940QhB+zBRJO7cguAqOBMEbb+vBRAEaMSOo8v5RJGZnW+dGvvJU7CZ/HefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+86asXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+86asXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E701F00A3A;
	Fri,  3 Jul 2026 06:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059436;
	bh=j8OmxcaZ0ZIvk/P9CxZhxqMDRvidiI+u0Lrz90a8l2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M+86asXvidDdj5OtXBgytbE0/Iz7+qou1al9892Yr/DOxFDmX0HQJ+wcs4uVtqed3
	 lN1wgDgF3buC7uKYXuo0WRUXGqz3mR+nlgJH/GAEdMFY5zNkZuqDbxun670r6exusy
	 LsWwXvOOSKoLVcuTyEzlgodcvwcyr5/gkRYpJQm5M/nlRrkN0etACZ+eS8derOQCkH
	 qixdUdL67FAgXZCfZjGzvIvWal36ai4V7rSWagHSA4FqPeYxf93k2AbiDHHswt6S4m
	 WQP/ocnDiMxAY0l5KeMS9GIDYdx22WKYNfX/BJ9mO9hWQfqotoskkY6pVf20+sXFkf
	 DxCsb0O+zu/Tw==
Message-ID: <171fb5f2-a2c6-47d5-a350-87516d1a5fc4@kernel.org>
Date: Fri, 3 Jul 2026 15:17:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Karuna Ramkumar <rkaruna@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702020142.3399851-1-rkaruna@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702020142.3399851-1-rkaruna@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 11:01, Karuna Ramkumar wrote:
> The function ata_scsi_rbuf_fill() is used to copy the response of
> emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
> scatterlist.
> 
> Currently, sg_copy_from_buffer() is called with the size argument
> set to ATA_SCSI_RBUF_SIZE (2048 bytes). Since ata_scsi_rbuf is
> zeroed out before the simulation actor is invoked, copying the
> full buffer size causes the remainder of the SCSI command's
> transfer buffer (beyond the actual response length 'len') to be
> overwritten with zeroes. This clobbers any pre-existing sentinel
> values or data in the caller's buffer tail, even though the
> correct residual count is reported via scsi_set_resid().
> 
> Fix this by passing the actual response length 'len' as the copy
> size to sg_copy_from_buffer(), ensuring that the tail of the
> caller's buffer remains untouched. Also, add a defensive check
> to ensure that the actor does not return a length exceeding the
> static buffer capacity. If this occurs, trigger a WARN_ON(),
> fail the command with an aborted command error, and return
> immediately without copying any data.
> 
> The fix was tested by invoking an SCSI SG_IO INQUIRY on
> an ATA disk on vanilla build, and build with the fix. Confirmed
> that the input buffer's tail end remains unmodified with the fix.
> 
> Fixes: 5251ae224d8d ("ata: libata-scsi: Return residual for emulated SCSI commands")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Karuna Ramkumar <rkaruna@google.com>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
