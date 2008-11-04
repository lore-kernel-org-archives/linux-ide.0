From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: Odd behaviour of device in response to idleimmediate with
 unload
Date: Tue, 4 Nov 2008 19:54:38 +0100
Message-ID: <20081104185444.3BE721FDF7@chi.die-welt.net>
References: <871vxrzssj.fsf@denkblock.local>
	<491026AB.1090704@kernel.org>
	<20081104123211.A86321FD5A@chi.die-welt.net>
	<49108120.6000205@rtr.ca>
	<491083CC.5050508@rtr.ca>
	<49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__4_Nov_2008_19_54_38_+0100_fBPW/Taqs1dBXwc2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chi.die-welt.net ([84.246.123.210]:34813 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbYKDSyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 13:54:50 -0500
In-Reply-To: <491090BC.5060403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

--Signature=_Tue__4_Nov_2008_19_54_38_+0100_fBPW/Taqs1dBXwc2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2008 13:13:16 -0500 Mark Lord wrote:

> Okay, hdparm-9.3 is now out in the wild (sourceforge),
> and has  --idle-immediate and --idle-unload  flags now,
> so it can be used to help debug/test this problem.

Okay, got it, built it.
Neither --idle-immediate nor --idle-immediate brings up the reset,
echo 1000 > /sys/block/sda/device/unload_heads does.

Regards
Evgeni, puzzled.

--Signature=_Tue__4_Nov_2008_19_54_38_+0100_fBPW/Taqs1dBXwc2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkQmm4ACgkQJKAUGKwVtQwcLgCfX/v6SH9w1GQKfxNxjHEIkXbs
QNgAn1DNGEcu6DXnk/lhzqVOdtdSgRya
=14TY
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Nov_2008_19_54_38_+0100_fBPW/Taqs1dBXwc2--
