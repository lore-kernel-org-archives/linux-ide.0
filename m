Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180D2253EB;
	Thu, 15 May 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312628; cv=none; b=ATXzY345qCIQTkj828KJvjDgHc6OSklR+DfJDml92/WRPxqR6CPIlE3iQDXIEuefwvJIfQ8hiiVAk+GWCFbfA8s4awm6R7oVV7yfwXWtXEgXK9lZv5dMaZPiZ4xwLRLf72hidO9R6M2PUJRpIOzOwO00hpXrxlqcMrsVuLi1jMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312628; c=relaxed/simple;
	bh=yYv0atoEAMkrGYgvkqQ97c2LxxpsGtS5M/RLdp+rqRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDjMfJz3yqR59Rc3ZykRi3GORaDmCJtk5buZQaLatyqWQzXXw4UYwOstj0gy3Ww6OMeN719e8f5udKUeEea4zkA7ZuGHMDol5O0ts4OURZfeQsaEbqn82kjudNcIPGSk2ZS5d7RGbQBLa4V02wz01eqRKVXk9AezV1kNarajuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVFndL7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVFndL7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AACAC4CEEB;
	Thu, 15 May 2025 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312628;
	bh=yYv0atoEAMkrGYgvkqQ97c2LxxpsGtS5M/RLdp+rqRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VVFndL7qQjKne2NAprAxfj+q9wvpZRlUVPG2B8PuCqg6SBZsV8BPxu5siDYTpJS5b
	 bQpbnhrJpLkEuNQYlaJObmKP2McHERParHvPBzML3FrFReidU/cUdJKc35ZFQSuCyZ
	 7Nk5m4ecctF7PJJfYb+r3LRaNn6FSiYyY5cn+m4Mdvt4sfXnu1ZSit2nZqmAyTHG99
	 Z1haZBPzlEHc0ccVMmUIkgwEFZBm+W/vZ1HZw/5DN0iV8bR1drMqwFznns+eSVf8Su
	 mzeClUVpZpa2e+E8zlNvSWu/yn5qs3UsUevwHdZUTfWjfU85O1Idkw9xIK0z+3lIiC
	 jdGZQnD/KIrqA==
Message-ID: <6fcd3e73-7654-43bd-9fad-58489c2d2be7@kernel.org>
Date: Thu, 15 May 2025 14:37:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert marvell,orion-sata to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215750.4179075-1-robh@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512215750.4179075-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 23:57, Rob Herring (Arm) wrote:
> Convert the Marvell Orion SATA Controller to DT schema format.
> 
> The clocks and clock-names properties were missing. The names for
> phy-names were incorrect. The maximum "nr-ports" was determined from the
> Linux driver.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
