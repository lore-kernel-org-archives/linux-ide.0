Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5A200118;
	Mon,  3 Feb 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578088; cv=none; b=cKZlMXocog21Vcw/+eM0sfK0IQop6BhIq7bOOvPSi2mcukFuR4Q+0dWudjIsMZQ4m1ZjYtmz5HBWfeSZccwVjMm9MKRvA4VbfkUXYbYw2za+zXnpPDlauaE9ylzk8CtgJhg6OnZFdY9Kx14gRi+Duvu4YTg6a0nZpYXAVD1PQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578088; c=relaxed/simple;
	bh=3nFSoXSK35WH5TxsQqsFvjdhDUgnorrr3kBfTg4G0t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8Bl3s/saVvm7xGy11+KsEh0uNohvBFx/VXKe8lU4jaUHq9EYQY9BPfcuYkZonrjwmt+N4DM9L3++sAoKoypz2zjJXut+lrkHms515A9MHSfO7+H2NgflT5ae1FLAyOV38OZ0y6nZIWXneZwNwhbkW67zzz9io/DXNpTC3Zy7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6M1bi9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6M1bi9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C6AC4CED2;
	Mon,  3 Feb 2025 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738578088;
	bh=3nFSoXSK35WH5TxsQqsFvjdhDUgnorrr3kBfTg4G0t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O6M1bi9AGzwEMUdCUYPJ0GFSvkSYf39U5PH0Y7nkOVRkRtplXDRFcLoukVzdqeXTq
	 wdGNob7Ocv2JXSR2N15pOVmm8XyDgjyE5hwn/7x0EwBSl/tahooOFbyYiXWiBURzJB
	 550kSvhHYweqvBkHTAfCk0XqosQwYuMp0bqHF/LdMzDlvv5Mw0oeNAGQmhOnw+ATRQ
	 ZB7gNJ6iL/U4LT0659lzVNHnMVpA6Ob9itnf7QolN4WRwuDOpUHKJh91Xm0jpYSAPP
	 MJCjSrCKo3ipxmkxMTzUc4vtMaEY55QugorpThSX5lbmfX7PHgq0xEGj1wCoL2mBzQ
	 IRToz9zDcpywQ==
Message-ID: <1a31140b-21fc-4e1f-b79e-72ae79f60cf3@kernel.org>
Date: Mon, 3 Feb 2025 19:20:23 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ata: libata-core: Add 'external' to the libata.force
 kernel parameter
To: Niklas Cassel <cassel@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Christian Heusel <christian@heusel.eu>, linux-doc@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20250130133544.219297-3-cassel@kernel.org>
 <20250130133544.219297-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250130133544.219297-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/25 10:35 PM, Niklas Cassel wrote:
> Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
> changed so that LPM is not enabled on external ports (hotplug-capable or
> eSATA ports).
> 
> This is because hotplug and LPM are mutually exclusive, see 7.3.1 Hot Plug
> Removal Detection and Power Management Interaction in AHCI 1.3.1.
> 
> This does require that firmware has set the appropate bits (HPCP or ESP)
> in PxCMD (which is a per port register in the AHCI controller).
> 
> If the firmware has failed to mark a port as hotplug-capable or eSATA in
> PxCMD, then there is currently not much a user can do.
> 
> If LPM is enabled on the port, hotplug insertions and removals will not be
> detected on that port.
> 
> In order to allow a user to fix up broken firmware, add 'external' to the
> libata.force kernel parameter.
> 
> libata.force can be specified either on the kernel command line, or as a
> kernel module parameter.
> 
> For more information, see Documentation/admin-guide/kernel-parameters.txt.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
