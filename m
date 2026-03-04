Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C49225A38;
	Wed,  4 Mar 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609381; cv=none; b=CM4Gz4fVcAJWG3C6C/8v1RC9G9EMnOmkfEr+Cwvn4AzGjKKWZaqiX0ul6WNulU/x2DnUTpbU9Z9jIWQAy1v6j6cMqKvu53KWXjWnvXF1X7KqLACEZUoVerDlyfXluTPw+kt54qITK4MOtxRXwvg36L2WjZn2eFl0JyYjHT9vOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609381; c=relaxed/simple;
	bh=r1e9d8G5ZSG5LQ+9XReKfgJkqbiAPXUTslhm6eAHRuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOoJYCu97wXYWoGEQNCuws4jmfLKKIn6BPiN2ZYvkgNravsxGSmhFCt4B4W0OdJ5PhNDxeKx2CXcL6HLShsIpuMSm830NRBGCixZxhaC6PFflPZJJHXdYauIlCLEUyY0jHeVs8m1Uv1X/QPi6wlKNw5KxtmsD62ncxMr47DmwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA52ulb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA52ulb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC24C19423;
	Wed,  4 Mar 2026 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609381;
	bh=r1e9d8G5ZSG5LQ+9XReKfgJkqbiAPXUTslhm6eAHRuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TA52ulb5AyOm7JmJlRS8L5XNm8TkjkAfEi+KK92O/5HNk0K8co8mPCYSRcLvt7ylN
	 ZFTUK/Vi2KKPp/4wXmo//RMXf/AoElyi0yxLZ5UMaig528lODY3rOKWHDu5leyFFzw
	 NX1N/KqDoa9NUi0tiQM7mg/obXoQhBEE0fkyPx6uwxI97GJkur69Tc2zDjSNdkmm40
	 dKZY8HGtHK3lpZcR5DyG0VnJb50XnEJa1kX0ADSkNVAq761Z2+ZyyjpczTFBAOYgvx
	 hVMyoMFeJj84ZFR0PlwT7sJTPuzcljaJOwHf88obmD7xyiONu3GDXpJRdZS8xY7Qxf
	 eyGJg3i0AfV5w==
Message-ID: <d46a083a-9c6e-45a5-9e52-b5d94d265411@kernel.org>
Date: Wed, 4 Mar 2026 16:29:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Disable LPM on ST1000DM010-2EP102
To: maximilianpezzullo@gmail.com, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
References: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 16:22, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> According to a user report, the ST1000DM010-2EP102 has problems with LPM,
> causing random system freezes since kernel 6.15. The drive belongs to the
> same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.
> 
> Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Beside removing the copilot related tag, no changes here. Still looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Niklas,

This I think needs a CC-stable. Can you add that when applying ?

-- 
Damien Le Moal
Western Digital Research
