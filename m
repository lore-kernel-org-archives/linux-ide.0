From: Pedro Francisco <pedrogfrancisco@gmail.com>
Subject: Re: ahci rmmodable and shouldn't
Date: Sun, 19 Sep 2010 11:28:26 +0100
Message-ID: <1284892106.2650.4.camel@sundae-v2>
References: <201009162256.04765.pedrogfrancisco@gmail.com>
	 <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net>
	 <4C933A8F.2080305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55939 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab0ISK2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2010 06:28:41 -0400
In-Reply-To: <4C933A8F.2080305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sex, 2010-09-17 at 11:53 +0200, Tejun Heo wrote:
> Just don't rmmod a module which is serving a live filesystem.  Why
> does it even matter?
>=20

=2E.. Ok, let me argue another way. What if my mail was called: =C2=ABl=
smod
shows false values ("Used by: 0") for module 'ahci'=C2=BB, would you ag=
ree it
was an error and should therefore be fixed?

--=20
Pedro

