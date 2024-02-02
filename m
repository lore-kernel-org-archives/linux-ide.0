Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029CB67C
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840023; cv=none; b=pnahwoJYSjBJoF98ggQoJK2eKjj/qw5ql7L4E3MynusifXULcLyCkleB+MTWKn7xyCVW0hPK3JjzvTHNPjEMM6ZUZP+oxptJUd9oh9J1bhM4nYjys72cnI/TCe8DcjVKiIphrCgLAUqnGPH1TaQ3Ht89ArGXLoZi2+aN99BctzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840023; c=relaxed/simple;
	bh=sIcXO77voXn1gEfP/ztw2+Cq/X0wtTPrNeDWRexw8Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYdsq1zCIm8hWl4WSlOBoAI3b0wuIizgLuJOnYs1B5HAVMmni9QWZgUdyMsN+4UYeD48YOkrwF66a00LojI5FyfdJOc+42lkpyKEk59uEjDxqizfQ+NzihpoVrLuSTmAfEVKDFvVpB3vAsw/gNHUpnG/mUTQAAcPiHpEVoVWMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkvWqhMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkvWqhMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E22C433C7;
	Fri,  2 Feb 2024 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706840022;
	bh=sIcXO77voXn1gEfP/ztw2+Cq/X0wtTPrNeDWRexw8Og=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OkvWqhMHVgMiDS9EL4JGB943zOgcnv2a3EXAoMP0XqmEPpdFAeZPL3gMlR9rUVw48
	 sd1Sm109dFZt+bycFZNSJ6x44opePEEXMe7k7M9R/otut46I3XRJSJh/gZSNZPcy3A
	 nmXiQCUfZHPpvufraYKOuyOamZ98XWP+p/zkTVEfpNqezCseEBMe2D9vOG+Cq/1Lnd
	 wWG83Qya08WMV2uNBlF55Bv9YqfprY6co/yqnKyuQGjVEabqOM8glR1/kAbJikYFro
	 wG3m/h0Rs4lNoaLSF815fCL9wzY1UZ4loM8gEE2rbZa29hRSQOjuMIDQCdlOfap9Ud
	 clA+M4V+x1UnQ==
Message-ID: <e9833187-b4ff-4d7e-89ab-c8460d7f6f11@kernel.org>
Date: Fri, 2 Feb 2024 11:13:41 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drop low power policy board type
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:14, Niklas Cassel wrote:
> The series is based on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next
> 
> 
> Hello all,
> 
> This revives a patch sent out almost two years ago from Mario Limonciello:
> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u

You forgot to CC Mario.


-- 
Damien Le Moal
Western Digital Research

