From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Fri, 20 Jul 2007 00:17:14 +0100
Message-ID: <20070720001714.7b6aaf95@the-village.bc.nu>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54984 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755060AbXGSXKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 19:10:31 -0400
In-Reply-To: <ohu2n4-lcf.ln1@tux.abusar.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 18 Jul 2007 23:23:19 -0300
D=C3=A2niel Fraga <fragabr@gmail.com> wrote:

> Linux 2.6.22
> Intel(R) Celeron(R) CPU 2.26GHz
> 00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/=
B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> Reiserfs3
>=20
> 	I have 2 PATA HDs and they always worked perfectly with
> software (kernel) raid1 using the old IDE kernel drivers. Now I use
> the new libata drivers (VIA), and it keep giving those erros messages=
:
>=20
> attempt to access beyond end of device
> md1: rw=3D0, want=3D155284112, limit=3D155284096

Are their host protected areas on the two disks ?
