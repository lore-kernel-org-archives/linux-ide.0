From: Adko Branil <adkobranil@yahoo.com>
Subject: HDD problem
Date: Tue, 7 Aug 2012 11:44:55 -0700 (PDT)
Message-ID: <1344365095.44831.YahooMailNeo@web124702.mail.ne1.yahoo.com>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm14-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.38]:34215 "HELO
	nm14-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751236Ab2HGSuV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2012 14:50:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, I have a disk problem, i suppose, as during boot, the system som=
e times freezes with "kernel pannic" and some times boots normally.

In this is peace from the log:

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Jun 16 14:41:00 b kernel: libata version 1.20 loaded.=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=20
Jun 16
 14:41:00 b kernel: sata_promise 0000:00:08.0: version 1.03=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Jun 16 14:41:00 b kernel: sata_via 0000:00:0f.0: version 1.1=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
Jun 16 14:41:00 b kernel: ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:40=
03 85:3469 86:3c01 87:4003 88:407f=A0=A0=A0=A0=A0=A0=A0=A0=20
Jun 16 14:41:00 b kernel: sda: Mode Sense: 00 3a 00
 00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Jun 16 14:41:00 b kernel: sda: Mode Sense: 00 3a 00 00=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0

can You just tell me the meaning of this "sda: Mode Sense: 00 3a 00 00"=
 ?
Nothing else interesting i havent seen in logs, but when googled for th=
is "mode sense", all the docs i have fount was related to disk problems=
=2E


Thanks in advance !
Best regards !

