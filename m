Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75452222CB;
	Thu, 15 May 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312606; cv=none; b=VA0wCDS4gzHZvisr8OOHoiO9Jr2496h0dHTNItn4281djfHm0c21wru2YpIV9jBuqs6If5iMujHdxIy+XS9u8itu8VKBN2+/7eLhhH8HaRyzZZ2ubBz+qdQeIWgn24DUSAFcOsib0aJglZy98b4yoVePSVuG4dli7rW4CzhuPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312606; c=relaxed/simple;
	bh=nIUAQYY+SJvxxB57dX5DB4rBv/0zzg4MEYdTmxt1Guo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkkum5NvoNXVzlHcDs4YeaWAvawsgXHUWMknHhd3yRnuYrniRGcBpW0me/x+vaq5ZHURsaURdR+xdSsb6N3RYSU/TnZtwyvToNNsWB32gYjsUl3bU9psNdyUArbo0ZUm9ezrS9y2KFwWalEVN8lDtAfG+7j4Lr//P9qUghPamgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJXJ9xga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJXJ9xga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89145C4CEE7;
	Thu, 15 May 2025 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312605;
	bh=nIUAQYY+SJvxxB57dX5DB4rBv/0zzg4MEYdTmxt1Guo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jJXJ9xgaoWhQMyzvmUH/XX8jRqJ6uDO7k6HI9jqpFpZmfEQBSZHdmIsvH31+1xlns
	 h4iJ1YHRtTx1GDdwWo/Fxd50wIcX+E/2e7BRSIlDjvADWfYiJ0VjUndDYercYL1LBG
	 YjEKi7cfrKfk/KnWgZjGaP0RbiQGIV8a81wa3DVChpbLsAhwgeZLIrDfXZZyr9iAxa
	 onwUIjRgDtN/sh+P36C+u/c1f+nPpJzbwRSuj577prTRT4oeZE/1/Yyat4ywgT4obW
	 0yVxZjopgI/DDabJ/ayejXKRPBwr9+UWtEIDStQ3xkKJna+udPKgHaUZZtNCQk22r8
	 YPwInUNjJKswg==
Message-ID: <3a006b57-d2a3-4818-a332-26f626c97c3f@kernel.org>
Date: Thu, 15 May 2025 14:36:39 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert cavium,ebt3000-compact-flash to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215742.4178861-1-robh@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512215742.4178861-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 23:57, Rob Herring (Arm) wrote:
> Convert the Cavium Compact Flash Controller to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
