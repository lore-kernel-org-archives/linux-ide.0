Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E233FD
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839037; cv=none; b=TZkK/+GLU5VCBDsvvR+LFWa3wk0eWCBvTJhV+gvyqh6So9MiIb6OYH0KzGh1YR0f34PMp4Dv2vwcE4ayh2pzYxBjcnJy9+F25iqJ4VOXDal2DUsoYemX7U+WumtBfkONTtnfvM6XpKgtBYWB7YSUTFvwpuJv81086Us/SOSlRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839037; c=relaxed/simple;
	bh=QZDL9dH0AaTZJPx7sGi4tlDKFEFIPMZr067iFi6oIek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4B3V1V/q9be4OjdVHcmyPIWojJzYLocIDqctb99Pn2RpideE8lbB2rYoV4WDAgtvjL9ghg8NH2wvBWTkFciM3jS1gpE+Botma4zN6fFLiC3O77uWf/Ss/XcX1Gp1h+UcpQf1tKElmWHGuLPjUMlrYIP9bjYyvskDl3IfKI8FCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eboyAfWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eboyAfWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B59C433F1;
	Fri,  2 Feb 2024 01:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706839037;
	bh=QZDL9dH0AaTZJPx7sGi4tlDKFEFIPMZr067iFi6oIek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eboyAfWejypFH53264ZEM2hDxYuOgdU0MwOu2rZ+omPb5rB/lCVJlfkzAOs82VVz7
	 YFI8v5vebl09nnC0LDnA1pNP1CJi9v0qTxJUBwO3yEeprz+SL/5Nqt8nRJGG1IMCvG
	 KC5R1L5epgl3SjWmTCpfGtqt87bUoGd76lwLM2lEZu2Ch6bf55iiRzgqtT3bBQEbHw
	 lPkSktGVipT1XVaQKvqj+63J09S/gCxGFkAxp/+mKdOsKggWOVKvQamUpqLvfU4Npw
	 wLSlTYsMmT7zZdYoBg70tnSU9bJJCMp5us70aHPAHTvscSjOgZo2Bfme4/JxHiyLRU
	 APV1/bdyZjOsg==
Message-ID: <0e1159cf-d938-468e-acab-6e155de94b88@kernel.org>
Date: Fri, 2 Feb 2024 10:57:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: ahci: drop hpriv param from
 ahci_update_initial_lpm_policy()
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <20240201161507.1147521-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:15, Niklas Cassel wrote:
> There is no need for ahci_update_initial_lpm_policy() to take hpriv as a
> parameter, it can easily be derived from the ata_port.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

