Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DF7081A
	for <linux-ide@vger.kernel.org>; Sun, 20 Sep 2026 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878887; cv=none; b=htc22ymzBqSiBltoDsgFaBPStxRuPoIo/6bFxcIT12TOOOW2fajKbyuCC4TYoS49GfepuoK5meYq74s2o509msWOaixAHakQKhB5y64ho1y+9ULI5S2Im1kp+0YdetYoZH6XUvVew7gWINCYR8Txf7C3pZ9n+UYLrVxMk8RVReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878887; c=relaxed/simple;
	bh=1O6PX891RIX8YIh3uKcdO50Obb3Ig2Jlz8Jvf1/YN64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIYMz7yDiY27GPmtW12oncewOmz6yIcGMTgrCcgOLXhjZA4f+npkTRIB5eFFeJtgTMLsFI70Wqqa5vHzX5zsDm3vLTU/xdKcJYaoVhESmqb4wsihZY8lKVvbVHKY3nx3OIwA0Zij7fHh1HsFIEg7tI4AYUB6qVH1EKvjujfBAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd3kjeDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd3kjeDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6341F000FF;
	Sun, 20 Sep 2026 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789878886;
	bh=wrO9NL3p5Kv0crn4HLH4aqkHa7Ko+NXuKSLGT5HFSQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fd3kjeDTCwoROc4lnejA/px6ShbBLVfX//4LrRQ3LM457MSlh1dGfjyTgcEWS7EeI
	 3+yeSY+gdcfTgwcQHMnlEVgKJInVST/CzW6xKnHGAzd9yABlF/ToT/JL5xK7a3nZPy
	 PDkBu3BrZvRsSq+DDnrqbDyddZMi6VYjEQN53+O9p/8LvUYlRZRpszbMEWz+BzgKIT
	 cnsVKECvP9ujVc60on4k/7hJBthkuOTPWTZSvoc3fqVmrwAiEpIqZTfIMHKV94gfpV
	 aKEorOgwX5Ti3ZQrfOkqbKbIF+CUTtZVRn8VIKUsuUDAP+1EVLFh48uxoG0WobbjPM
	 TgldRkmCExH1g==
Message-ID: <e4c238e7-527e-46f1-82fc-72aaf6ad3fa9@kernel.org>
Date: Sun, 20 Sep 2026 13:34:43 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata: Correct libata.force parameter
 documentation
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260918124030.1962773-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 21:40, Niklas Cassel wrote:
> Align the documented libata.force options with their implementation.
> The force table accepts PIO modes 0 through 6, not mode 7, and ncqati
> controls NCQ generally rather than only queued TRIM.
> 
> The max_sec_1024 and max_sec_lba48 options only set transfer size
> limits. Remove the misleading claim that they can also clear them.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
