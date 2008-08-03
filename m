From: Tejun Heo <tj@kernel.org>
Subject: Re: Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 03 Aug 2008 12:27:41 +0900
Message-ID: <489525AD.1090903@kernel.org>
References: <529436.20310.qm@web26202.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030609020600050300060405"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43652 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYHCD2R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Aug 2008 23:28:17 -0400
In-Reply-To: <529436.20310.qm@web26202.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609020600050300060405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Sébastien wrote:
> Here's attached file of config 2.6.27-rc1 and System-map 2.6.27-rc1
> and lspci -nn and dmesg before mount and after mount (-t udf /dev/sr0
> fool)
> 
> I re-compile a fresh kernel : HW Bug re-appear. It had been
> diseappered with 2.6.26 and re-appeared with that new fresh kern
> 2.6.27-rc1 : perhaps a mistaken comipile option. However with that
> 2.6.26, HW Bug only disappeared when "Native IDE" was set in Bios
> SATA OnChip option.

That message is harmless and it showing up or not probably means your
controller is behaving slightly differently and is most likely random.
As long as the detection works out, it's okay.  Maybe we need to make
the message friendlier.

> Changed nearly nothing when compiling that new kern, i.e. :
> 
> make mrproper make menuconfig
> 
> --> Change Generic x86_64 to Opteron/Athlon64/Hammer/K8
> 
> --> Exit
> 
> then, make-kpg with initrd enabled.
> 
> I was pretty sure that the trouble would still appear with
> 2.6.27-rc1, but didn't exept HW Bug again. error message is part of
> diff before-mount after-mount, i.e. : end_request: I/O error, dev
> sr0, sector 11697200

Hmm.. Strange, no ATA error message nor past the end of the device
message.  I wonder where that error comes from.  Is the DVD accessible
at all after mounting?  We had several UDF related reports and IIRC
those haven't been resolved.  Maybe you're seeing the same problem.

> You can have an ssh -l root on that Debian unstable GNU/linux box if
> it can help you.

Yeah, I'm attaching my public key.  Please send me the login information.

Thanks.

-- 
tejun

--------------030609020600050300060405
Content-Type: application/pgp-keys;
 name="pgpkeys.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pgpkeys.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.9 (GNU/Linux)

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
=GtDh
-----END PGP PUBLIC KEY BLOCK-----

--------------030609020600050300060405--
