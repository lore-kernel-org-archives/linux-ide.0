From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Sun, 02 Sep 2007 13:11:05 +0100
Message-ID: <46DAA859.5000804@genesi-usa.com>
References: <46DA13E2.7090405@gmail.com> <46DAA15C.4060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3588 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964789AbXIBMJd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 08:09:33 -0400
In-Reply-To: <46DAA15C.4060505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex <lex.garcia@gmail.com>
Cc: linux-ide@vger.kernel.org

I think Debian updated the shutdown utility in experimental/testing alr=
eady
(and Gentoo seems to have a patch in portage, but it's masked). Every d=
istro
is doing a different thing, but none of the support is anything people =
are
going to push to the current set of systems.

Part of the problem is everyone is basing "last year"'s distros off "la=
st
year"'s kernels (2.6.18, 2.6.19, 2.6.20) which do not have the shutdown
changes. If you update to the very latest kernel, you are in fact on yo=
ur
own.

Ubuntu Gutsy (about a month away), openSUSE 10.3 (about a month away) a=
nd
the next Fedora Core work fine, as they have a need to (affected kernel
and userland combination) but current distros like Etch, Hoary, 10.2 an=
d
=46edora Core 7 just have no reason to update for the vast majority of
users and their unaffected standard kernels.

--=20
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alex wrote:
> I'm sorry, but another time the message appears, I don't understand,=20
> sorry but the shutdown isn't updated at Debian.
>=20
> Alex
> http://counter.li.org/cgi-bin/certificate.cgi/411619
>=20
> Alex escribi=C3=B3:
>> Hi!
>>
>> I'm Debian Linux distro user and when my computer go down it was=20
>> saying to update my shutdown utility and this url:=20
>> http://linux-ata.org/shutdown.html
>>
>> I wrote this e-mail to you to inform that when I update the Debian=20
>> distro yesterday (01-Sep-2007) the message disappears, if I'm not=20
>> wrong Debian distro have now update the shutdown. If you confirm my=20
>> words, can you update the part of the web that say there isn't any=20
>> distro updated yet? Debian's user will be happy to update they=20
>> distro's simply with apt-get utility ;)
>>
>> Thanks!
>>
>> Alex
>> http://counter.li.org/cgi-bin/certificate.cgi/411619
>>
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
