From: Velu Erwan <erwan@seanodes.com>
Subject: Re: ATIIXP and libata
Date: Fri, 04 Nov 2005 10:16:57 +0100
Message-ID: <436B2709.1080803@seanodes.com>
References: <436AA2EA.2040508@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:183 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1161115AbVKDJRJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 04:17:09 -0500
In-Reply-To: <436AA2EA.2040508@yahoo.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org

Bruno Harbulot a =E9crit :

> Hello,
>
>
> I am trying to make a SATA drive work (fast) on an Asus Pundit-R=20
> (P4R8L motherboard).
> I have tried the patch posted on linux-ide by Erwan Velu on 10/10/05.=
 It
> works and hdparm indicates about 55MB/s (thanks Erwan).
>
Glad to see my patch usefull to someone else :b

> However, Erwan's patch relies on testing the name of the pci device, =
in
> drivers/ide/pci/atiixp.c:
> if (strncmp(drive->name,"hdc",strlen("hdc")) =3D=3D 0)
>
> This solution is obviously not very generic. (Perhaps I should say th=
at,
> at least in my case, hda is a DVD drive on the IDE connector and hdc =
is
> the SATA drive). As Bartlomiej Zolnierkiewicz replied to Erwan's
> message, using libata's ata_id_is_sata would probably be a better rou=
te.
>
I've asked the guy from ati about this issue but still no answer.
My main question was "Does the sata port of the atiixp 200 chipset=20
always assigned to hdc or not ?"
If yes, my patch is good and generic to this chipset because I'm=20
checking first the pci id of the chipset.
If no, we must found a better way isn't it ?

[...]

>
>
>
> I have also got another similar problem with this controller, which=20
> may or may not be related. This problem is more or less point number =
3=20
> of:
> <http://www.debian.org/devel/debian-installer/errata>
> ("SATA driver can block access to CD drive in installations from CD")=
=2E
> When installing this machine, the hard drive and the DVD drive were
> "conflicting", so I had to load a much as I could from the install CD

[...]

Could you please try putting your dvd drive as slave by setting up the=20
jumper on it ? It will be then detected has hdb (my configuration) and=20
should works.
