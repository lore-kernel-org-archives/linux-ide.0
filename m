From: =?ISO-8859-1?Q?Yann_Le_Doar=E9?= <yledoare@free.fr>
Subject: new option : ide-scsi only for CD-writers ?
Date: Mon, 25 Nov 2002 09:43:36 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3DE1F0C8.6070404@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mel-rta8.wanadoo.fr (193.252.19.79) by mel-rto4.wanadoo.fr (6.5.007)
        id 3DDA133F003B02F0 for linux-ide@vger.kernel.org; Mon, 25 Nov 2002 11:20:01 +0100
Received: from free.fr (193.250.155.94) by mel-rta8.wanadoo.fr (6.5.007)
        id 3DD0D42700779771 for linux-ide@vger.kernel.org; Mon, 25 Nov 2002 11:20:01 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi !

I have a project : http://linuxconsole.free.fr where I am using Linux t=
o=20
boot on CD then use mutimedia apps & games.

Options (ex networks, games prefs & backups) can be saved by burning ne=
w=20
session on CD.

My problem is :  with ATAPI CD-writers, there are not other choices tha=
n=20
precise where is the CD-writer at boot prompt, ie which device uses SCS=
I=20
emulation (/dev/hddb, /dev/hdc or /dev/hdd).

It would be better if automaticaly only the CD-Writer had  ide-scsi=20
module enabled.

So my question : is it a good idea to make a new option for ide module=20
that use "ide-scsi" only with CD-writers devices ?

(I could write a patch)

Thanks.

Yann Le Doar=E9, France


