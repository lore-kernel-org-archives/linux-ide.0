From: =?ISO-8859-2?Q?Pisch_Tam=E1s?= <pischta@freemail.hu>
Subject: problem with an SX4-M card
Date: Fri, 17 Jun 2005 14:22:02 +0200 (CEST)
Message-ID: <freemail.20050517142202.75811@fm1.freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmx6.freemail.hu ([195.228.242.226]:23309 "HELO
	fmx6.freemail.hu") by vger.kernel.org with SMTP id S261246AbVFQMWP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jun 2005 08:22:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I have problem with my SX4-M SATA RAID card , under Debian
Sarge. I connected 4 120GB
Samsung HDD to it, and configured them to RAID5 in its BIOS.
I created the RAID, and formatted
it with XFS (I tried it with JFS, and EXT3 too, but dbench
generated error messages immediately,
when it started). I run dbench and it worked, several times.
But after reboot and mount, when I
tried to run dbench again I got error messages (it was
different from which I got with JFS and
EXT3). If you need the error messages, I will have generated
the error messages and send them to
you. I didn't find error messages about it in the log files,
but I will send info if you need.
I tried to boot with the standard kernel shipped with
Debian, and with my own compiled
kernel-version too, but with the same result.
Do you have any idea about the matter of this error?
Please tell me, what are the mandatory, and what are the
proposed settings in the card's bios.
Thank you, in advance.

Best regards,

Tam=E1s Pisch.


