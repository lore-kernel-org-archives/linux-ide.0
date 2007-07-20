From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Fri, 20 Jul 2007 16:37:09 +0100
Message-ID: <20070720163709.04e5999c@the-village.bc.nu>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
	<20070720001714.7b6aaf95@the-village.bc.nu>
	<k0c5n4-dl4.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35019 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765531AbXGTPax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 11:30:53 -0400
In-Reply-To: <k0c5n4-dl4.ln1@tux.abusar.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 19 Jul 2007 21:25:24 -0300
D=C3=A2niel Fraga <fragabr@gmail.com> wrote:

> On Fri, 20 Jul 2007 00:17:14 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>=20
> > Are their host protected areas on the two disks ?
>=20
> 	I don't know, but hdparm returns this:

Ok try booting with

	libata.ignore_hpa=3D1

Alan
