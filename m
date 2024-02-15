Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE512AAD6
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995978; cv=none; b=j4o+bELLDg20SrdecWwzUmSLLkvjdpgMCMMQDK60nuRLtow+w/+OsyzkgOAHWxB4NQW703ZpmNuioRakMfltsMQjv0TFIzN94vPxNQ5DNTA8bUHdEqyy37o7fY4ctqQVogDyG6690Wep5Mb2p581DlB1F6nKgB5fWsKM3ztYfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995978; c=relaxed/simple;
	bh=F3OGgVMjsJrC3Gg2mkeqQcvb3G4ILSTxzM4A4GZC7rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfq60foWI6X58WlrOigQmLTPvzTWT4aarKa8+otIuPFyXQov/SvhyBrrfVy3ACV+byU1decDNc/RNSTBfso/8yovfjPKlUgIdQgHL4mz1QZk8VQyN5snMpObLD7pSoC3mrsDQjMonIPEQw9KOcTlnXbyvOgwFiHWzFyF5MdbLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhikTF/U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhikTF/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B72C433C7;
	Thu, 15 Feb 2024 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995977;
	bh=F3OGgVMjsJrC3Gg2mkeqQcvb3G4ILSTxzM4A4GZC7rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhikTF/UPqmdlvVaYDd1+xsGQNI/vrGrtGoWdDybeaaffoT2D745nWZo9OQ00+GWL
	 nV4yKXzfcXUIDQUOD44WZTPfEL1mHXokiRgNSLZSh01mkcKZ/iwxjx+e9+LLk2HMXf
	 TLgi+6T3K9yU+qV+JZEDzZYVqUwpVCPZgtlfASSf7QAC0/pHoRJgRIBl35QNOFpbhB
	 YFB5/KPOnXBlU8c2ASWBPS5OPKyN+6QWEDQjuzxvySu8q+fdJ6AOSuDLSEo/Ap2ima
	 yGqP95anNXQePGBzOWDSrOpWrBdWaTIYGHplpvWTYCclnfrtr9azvqeye6JTcjtsEa
	 SOBZYagfvvJGQ==
Date: Thu, 15 Feb 2024 12:19:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrey Melnikov <temnota.am@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: print the number of implemented ports
Message-ID: <Zc3zRXFy1OXyNMZt@x1-carbon>
References: <20240214182031.1004788-1-cassel@kernel.org>
 <CA+PODjqp9q1VeCsDvhn1TZ6bgnghX9t8P2m-7aEjFfSiBuk0iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PODjqp9q1VeCsDvhn1TZ6bgnghX9t8P2m-7aEjFfSiBuk0iQ@mail.gmail.com>

Hello Andrey,

On Thu, Feb 15, 2024 at 11:01:23AM +0300, Andrey Melnikov wrote:
> ср, 14 февр. 2024 г. в 21:20, Niklas Cassel <cassel@kernel.org>:
> >
> > We are currently printing the CAP.NP field.
> > CAP.NP is a 0's based value indicating the maximum number of ports
> > supported by the HBA silicon. Note that the number of ports indicated
> > in this field may be more than the number of ports indicated in the
> > PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> > Offset 00h: CAP – HBA Capabilities.)
> >
> > Print the port_map instead, which is the value read by the PI (ports
> > implemented) register (after fixups).
> >
> > PI (ports implemented) register is a field that has a bit set to '1'
> > if that specific port is implemented. This register is allowed to have
> > zeroes mixed with ones, i.e. a port in the middle is allowed to be
> > unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
> > Implemented.)
> >
> > Fix the libata print to only print the number of implemented ports,
> > instead of the theoretical number of ports supported by the HBA.
> 
> NAK.
> Kernel must report what it got from silicone/addon-board. Different
> revisions may implement different numbers of ports.

Strong words here... "NAK", "must"...
Could you please give some more constructive criticism?


This is only a print at boot, so it is simply meant to provide information
to the user.

Currently this print already contains the mask, printed as impl 0x%x.
This value is after fixups, so this value does not necessarily report
"what the silcone reports".


From AHCI 1.3.1 - 3.1.4 Offset 0Ch: PI – Ports Implemented:
"""
This register indicates which ports are exposed by the HBA.
It is loaded by the BIOS. It indicates which ports that the HBA supports
are available for software to use. For example, on an HBA that supports
6 ports as indicated in CAP.NP, only ports 1 and 3 could be available,
with ports 0, 2, 4, and 5 being unavailable.

Software must not read or write to registers within unavailable ports.
"""


So
1) the impl value (the port mask) is the value read by PI register,
and additionally after fixups.
2) Software must not read or write ports that are unimplemented.


This is with current mainline (without my patch) on Intel Tiger Lake:
[    0.379525] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 3 ports 6 Gbps 0x31 impl SATA mode
[    0.379531] ahci 0000:00:17.0: flags: 64bit ncq sntf stag pm clo only pio slum part ems sxs deso sadm sds apst
[    0.399005] ata1: SATA max UDMA/133 abar m2048@0x42233000 port 0x42233100 irq 125 lpm-pol 0
[    0.399009] ata2: DUMMY
[    0.399010] ata3: DUMMY
[    0.399011] ata4: DUMMY
[    0.399012] ata5: SATA max UDMA/133 abar m2048@0x42233000 port 0x42233300 irq 125 lpm-pol 0
[    0.399015] ata6: SATA max UDMA/133 abar m2048@0x42233000 port 0x42233380 irq 125 lpm-pol 0

Here, CAP.NP reports that the maximum supported number of ports is 3.

So for this specific platform CAP.NP (maximum) is set to the same as
the number of implemented ports.

But as we can see for the description of the CAP.NP field:
"Note that the number of ports indicated in this field may be more than
the number of ports indicated in the PI register."

So the case that "maximum number of ports == number implemented" may not be
the case for all HBAs.

Another HBA could have CAP.NP set at 6.
But PI reports that mask 0x31.

Why should this platform not print number of ports as 3?
In other words, what value does knowing the maximum number of ports
theoretically supported by the HBA provide the average user?

I would expect that the average user would rather see the number of implemented
ports, because that is the number of ports that Linux will be able to use.
The device driver is not allowed to touch unimplemented ports, so why should
the print by the device driver include these?

If you want to see that, I think you can use tools to dump the HBA regs.

What caused me to write this patch in the first place was that someone was
surprised to see:

> before:
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
>
> after:
> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode

And I have to agree. Why report 24 ports?
We had a fixup that corrected the incorrect PI register to 0xf.
The print is there to provide information, but reporting that we have 24 ports
(instead of reporting 4 ports), causes more confusion to the user, rather than
providing userful information IMO.


Kind regards,
Niklas
