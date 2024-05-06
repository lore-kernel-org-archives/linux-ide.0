Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7048156991
	for <linux-ide@vger.kernel.org>; Mon,  6 May 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013984; cv=none; b=i/x6E3VxySKj69x+SLj9uObFB45bgDTR3aqEY3QubffGZ4Bxu8RwHQxhZacGPr7G4Mke0mVe0IW9Djk0Y7O9sIghrOhpszUpDEz+E64r4EDkf25WjCX7TuTO4EWMkHJeGUp1eJpIyVfw47uQc+Zq/Aqhso38ctOMDgvhNYY6b40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013984; c=relaxed/simple;
	bh=NpqeFzMmrXRgWx8lVOk5rCUY84O3BWGZr2oT1JwoTdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAL940t+kVfs5ULICWTm6zdKtUQmFzGRRFF2la+CiWelsuv7k0pxffRRGBle+wNzqWDHBkfWWxh50e+0jthzb8cF4bSEUNJNGBaxgZtjnZW2oD8fDg9ZD1tiG70NfeenltTyTbNKwt0UbfO3AF4H8GAvsUR6JZ7LvO4D6zFJOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RctLJ4Z/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RctLJ4Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73389C4AF68;
	Mon,  6 May 2024 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715013984;
	bh=NpqeFzMmrXRgWx8lVOk5rCUY84O3BWGZr2oT1JwoTdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RctLJ4Z/L13K3ru2bT/FgxLlYE9cSWYDI0mPfH69xju8U680XSDEOD2pyK++TZoXv
	 mlztjRnnZQNBc9H28JqZYXP5MY1Bd73M4ut5QqxVkYZowv+x49bd3wM2rw0J6Eh6Ad
	 gJQ4mVpHuCLrOEFGdlel+p0ThJZV05Me6Lz8ra2r07w2lfoXkgahsgoml3Y95zGGvl
	 nnelrl/r8+drC7iYYnyeO0HF4USosd6FqB1t17XOzWLcFl+nm4AG+yUUjYDXyYnQht
	 uelE5mhChslEkcWQTsioJrojAZnh0ZzltN5UQJFUykTc/FBn6o5rQhHStZa6OANw40
	 LaVFn8lY4cnGA==
Date: Mon, 6 May 2024 18:46:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Conrad Kostecki <conikost@gentoo.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Message-ID: <ZjkJW_zx338tHmo_@ryzen.lan>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
 <ZiAFEbDnwuqYWaAU@ryzen>
 <em49d72564-1852-432d-b066-eca899af6c2a@806cd47e.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em49d72564-1852-432d-b066-eca899af6c2a@806cd47e.com>

On Sun, May 05, 2024 at 07:42:55PM +0000, Conrad Kostecki wrote:
> Hello Niklas,
> please forgive me, I wasn't able to answer earlier. I have to roll back here
> :-)

No worries :)


> I don't know, what I exactly did wrong, but I did now tested again PATCH v2
> and can confirm, it just works as it should.
> Tested on 6.8.9 and also 6.9-rc6 (with has PATCH v2 applied).
> 
> My ports are being correct masked and DUMMY is being correctly shown.
> So all fine and I am happy with the patch as it is now.
> 
> Sorry for the noise, I am really not sure, what I did wrong during first
> testing.

I'm glad that the patch/kernel module param works for you.
(Even if we can all agree that we would prefer not needing a kernel module
param at all :) )


Kind regards,
Niklas
