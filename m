Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466428E0F
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340450; cv=none; b=MXcWrg5fua1YeUVniD7NIjdcZs5t5MSCt+hecKAnoEFTdIUqhdjRX+zfzqtkwkWv4w/5nI8PwHPIRsehZjEBLU8/upk1BkTIwu1hoT57l7LCGbOiPxIVEDBjIibt9WTn637DzU6XpKvDAfU74b00X6l+Q3F/iSgyS4Dyc9E67vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340450; c=relaxed/simple;
	bh=7hcWXXziBYn1qfuxxfJhKxj4y3NRVUIj3O1Td8UAU1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psovO1HYVCn69Iy+pjvcIfo/bvLWQQs/WsN78kJ0/g0tYiZNXwqmmzzjc/6rmcYv03AMGcDXnGSpqmJRmJ//4ND1ZT1onNvdSbF6nuZXXqVjP3D660asOQIUsXaS+NuoPDbFRa60zBR10Z0nkCvWTOZX16ddCrmoImHh87TmU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc8o4Vgr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc8o4Vgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB9C433C7;
	Mon, 19 Feb 2024 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340450;
	bh=7hcWXXziBYn1qfuxxfJhKxj4y3NRVUIj3O1Td8UAU1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wc8o4Vgrmb5fPLwG7ZwnVuwbvPm0Y6qKfgCao6ceStTgLcjbJqZP7Us3cliH3yObY
	 1U3hsLKhCHocvGraElmrDtEPA/ZqZF4zw5XEx5vHA+Pz8KNXlR90FA/SAn85rljYZl
	 g+SCd/Aa4V4ZImYLHsroy9byICXLqoKRCKIff+I5d0inugDKpD+mjAtYXk8YaAVaVR
	 K+bF6nwXeVVTQx567XvcPxiD0vZE51UyEm6utXLBWvd0AW+1A62oeFmG4HTTRhxX7J
	 MKR65Pq0Zlb872AnTmcJrS+ZgOOfl1dvjbtbsBwADuShqHoxRB3SYsqdUcIOerVVqZ
	 9LWddP4wYSR8A==
Message-ID: <16211f54-6f5c-45b9-91af-8a200e1e1492@kernel.org>
Date: Mon, 19 Feb 2024 20:00:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: print the number of implemented ports
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org
References: <20240219104818.1265138-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240219104818.1265138-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/19/24 19:48, Niklas Cassel wrote:
> We are currently printing the CAP.NP field.
> CAP.NP is a 0's based value indicating the maximum number of ports
> supported by the HBA silicon. Note that the number of ports indicated
> in this field may be more than the number of ports indicated in the
> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> Offset 00h: CAP – HBA Capabilities.)
> 
> Print the port_map instead, which is the value read by the PI (ports
> implemented) register (after fixups).
> 
> PI (ports implemented) register is a field that has a bit set to '1'
> if that specific port is implemented. This register is allowed to have
> zeroes mixed with ones, i.e. a port in the middle is allowed to be
> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
> Implemented.)
> 
> Fix the libata print to only print the number of implemented ports,
> instead of the theoretical number of ports supported by the HBA.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since V1:
> -Use hweight32(). Thank you Sergei.
> 
>  drivers/ata/libahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index fca376f03c9e..ef31d234e7b6 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2630,7 +2630,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
>  		vers & 0xff,
>  
>  		((cap >> 8) & 0x1f) + 1,
> -		(cap & 0x1f) + 1,
> +		hweight32(impl),

Looks good. But we could also print "%u/%u ports", keeping the max port number
from cap ((cap & 0x1f) + 1) and the actual port count implemented
(hweight32(impl)).
This would be less confusing/more informational as the maximum number of ports
for the adapter may still be equal to (cap & 0x1f) + 1 even though a lower
number of ports is implemented.

>  		speed_s,
>  		impl,
>  		scc_s);

-- 
Damien Le Moal
Western Digital Research

