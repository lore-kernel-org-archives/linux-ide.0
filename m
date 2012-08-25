From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sat, 25 Aug 2012 13:33:01 +0200
Message-ID: <20120825113301.GA15210@liondog.tnic>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39141 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab2HYLdF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Aug 2012 07:33:05 -0400
Content-Disposition: inline
In-Reply-To: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adko Branil <adkobranil@yahoo.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Aug 24, 2012 at 06:31:11PM -0700, Adko Branil wrote:
> To add some more info - i just noticed in dmesg of the latest kernel-=
2.5.2 some suspicious lines:
>=20
> 	* [ =C2=A0 44.251706] microcode: AMD CPU family 0xf not supported
> 	* [ =C2=A0 44.255721] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual=
 Core Processor 4200+ (2 cpu cores) (version 2.20.00)
> 	* [ =C2=A0 44.255736] [Firmware Bug]: powernow-k8: No compatible ACP=
I _PSS objects found.
> 	* [ =C2=A0 44.255736] [Firmware Bug]: powernow-k8: Try again with la=
test BIOS.
>=20
> Coult it be related to the crashes , and should i update my bios ?

No.

Try to enable the Cool'n'Quiet option in your BIOS - this message shoul=
d
disappear then.

Btw, there's a patch to make this more understandable:

http://marc.info/?l=3Dlinux-kernel&m=3D134262430326493

Rafael, this one is queued for 3.7, I assume?

Thanks.

--=20
Regards/Gruss,
    Boris.
