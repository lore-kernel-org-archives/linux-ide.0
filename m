Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC035943;
	Tue, 14 Jan 2025 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816350; cv=none; b=NmY2zcOU1c6XsoTo0N6hFirSVsXc4dYv25Q8fM30mntfksXajZRNbT0vh3yHDZcGaX88PQUR0v/mfNwvmaecPpWasu6j2WPccg7UxFqlXJGgnP3aqBNtOrPF57v5NP3mlrs4fzW6uJCTB0NZeOAi4FNLjXZigueOmT7TDFN2bRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816350; c=relaxed/simple;
	bh=DhGIJngef3/RTbGhguWBSYVMUpaxs79saEaYmS+Hb4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7Aqo2rkGvhtnTUlEH9XuqUeu9QrLksbki+9lrRbYXSvnOrJGYha1U4vNrWJNyVG9JJG73s4HxBUNEBM7RWH0TLzVH8QsynYSCh8tEKb7wcyr0Xn+cjph7MYqNr3U20uXX1V1JYyyGUn260KuLbMSo8JzyTWFCgYzwV4YvmfRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0vwox6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0vwox6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAE1C4CED6;
	Tue, 14 Jan 2025 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736816349;
	bh=DhGIJngef3/RTbGhguWBSYVMUpaxs79saEaYmS+Hb4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k0vwox6Fc6mkl0zblXsR/sHbNRMxhVMdNpcWdzh6WTLi2zyJr6E2/xOpiBs6QKbap
	 SfdfiMk93wSPUvcv1iW6S3LLTOlEPtnGF29Bs2e2LqMZsQn++8VEBZTBft093K3w+o
	 sWm/5zMFkHXsyFeYr/v86dcLddlthTSZXgpcMGPgO56DbJTeuAR5leSgEiqkNxOhB1
	 mrP5wiurfLcGkqIofJEeY4vEfz1P2bAcCUnP0GSaaMsNzC+etx43B5yPUJfbkozXvv
	 tuA812nGzcPJ0f4y3KSQbSXb/zvx8LSe+Sal4qnExVt6YK9Jx/6ieJE6nFsCup2TSJ
	 pwPOVf6kblp8A==
Message-ID: <88fb7ad5-e2b3-498d-82d0-cdba8cf50c1b@kernel.org>
Date: Tue, 14 Jan 2025 09:59:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
 <Z4EDKUb+hO0ovV2i@x1-carbon>
 <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
 <261f9fac-82de-4f39-bf5c-cdfcee917588@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <261f9fac-82de-4f39-bf5c-cdfcee917588@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/25 05:28, Raphaël Gallais-Pou wrote:
>> Do you want us to do that cleanup ? (fine with me).
> 
> Regarding the other ata drivers, if you have the patience I can do this 
> in a few weeks.  There is other things on the stove I would like to do.

OK. We will work on this.


-- 
Damien Le Moal
Western Digital Research
