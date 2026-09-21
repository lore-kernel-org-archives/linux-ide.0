Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E75483BC5
	for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990001; cv=none; b=Fj31L+hHhF5UDKIKnvR+aLgtUFiiAHH/l6+DH0tR4q2yWGh4yn9ouCrQK6UTXiJbf1deAu5qzXl2ZiN6vjKFlmI/LczWPyARloVcULSEf3i/8Jc1r7HESTfIg4m4thP3olDieJRDSEQBTXaZn8GRWmCQLJSHYevj5fyDP94JSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990001; c=relaxed/simple;
	bh=6sCeftZbNdePCFXLw7/vYtthKoQ5LJNSwIx0q/NUIvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX0BkWK0QIfKQojKA+X2ZINdZw3Uns1d33d8fXjEIjeEDU3i5VPgpgB9iIERLbHvTpgdB0rAfz6E8o+3O72ne5Cc8FYO42mQJQGQfVukJxulN7cMrTv3C2MGBew7wg+jWCW2XT+0W7pYlI17nTUI0+ATwwYz68U9dNsTNtYSBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKsA691i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKsA691i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815151F000FF;
	Mon, 21 Sep 2026 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990000;
	bh=8vCna3pv34tpmBpOoZ59Iracq0PGmqDhATBVbkWHENE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKsA691iahzMixPDIoSUGCZ3hX2PCZK4p2ZdZEmQTU8PysIH2PFD3L5/oZRLlCgU7
	 Rg4p0FOnEgGFKU1EtXiP6Jn5ZrI7OJN/Bo1ubGq86vsy+QkWl65/ZaF4KBsha9bpR6
	 ELERGbJbkMIc8V5Enf659CH7VE5oA3BC4wWrlFNA+bX404H/VaOP3ue+iD1pq0zUBk
	 wILoGDYn5oYB7blk0OqGFqtttZJUOHAqQDev8DOJp2ox6H1tv4I65F4i/+iKYPynfJ
	 u8x8Co9WS/ZZ6O5QTKGO3U7wXydUh0eFKV5Zqgm2kPj/8xBH8GG9OoqebE/zCLKfNu
	 eLrHwfD0Wanig==
Date: Mon, 21 Sep 2026 13:26:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 2/2] ata: libata: Correct libata.force parameter
 documentation
Message-ID: <arEUbNHVitKZWACC@ryzen>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-6-cassel@kernel.org>
 <aq0zTqvUzopOdQwF@ryzen>
 <1022afd9-3443-4f1d-a35a-e550615a67d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1022afd9-3443-4f1d-a35a-e550615a67d6@kernel.org>

On Sun, Sep 20, 2026 at 01:35:40PM +0900, Damien Le Moal wrote:
> > 
> > Hmm.. I guess we could theoretically remove the [no]ncqati parameter from
> > libata.force.
> > If a user wants to enable/disable ncq, they can use the [no]ncq libata.force
> > parameter.
> > 
> > However, since this libata.force kernel parameter already exists, I guess it
> > might actually be used by someone, so we can't really remove it without
> > potentially breaking existing setups, so I guess the easiest thing is just
> > to keep it, even if it is not strictly needed.
> 
> It can be needed on a machine that has multiple adapters from different vendors.

libata.force parameters can be applied per port, so even for machines with
multiple adapters, it would have been sufficient IMO.


Kind regards,
Niklas
