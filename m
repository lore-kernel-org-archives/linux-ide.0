Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651817D2
	for <linux-ide@vger.kernel.org>; Mon,  4 Aug 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754266036; cv=none; b=d7OT9mwL+e5+avp9+bpAlgpwvY6a+0eO34PjkFoAmkpNx4gRnqCCr3KI3DC72bss6Ct4I2RvdcZ7QPDEFe0nh8QafT6Bvt7PflZ49TmMFNmrmwp/YK7AG5sDc21OQK/tK02FkET1nWlKAAmCl01kej/OHxOC68AyhotzeZOYyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754266036; c=relaxed/simple;
	bh=HU7qrwAhpaf4DmPrsZFCQKGZPQhc7h+U4eOeE/Lf+U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZsV5uxRaUoVnZAJlqjP1QzUUvPWkO+HXBUTQm+ssizCAoFWvlgx8f6Vy4LPVUvScSO1rVA86chkAOLjUG31blQ/VcO0bpBJ3SQOOkqQAKpB1EZK22sVpZ3r6ylZI7/W2Ip7CeR5VklwxkObuXq73RNrhxuF0FWTGizujPiv5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFdynBbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFdynBbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7833C4CEF0;
	Mon,  4 Aug 2025 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754266033;
	bh=HU7qrwAhpaf4DmPrsZFCQKGZPQhc7h+U4eOeE/Lf+U4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hFdynBbXKKdgxyWfsoGTpx3DehC7ednPWdQMB5Jv+iAIvilPXe85l6TtrdL21wK1/
	 IX2XY1rGQFe/PQi+oOqSqKVhHDI6gwUDxrg5HhGTah4pYpUo97WmyjTW/4E7vZQZZ+
	 m7vcMcN1Sol7VSk1jZnVZiShGWF0EJQ2ZaCMDHqnIs5MmzDvSgG451qM5yLWfnaRRh
	 ZeSC3Fya20EfqC5oXHshzc4LPfWde4/b762VS8EjuYJ5LVp0JctnbkEIYu71fHnJU0
	 X6e4vaL6fjWE15fB5x9vMzUG/SutKg985xPjbLD/A8nAsPAB4y5ttNuRdD/zCtsAe1
	 M1NwsQCJncsOw==
Message-ID: <7c7e3d9a-ecf6-4bcf-b9d8-6db699b53e0a@kernel.org>
Date: Mon, 4 Aug 2025 09:04:40 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: Return aborted command when missing
 sense and result TF
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
 Brandon Schwartz <Brandon.Schwartz@wdc.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-3-dlemoal@kernel.org> <aI0jVxj7GoHMkncK@google.com>
 <822c1251-d3fe-4dfe-ba26-63128d9ea3f1@kernel.org>
 <aI5PpnFUDXfMnvbC@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aI5PpnFUDXfMnvbC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/25 2:49 AM, Igor Pylypiv wrote:
>>> There is a redundant check in ata_gen_ata_sense(). qc->err_mask (is_error) is
>>> already checked in ata_scsi_qc_complete() before it calls ata_gen_ata_sense().
>>>  
>>> 	if (qc->err_mask ||
>>> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>>
>>> The function will be much cleaner once we remove this check. 
>>
>> Yep, we can remove the err_mask check.
>>
> 
> To clarify, I mean that both conditions can be removed, not just the err_mask
> check. In the current code the err_mask check always evaluates to true so
> the right part of the OR expression is skipped due to lazy evaluation.

Yes, we can simplify this.

-- 
Damien Le Moal
Western Digital Research
