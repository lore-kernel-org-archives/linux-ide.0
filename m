Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203F1E2310
	for <linux-ide@vger.kernel.org>; Mon, 20 Jan 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381278; cv=none; b=U/5UH9se8xEyJNTFUdg/aCMNEr4wlU1NrB6IqZShPQpU480Hs0fKv6ivclLYEkcp3D4T/8DWnrHhUMdjXS+h+bM6q1eZXj1S4rJtZnnJYARjktbFWZUiLzjsanqmZjOnIZLO6ZCh/1QfMo0QLNVv6nvOk7MO5c2FVFtfPl6VBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381278; c=relaxed/simple;
	bh=7cNRsX4X5I4XDcHBCsYgQ5tCZ+1dqf2fOAVtQZdN4Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDdwr4jdJrPHjKbayPKs0RKC07XXH1kPzh01oebgz/lw4ZgUweHy8M5M17p2YogDwbi/i7Q91TrIF+0E8gHL78GtNhECKwG97hy5snpWbk/Z6l+GAkCWyiAxsajlsT3EVZSIHr+FoETjQ+7M/3U4gKrN+JqoUB78VrvLFckSxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+03IMLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+03IMLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF92DC4CEE1;
	Mon, 20 Jan 2025 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381277;
	bh=7cNRsX4X5I4XDcHBCsYgQ5tCZ+1dqf2fOAVtQZdN4Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+03IMLxrRf4s/15a5wAXUKec3lKUMFAz/U49MtuypOkFkZ4+8bz2ObzrzCBE4m8p
	 vE40yomWDq+//sG5c7YpzqDqju+tCGEXE3JD//ES2n9L23oeQEtCwuoYc4rVCZRnwv
	 igaQfwOAW3xBovB7ugZ67KQbb3IgU9lKUiHzU14Ll7FuQnAmRHkjaiBrGULTawojEU
	 Q/6ntmBjIK/qUkpoDEzSPOu+5WZHnZR9+OrusDJqSpLPa4ldYDPQsZLY/IEmV92BMv
	 SceBQfPEMXThn1bjPvHUmSVdSRCEUKJ6D0bLbM2WNsuTFnMKgywrmtJcCyY1OjTuMz
	 Tij2MCEjLQ3Vg==
Date: Mon, 20 Jan 2025 14:54:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: reveliofuzzing <reveliofuzzing@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: out-of-bounds write in the function ata_pio_sector
Message-ID: <Z45VmuS-j0bEMf89@ryzen>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z3ZtFDgs61oDMMB9@ryzen>
 <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>
 <Z4popNqD1GZriXh3@ryzen>
 <CA+-ZZ_gtsDShKeZSupbrwCLtpCvW=p1=citKVXRrSDi3LoZ_9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-ZZ_gtsDShKeZSupbrwCLtpCvW=p1=citKVXRrSDi3LoZ_9Q@mail.gmail.com>

On Fri, Jan 17, 2025 at 11:42:45AM -0500, reveliofuzzing wrote:
> >
> > However, the .config you provided does not match the bzImage.
> > E.g. the e1000/e1000e driver is not built-in in your .config,
> > so I get no networking, while it is enabled in your bzImage.
> > This makes me worried that you have other changes in your .config.
> > If you still have the exact config for this bzImage, could you please add
> > it as an attachment?
> Hi, we double-checked it but found the config shared above is the one we used.
> CONFIG_E1000XXX is enabled in this config.

You are right.

For some reason it got compiled as a module when I did "make olddefconfig",
with your config as base. Sorry about the confusion!


> 
> >
> > I've been using the syz-executor binary that you attached, since the C code
> > pasted below does not compile, it seems like it has some unintended newlines.
> > Perhaps you could add it as an attachment instead?
> Here is the C program:
> https://drive.google.com/file/d/1Uvhqrn-ntEYQT2PBiQjp0xaor-32WYHO/view?usp=sharing
> Please let us know if you still can't compile it. We can take a look
> at how Syzkaller
> generates this C program and compiles it into the syz-executor binary.

Still does not compile for me.

It still appears to have some uninteded newlines.

You probably copy pasted it from an editor instead of uploading it/sending
it directly.


One example is:
line380:		if (write(1, "executing program\n", sizeof("executing
line381:	program\n") - 1)) {}

Strings in C are not allowed to span multiple lines without a backslash
immediately before the newline, or by using string concatenation.


> 
> >
> > Also, you only talk about 6.12 kernel. Out of curiosity, have you managed to
> > reproduce this bug on v6.13-rc kernels? Have you tried?
> We haven't tried it yet, but we can do that in the next few days. Will keep you
> posted.

I got an off-list email that mentioned that you could reproduce on 6.13-rc7,
thank you!

Hopefully I will have some time to try to debug this sometime this week.


Kind regards,
Niklas
