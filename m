From: yong Jung <yong_jk@yahoo.com>
Subject: libata seems doesn't work on SATA, F7
Date: Thu, 14 Jun 2007 05:21:58 +0900 (KST)
Message-ID: <723467.25172.qm@web54501.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54501.mail.re2.yahoo.com ([206.190.49.151]:39619 "HELO
	web54501.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754134AbXFMU2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jun 2007 16:28:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,
=2E
We want to see and erase hpa on FC7 for SATA hdd.
So added libata option on Grub and modprobe.conf.
We can see the HPA detection message on dmesg and
/var/log/messages.
But the setmax.c doesn't work to change max address.
Also "dd" command covering hpa are doesn't work
anymore. The process never ends.
I doubt that libata support SATA to disable hpa which
is said like the below.

>Please give it a test by booting it, and look >for
"Host Protected Area detected." If you're >feeling
brave, boot with "libata.ignore_hpa=3D1" to >disable the
host protected area (which should >enable your whole
disk).
=2E
Best regards,
Nobel


      ________________________________________________________=20
180=B5=B5 =B4=DE=B6=F3=C1=F8 =BE=DF=C8=C4! =B8=DE=C0=CF - =BF=A9=B7=AF =
=B0=B3=C0=C7 =B8=DE=BD=C3=C1=F6=B8=A6 =B5=BF=BD=C3=BF=A1 =C8=AE=C0=CE? =
=BB=F5=B7=CE=BF=EE =BE=DF=C8=C4! =B8=DE=C0=CF=C0=C7 =C5=C7=C0=B8=B7=CE =
=B0=A1=B4=C9=C7=D8=C1=FD=B4=CF=B4=D9.
http://kr.content.mail.yahoo.com/cgland
