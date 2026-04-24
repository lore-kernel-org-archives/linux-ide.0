Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420F38237E;
	Fri, 24 Apr 2026 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029330; cv=none; b=k0NiADpNY0trhvhu4a+lw6IbeKn2lOhk7m5/CVVn/gizvuV4WTPVmfPBWJB8jNxyYvcunGeUpZ7OMX7AnJOtUTftr2oCZeG1vxSDmVxrDD/3TgzeT22ZDvvPbjxDS7ViPFQqE5sHY8rRUTNQCzECooqyzUUOhMG/EoYpLj0cbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029330; c=relaxed/simple;
	bh=AsXvZGSPqw4/ZlUXdQTV4v/oei9H7bnuKyzoD77gR2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY97YkR2pLG3ANZVxv0XpHiFgF5nQBupkCMKG2p6Ah5tbGfwHFkJtxDAmxhIX6pxd1jdfZgsaS33E+eza1Ud5y9PWSbB0tXUrB6FVxGEw6klMoUvN118+ZzT4p75hb1batop8yYz5EhnWbe0byk6EpmVO1WYPewmjPN8TYURbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXF0LTf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXF0LTf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA50C19425;
	Fri, 24 Apr 2026 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777029330;
	bh=AsXvZGSPqw4/ZlUXdQTV4v/oei9H7bnuKyzoD77gR2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kXF0LTf4LwCs3jZgQaYq5s2cEAvAhViRHQD8/Hcg0UoSjFa6zyWOvjew+wlOShDAI
	 iHu7YMZxXrNRGQ+HjqcvRsGfP0pdsDg6f5iFU4HAPlh2XSUHoPE/pOsxv6qzF1fvHD
	 kjQQrq4RO1zOAI00A8O+OjsTJ/DXSMCtolNdDpkINURislGtNUzXxwfmwsflL/WkTb
	 8vFwRgvRveInfJB5KThKkXkgLNwyDF0qwlCmF0Zetui4tyCzYGcnw/GQX+KmO3dT6Y
	 VUW7svXBOhTplNmDkTxJgcZjrENuv83yJdP8Thbz2BsfQqTC7g0iexM+rmOfW+MtTY
	 ZuUJrSxtwqLNg==
Message-ID: <05483953-5bf0-4d7e-92ee-46a49c9796b0@kernel.org>
Date: Fri, 24 Apr 2026 20:15:27 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO
 region
To: Niklas Cassel <cassel@kernel.org>, =?UTF-8?B?5p2O5L2R6bi/?=
 <dayou5941@163.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 liyouhong@kylinos.cn
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
 <aepUh_p0Jkw0XQ7N@ryzen> <e4280e3b-b02a-4c4d-97dd-1bd49daad2fd@kernel.org>
 <13d7d471.6389.19dbe594e14.Coremail.dayou5941@163.com>
 <aetO9e7Kf5DZK0QH@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aetO9e7Kf5DZK0QH@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/24/26 20:07, Niklas Cassel wrote:
> On Fri, Apr 24, 2026 at 03:16:56PM +0800, 李佑鸿  wrote:
>> At 2026-04-24 10:43:11, "Damien Le Moal" <dlemoal@kernel.org> wrote:
>>>
>>> What I am surprised of here is that we even see that device on the PCI bus at
>>> all when it is disabled in the BIOs. If that device is disabled, why are we even
>>> seeing it by scanning the PCI ports ? The adapter should simply not be visible
>>> at all.
> 
> I agree.
> E.g. both AMD and Intel make sure that the AHCI controller PCI device does
> not show up on the PCI bus if you disable it using the BIOS.
> 
> It would have been nice if the Phytium BIOS also worked like that.
> 
> 
>> 3. **BAR Size Mismatch**: `CAP.NP` indicates more ports than physically fit in the BAR
>> - If CAP claims 32 ports but BAR is only 4KB, this is physically impossible
>> - 32 ports require at least 0x1100 bytes (0x100 + 32 * 0x80)
> 
> The reason why I did not suggest failing the probe() originally, was because
> 李佑鸿 sent a patch with a Fixes tag, so I assumed that he considered it a
> regression, and wanted the hardware to continue working, even though it was
> marked as disabled in BIOS, because that is how it was before the commit in
> the Fixes tag was introduced.
> 
> That said, I fully agree that I think it is better to modify the AHCI driver
> to fail the probe() for this AHCI controller when it has not been properly
> initialized (because it is marked as disabled in BIOS).
> 
> I prefer option 3.
> Look at CAP.NP and look at the BAR size, if it is too small, just fail the
> probe().

Sounds good (and a lot safer) to me.


> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
