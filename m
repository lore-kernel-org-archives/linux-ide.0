Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A025C6EE;
	Sun, 12 Apr 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775977606; cv=none; b=N5WBYUhpjivZmZUkWRc2x/3wluDDnASKa33kXtENZ6xtkZbN36ckEA0NUdI1FuaRYzAYj3tLfyp6tLWZYkuMDtJa70GAplBxZWU567075KLGpP+Zq8zi2VAJkeFls3Nf1Md2Gp6WimiS4lmvbRPN0hZmUDHS6mIA5L7r4oxRM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775977606; c=relaxed/simple;
	bh=piPTtxWdeHkJmiAvnn6mW8xtz1+41ziC+xy5YtOdpL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFvl6d8V96dUf7p0rA+5QvWTo5OYsdJ5ePNAn5C8vlbNYx0mp8K3QRVw2s6xhRauqbdigzZy148YwCc7uTmmCHxPbyroQ/zXTFvYJHyX66QjXBjKEm5Id7bbyEQvTGfWFyF4QiGNPhbmyqhZS2RHWj+HydspDkktOgxd2SjmMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqTxhxnS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqTxhxnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB355C19424;
	Sun, 12 Apr 2026 07:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775977605;
	bh=piPTtxWdeHkJmiAvnn6mW8xtz1+41ziC+xy5YtOdpL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PqTxhxnSaQLrHAmX4m+LNNO6BhoeuPn122bz0wVco+RX+y+zzUcXVLFyQ449VVL9B
	 7oJ2QqzBMdfd9oPP95bN9EepLLhblIOoQDc1m9+PLS/NomFSd8ONPe3ccdJiOiN+9m
	 zK/DNF/+9g/klmLHfyZ37tomnuXQvZ21AJ6LQABRsizoYypvAuaKBQl8rJxaOWcGaA
	 PDPj3+ziJ3M31IDTiCOjH3HJHWkXEgae+RY2xhyuR0UEDrh8b1ukdHxvlRt+1Owinc
	 7GVYOqA4qFgvn7JMo5OJ/nnFEVlYb40M5UXv2VVkbvQtZ28Z1VgBWTybu/Q603ZD1a
	 1un+qd+2q7bdA==
Message-ID: <d1f74993-5f7a-4496-be7f-797652477fa6@kernel.org>
Date: Sun, 12 Apr 2026 09:06:42 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix requeue of deferred ATA
 PASS-THROUGH commands
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, Xingui Yang <yangxingui@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260410231519.951971-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260410231519.951971-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/26 01:15, Igor Pylypiv wrote:
> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
> during resets or NCQ failures. This deferral logic completed commands
> with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.
> 
> However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
> ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
> to zero. This causes the mid-layer to fail the command immediately
> instead of retrying, even though the command was never actually issued
> to the hardware.
> 
> Switch to DID_REQUEUE to ensure these commands are inserted back into
> the request queue regardless of retry limits.

I really thought that DID_SOFT_ERROR was not decrementing the retry counter.
Checking the code again, I was wrong. Good catch !

> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
