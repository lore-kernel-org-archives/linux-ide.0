Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4D364A5
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761475; cv=none; b=rTWB7bThSMnvtmkc7OSsaEodLu9W2Xhjby4sEYTU7Hwop/5lVNlrJ8/CsgMl2ttqGVy1TD6ALCLcWQ046RBCgrtfWEBhptxdN91H2zwTWFqMrC8EAA15W8KkxD/wKsAtpoJfRS91HKr1wpUj5fitIC/ctmKzVngdWtPL/ygkMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761475; c=relaxed/simple;
	bh=CIK6FLpBkwsidPSaLMrkUvjYXzcBoDYujwe3v6oJdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8jwfWlMqVeth2JrBX6E6OdtG9IhSzwn8QgRi9AfUzO2xTRnckNYtmve/33fQQIB50cjBBE1Q/5z2rFd7Wvc1MFS5SRpm1oxdeh45LpGQpuoUVw+OAw3om58H+8MJ8NJ/j3UAiglx8SShAJ8w01lQEwBcmoFWAUgzEII0ZDcMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqZZcV7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqZZcV7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A26C433F1;
	Mon, 18 Mar 2024 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710761474;
	bh=CIK6FLpBkwsidPSaLMrkUvjYXzcBoDYujwe3v6oJdy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqZZcV7RfXqhHowiPilyUXmiKCGWaWU90/ubyD6NVWDV8CqN6H0GSS7Vh6yGL0oks
	 Dhyzi2Fs0qFCXONyjtwixfoDpb5AzZHiJHmfEWpXgLYKB0A1GGMAedbNEllCXbmBh6
	 FiVjt2EEiyhuO2aXGf51c3oBa2s1eVi3q66fQ257q7VLLbphBFZl83ppwaSj56uQmK
	 XoeuXt36OddqCUcH9AdMr04uvrPt+uVlY+KknZCNGifiR4/Dq6AkBSNvo3jecpS0dX
	 UWgmIsrgAvx2Ws0uQ+IGL2OsqZvJtfUOWqAyrNdLiZ2MR0CZ2NXEyo357Ap/ex5E9k
	 VN6sEnobk0aAw==
Date: Mon, 18 Mar 2024 12:31:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Cryptearth <cryptearth@googlemail.com>, temnota.am@gmail.com,
	linux-ide@vger.kernel.org, conikost@gentoo.org,
	Ioannis Barkas <jnyb.de@gmail.com>
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Message-ID: <Zfgl_n1hra6xSYIK@ryzen>
References: <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
 <Zfgd4gjQS0Cmexeq@ryzen>
 <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>

Hello Hans,

On Mon, Mar 18, 2024 at 12:07:37PM +0100, Hans de Goede wrote:
> > 
> > So I have honestly no idea how this works...
> > 
> > Perhaps the ASMedia firmware takes the command to port0-port3,
> > and instead of sending it to the PMP, it sends back some faked
> > reply instead?
> 
> Yes I believe that this is what is happening, the physical-ports 0-3
> are obviously connected to the JMB575 Port Multipliers, but I believe
> the "emulated" ports seen by the OS are mapped like this:
> 
> 0-3  Only show as connected to the OS is connected directly to a disk
>      without a PMP
> 4-19 Only show as connected to the OS when PMPs are used and the mapped
>      port on the PMP has a disk connected
>

I'm not sure, see:
https://lore.kernel.org/linux-ide/CADUzMVaFcD26QiBK_eKCbtC5Ot-+hAruNbUx+2pQNTKtMhDGRA@mail.gmail.com/

Ioannis has an external PMP, and on v6.6,
he sees two disks.

But on v6.8 he only sees one disk.

It is a bit unfortunate that he did not provide a full boot log,
but he claims that both disks are connected to the same PMP.


Kind regards,
Niklas
