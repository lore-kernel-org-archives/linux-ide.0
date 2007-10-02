From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Promise SATA300 TX4: errors, oops in ext3 code
Date: Tue, 02 Oct 2007 11:08:46 +0200
Message-ID: <47020A9E.6090602@anagramm.de>
References: <47009BF6.5000208@lxnt.info> <4700B966.1030508@anagramm.de> <4701CAA9.6070902@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60602 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbXJBJIs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 05:08:48 -0400
In-Reply-To: <4701CAA9.6070902@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alexander Sabourenkov schrieb:
 >> Have you checked your memory already (memtest86)?
 > [...]
 >> Again... sounds like bad memory to me.
 > Nightly memtest86  run : 11 hours, 23 passes, 0 errors.

Okay, I have no idea about any bugs there.
You have several options: Find a 100% working vanilla kernel for your
problem (minimal configuration, skip i.e. the sound stuff, ...).
And then git bisect with a known bad kernel.

Same thing in hardware: move components (Controllers + HDD) to/from a w=
orking
machine and verify...

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Stra=C3=9Fe 45/1
Linhof Werksgel=C3=A4nde
D-81379 M=C3=BCnchen
Tel.089-741518-50
=46ax 089-741518-19
http://www.anagramm-technology.com
