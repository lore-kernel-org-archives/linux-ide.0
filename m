From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Thu, 19 Jul 2007 23:38:24 -0300
Message-ID: <0qj5n4-uh5.ln1@tux.abusar.org>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
	<20070720001714.7b6aaf95@the-village.bc.nu>
	<k0c5n4-dl4.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbXGTCi5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 22:38:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBiOG-0005CY-JQ
	for linux-ide@vger.kernel.org; Fri, 20 Jul 2007 04:38:48 +0200
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 04:38:48 +0200
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 04:38:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, 19 Jul 2007 21:25:24 -0300
D=E2niel Fraga <fragabr@gmail.com> wrote:

> 	Thank you very much.

	Neil Brown from raid mailing-list asked me to:

fraga@abusar ~$ sudo od -D -j 65536 -N 4 /dev/md1
Password:
0200000   19410528
0200004

	Then multiply 19410528 by 4 which is equal to 77642112.

	As 77642112 is higher than 77642048 (from mdadm -D /dev/md1:
array size), reiserfs thinks the device is bigger than what it really
is. Does it help? Thanks.

	Ps: the difference is small: 77642112 - 77642048 =3D 64

--=20
Linux 2.6.22: Holy Dancing Manatees, Batman!
http://www.lastfm.pt/user/danielfraga
http://u-br.net
Exodus - "I Am Abomination" (Shovel Headed Kill Machine - 2005)

