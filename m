Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740828;
	b=rYuz6i8lVG2a3AlpfRIgQeEfMvf5preLaC8KXW/e1ObDarcRFkiBvKr6LdMeLfnzpCqZ
	 vhou0MSZVN8CL/M2A68D5EvmWsAoGen3rPVWkXD6g/NLdFSpd3KwBwOZ4Rq0j+MspOqGu
	 wOFL1Grt4r0aB5kLNxd0PaTCYbiLvpMfbDr+gflY4eI5PQth/cFT2PHtZNIxQFAYEtZtP
	 nqZ5ApQ0+ABhcL6OyTKjqoQto2OhU56i5l7lcO0BLeGl8EZKeECp65Nq44rRm2xYAZjdP
	 KFjDWSYQGgorvlj1JC5pNsfUTDX3+tcOJyQWk0eoYzavcZuKcjCEoyBKERckMVKnSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740828;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=D2hNKScl49Xls9Nm7v0ACs2301WttSNa3LVqAIIntio=;
	b=VaDCIy4uKrksWPo9d/z30CDVVyfeYtL1y4+uXAPnBEJO+Y9gSXyR6AZAneI1Ke28to46
	 baPfY+9Iy5gkLbnkny4alZQcxpe/ct/xNt0OwWNVNP+b3dlvIWpDjyXN7ueNCggLyoX1Y
	 GaWj9vP3T9Gje0jrkD49MJWqbNPmOmwc5/KtBLkbtADb/SqMNTGj8K82qhvISpTgAdJrf
	 VObJ/pBomsG3kQPAY3QLBvyDRDND3fhtEalMCcLy7EkKVeKS08KMWrdlX1xLwycl2l6lK
	 EoLJ3jC8SKh4daRQIuHSMU6+l4UvzQG4f4Z+hSvU25YyyDg3pBcNX5n2uAqQwZe2yvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vip0umon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D1606A32F
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vip0umon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F71F00A1A;
	Tue,  3 Nov 2026 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740828;
	bh=D2hNKScl49Xls9Nm7v0ACs2301WttSNa3LVqAIIntio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vip0umonXKR0wt5ln5wMSSafW+2U6sopmeScoP0ys42kodW0muUHPwlwcyplGTu0X
	 Ek7lRm2ezcVDHpM3u4S6P/u+BbkJx3vnrACUswuHuNxmfg6FvwmpHaLnM92HQfkJxH
	 BDShZ4GI2W6W3ek7Wf10+59CnrtqPGEiX5wp7gqrgho44C2UCZe6Hfes8BB+cWOx+d
	 jEeArszOdmK0h1XYVuOhpsEaff3Mn4J6Sk+KAAmEiNVzxeFBDG8y3Cx9QTbxSwbpCU
	 AzKZ2j2/RDKQxGAXl9V5oFh0LNwSippxvcTfVlN2LZAFTl6lnc3GwFl4xT0HYqOYUY
	 t1xvv0/RJzvQg==
Message-ID: <57395e07-2f16-4f69-a7c0-1ef0e2f9afa4@kernel.org>
Date: Wed, 4 Nov 2026 06:20:25 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ata: libata-scsi: fix MODE SELECT handling of data
 after the mode page
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-11-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> ata_scsi_mode_select_xlat() only supports one mode page per MODE SELECT
> command, and rejects a parameter list with data after the mode page with
> INVALID FIELD IN PARAMETER LIST. However:
> 
> - It does not set the field pointer, so the sense data reports 0xffff as
>   the FIELD POINTER.
> 
> - It only checks for data after the mode page after the mode page
>   handler has been called. ata_mselect_control_ata_feature() has then
>   already updated the CDL enabled flag of the device, even though the
>   command is rejected and the CDL setting of the device is not changed.
> 
> - For the control mode page, ata_mselect_control_spg0() does not need an
>   ATA command, so the check is skipped, and the data after the mode page
>   is silently ignored.
> 
> Check for data after the mode page before calling the mode page
> handlers, and set the FIELD POINTER to the first byte after the mode
> page, i.e. to the first byte of the next mode page.
> 
> The reason why only one mode page per command is supported is that a
> MODE SELECT command is translated into at most one ATA command, so
> update the comment accordingly.
> 
> Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
