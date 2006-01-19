From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 08:21:50 +0100
Message-ID: <200601190821.51702.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <200601181536.16868.pvrusb2@toplitzer.net> <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:37266 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1161080AbWASHV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 02:21:59 -0500
In-Reply-To: <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net


Ok. I found another possible reason, did I?

I read in several forums that HLT in KT333 chipsets
of VIA is not enough to get the processor in powersafe
and to disconnect from the FSB. You need to issuse
the STPGNT command which also needs first
to set some registers (because it degrades overall performance and
so it's normaly disabled by BIOS).
http://www.planet3dnow.de/vbulletin/archive/index.php/t-80854.html
(German)

It's called "Disconnect Enable when STPGNT Detected". And may cause
other problems like sound distortion etc. because of high fluctuation
in power current.

There should also be a simmilar register for the HLT command. ???

http://www.rhcf.com/sis-bin/ultimatebb.cgi?ubb=3Dget_topic;f=3D7;t=3D00=
0078;p=3D0
VIA KT266/KT266A/KM266/KM266A/KT333
Rx92[bit 7 =E2=80=93 enable] =3D Disconnect Enable When STPGNT Detected
Rx95[bit 1 =E2=80=93 enable] =3D HALT Command Detect
offset 92 set to E8 or E9

VIA KT333CF/KT400/KT400A/KM400/KM400A/KT600
RxD2[bit 7 =E2=80=93 enable] =3D Disconnect Enable When STPGNT Detected
RxD5[bit 1 =E2=80=93 enable] =3D HALT Command Detect
offset D2 set to E8 or E9

Does this help?
Helmut

--=20
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
