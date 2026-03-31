Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38029E10F
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921385; cv=none; b=pJvF2TghQvxoWlxJzRMjDkgtVvAxV6Ks6I161hmKD5u/wSVuMqnkwYxhGnH6NGCMBkYcSkw7hgNH026cR9W27LJOj4UxqTREAn9+rGyfwmFOSUu2dLB1ady7gdhmjMZpN8YNUSRKwHpK7xIt3wOeBk/aV8ZKJV+DqIsoQ4XUTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921385; c=relaxed/simple;
	bh=C/JOp6L5pCdBMnVWBtCUtAMc2JMZiY2Y1QSs3/fd2j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1+5MsreAiIHHEBjbV5Glbrm8C/fsTBLh9WBBEBbyW5+yILrCbwgLMC59Maq0CvKKAvGtGCgXv1ykUzG4HSXkR9/SwZWGYC4xkdw4bSUMuB+IHdwx5Qi9iqfbSPXeRy7MQKmNFy/RUVn39gCoS9IHVnW8W/eV/tc6zP1bPeQIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM60aaz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM60aaz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB0BC4CEF7;
	Tue, 31 Mar 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774921385;
	bh=C/JOp6L5pCdBMnVWBtCUtAMc2JMZiY2Y1QSs3/fd2j8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LM60aaz8jb03KzPL59ZCKkzVKH502uo+3eIACWKRwkmlDh8xla0dJn+Gvc5tSZNrH
	 DaDDU6T3E+Kj4StGdjG2uXf+osusrr5CA1RTUtUN8aa3jsZxLzF7i3ISxyC70AWTs4
	 idjPWXRCxZZkAhdP+qNFcPGfxgFJZQNwgZ9X7anIum0+jYJiLcOObBrdoryvTWSDxi
	 TVShNEU+tI2E5ws2xcAkpT3WohDbj6+pse+B50WN6+12AGg7W+ni04veQGO11mNq0H
	 IeIxzpdq1vmCyACGZAxThg1F6+wNPPZUpefrxT9QVRhmipnV/gFEPLqrDFeWtKTLgN
	 X+0NuahEAO8jQ==
Message-ID: <3cbc5124-7420-434e-993f-f19186ee1c5e@kernel.org>
Date: Tue, 31 Mar 2026 10:37:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata-transport: use static struct
 ata_transport_internal to simplify match functions
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <a0fbf4ec-cbd8-43e3-b52c-39eaf937052c@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a0fbf4ec-cbd8-43e3-b52c-39eaf937052c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:19 AM, Heiner Kallweit wrote:
> Both matching functions can make use of static struct
> ata_transport_internal. This eliminates the dependency on static
> variable ata_scsi_transport_template, and it allows to remove helper
> to_ata_internal(). Small drawback is that a forward declaration of
> both functions is needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks OK. Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
