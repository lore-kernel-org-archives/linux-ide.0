From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Via SATA not working here
Date: Sat, 05 Feb 2005 16:33:29 +0100
Message-ID: <4204E749.2070602@stesmi.com>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz> <4147331A.8040907@pobox.com> <41474D2F.6060201@wasp.net.au> <20050205150349.GB17295@uvt316-2.ruk.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:53932 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262264AbVBEPhU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 10:37:20 -0500
In-Reply-To: <20050205150349.GB17295@uvt316-2.ruk.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: Brad Campbell <brad@wasp.net.au>, Jeff Garzik <jgarzik@pobox.com>, Eric Mudama <edmudama@gmail.com>, f@uvt316-2.ruk.cuni.cz, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michal 'hramrach' Suchanek wrote:
| On Tue, Sep 14, 2004 at 11:57:35PM +0400, Brad Campbell wrote:
|
|>Jeff Garzik wrote:
|>
|>>ahhhhhh, that may be a clue.  If you are attaching a PATA drive via a
|>>bridge, that is very different from attaching a SATA drive, in terms of
|>>field behavior across the controller spectrum.
|>>
|>>There are limitations on bridges.  Does Brad Campbell's patch (attached)
|>>work for you?
|>>
|>
|>I doubt it, thats why I had him compile up and test on a 2.6.5 kernel :p(
|>Sounds like a similar but different incompatibility.
|>
|
| Hello again
|
| I thought I replied to this but I do not see the reply nor is 2.6.10
| working for me.
|
| Thanks for the patch, it works for me but I had to apply it manually to
| the newer kernel. I am not sure I got it right - when I unload ide-scsi
| I get a kernel panic but I did not try with an unpatched kernel.
|
| Also I wonder why sata is using the scsi emulation? Is it so different
| from pata?

It is not using scsi emulation. It is using the scsi subsystem in
the linux kernel instead of the ide subsystem. More and more
drivers are being written for "libata". And less and less in this
is actually SATA specific anymore. That is why we are starting
to see drivers that drive both sata and pata (promise for instance
in the libata-dev tree). Also note that if I understand correctly
libata will ultimately not use the scsi subsystem but the block
subsystem (that doesn't really exist yet). The way I see it
libata is the new way to do it right, and in which you can fit
any pata and/or sata driver. My personal goal is when we can
have one name-space between scsi and [sp]ata but that's not
here yet with many drivers only existing for the old/normal
ide susbystem, but that might/will change.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCBOdIBrn2kJu9P78RArDJAJ4+VOc7sG+CIIW3wznDfaHkPC7+KQCeJI46
O8AGbX8rvDgmmV0MjRh5tQo=
=Fu32
-----END PGP SIGNATURE-----
