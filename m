Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D42253EB;
	Thu, 15 May 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312557; cv=none; b=CP3Q5SvNgnbf6E5FEYb7zjKweQRz3geX1CxQbdw3bu30XCX36UGDvj2lWQ895Ld8cn+z0ZBYZ6aNvK8y3wFhItqg9AiHHxpvsp1PU/75hqCvHQGL21mbPWP8f0+JwAVmzznicecPJw0p36z/qUEvQM2uVenWSzmyv/rHwEpHDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312557; c=relaxed/simple;
	bh=2spys5TtRm0Ewp6y0mpAM1/gMoBUOmnHaV6fLn8rsRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGj1M7mSXKcViNWo3/I1BR39EtEeS6ctQvtllFUiJJbgb98gv5KcAvh4QVrrfsVHHh0EY1wl6gLOQ9xCLYDk0sr0BzjKbdGOMIUlL2K7d9jqN5EdVKEVwjEYHuQJU4fRxZF2l1HRabYeuP8JZtS2y1ppOFxwcjaA4em8hcUYVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrENt0xG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrENt0xG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC341C4CEF0;
	Thu, 15 May 2025 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312556;
	bh=2spys5TtRm0Ewp6y0mpAM1/gMoBUOmnHaV6fLn8rsRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GrENt0xG8woAl5yoGsX3awmEUvCnPgXy+IDiTQygNNdyPfVxmgObTuWIlnSBgUrF+
	 Chf8VMAR59D8WeyZ+ypvMafzDOI71286xZFTjrDAh/ejkhz/Z11ayF3yjQV1sC/qqz
	 8ge3vPGh6izvhntJxTqX/kPP1RndXod6zbnf7tHErq4cHAZJSc4n9fkJ+bB4gSC/Ha
	 BCZ16CSlTTw5UkoBR1g6u8PmavHHBFYjhX8a3EnyTuaCWeBy/jjiE9wJ0on4LZJuGA
	 6MTOKkT6Rbv962yJIpG0qseoBQK6a02bMax9IFcPRc+i31ythq2hhvHihZBwOWIhzT
	 v/oYbcRCCZnGQ==
Message-ID: <21b60af5-a9f9-49b0-81b1-94f8776636da@kernel.org>
Date: Thu, 15 May 2025 14:35:51 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert st,ahci to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215724.4178359-1-robh@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250512215724.4178359-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 23:57, Rob Herring (Arm) wrote:
> Convert the ST AHCI SATA Controller to DT schema format.
> 
> The phy-names changes from "ahci_phy" to "sata-phy" with the inclusion
> of ahci-common.yaml. That's an ABI change, but the Linux driver at least
> ignores the names. The binding uses "ports-implemented" property, so
> including ahci-common.yaml is required.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !


-- 
Damien Le Moal
Western Digital Research
