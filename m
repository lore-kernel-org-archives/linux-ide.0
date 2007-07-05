From: yong Jung <yong_jk@yahoo.com>
Subject: "libata ignore_hpa=1" doesn't wok on SATA ?
Date: Thu, 5 Jul 2007 09:00:47 +0900 (KST)
Message-ID: <932011.56083.qm@web54504.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54504.mail.re2.yahoo.com ([206.190.49.154]:28947 "HELO
	web54504.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757543AbXGEAAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 20:00:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
=2E
I would like to see the whole disk area and erase the
hpa area in my desktop.
At first I tried "setmax.c" program but it didn't work
on SATA at least.
So I upgraeded it to FC7 and added "libata
ignore_hpa=3D1" option on boot command and
/etc/modprobe.conf.=20
This option was accepted but still the kernel couldn't
see the whole disk area even after reboot.
I am using FC7, kernel-2.6.21 and 250 SATA disk.
Could you please give me some more tips ?
=2E
Warm regards,
Nobel



      ________________________________________________________=20
180=B5=B5 =B4=DE=B6=F3=C1=F8 =BE=DF=C8=C4! =B8=DE=C0=CF - =BF=A9=B7=AF =
=B0=B3=C0=C7 =B8=DE=BD=C3=C1=F6=B8=A6 =B5=BF=BD=C3=BF=A1 =C8=AE=C0=CE? =
=BB=F5=B7=CE=BF=EE =BE=DF=C8=C4! =B8=DE=C0=CF=C0=C7 =C5=C7=C0=B8=B7=CE =
=B0=A1=B4=C9=C7=D8=C1=FD=B4=CF=B4=D9.
http://kr.content.mail.yahoo.com/cgland
