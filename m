From: =?ISO-8859-2?Q?Pisch_Tam=E1s?= <pat-sp@freemail.hu>
Subject: DMA timeout error
Date: Fri, 30 Sep 2005 09:29:48 +0200 (CEST)
Message-ID: <freemail.20050830092948.81815@fm06.freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmx02.freemail.hu ([195.228.245.52]:39074 "HELO
	fmx02.freemail.hu") by vger.kernel.org with SMTP id S1030197AbVI3H3u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2005 03:29:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

I have four SATA disks, which I use in a RAID5 array. One
disk falls out from the RAID,
very often always with DMA timeout error. Always the same
disk, but I can recover the
RAID, so the disk isn't bad. I have a very similar server
configuration , and the
situation is similar to that. I think, maybe the falling out
disks have a little worse
physical parameters. I want to set them to a slower mode
than UDMA/133 (for example
UDMA/66), maybe it helps to prevent it from the error. My
question is: how can I do
that? I will modify the source code of the driver, if you
tell me, what I have to modify.
If you have a better idea about the solution, please let me
know. I use Debian Sarge.
I tried out both the built-in 2.4.27 and 2.6.8 kernels. I
tried out a lot of things, if
you need details, please ask me.
Thank you, in advance.

Best regards,

Tam=E1s Pisch.



_______________________________________________________________________=
_____
Ingyenes hirdet=E9s felad=E1s az [origo] apr=F3n!  M=E1r t=F6bb mint 18=
0.000 aj=E1nlat!
http://apro.origo.hu/
