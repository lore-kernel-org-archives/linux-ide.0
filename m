From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATIIXP and libata
Date: Fri, 4 Nov 2005 11:09:15 +0100
Message-ID: <58cb370e0511040209hfa1545bke6d5dc0e7c7cee7e@mail.gmail.com>
References: <436AA2EA.2040508@yahoo.co.uk> <436B2709.1080803@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:23498 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161132AbVKDKJT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 05:09:19 -0500
Received: by nproxy.gmail.com with SMTP id q29so80674nfc
        for <linux-ide@vger.kernel.org>; Fri, 04 Nov 2005 02:09:15 -0800 (PST)
In-Reply-To: <436B2709.1080803@seanodes.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Velu Erwan <erwan@seanodes.com>
Cc: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>, linux-ide@vger.kernel.org

On 11/4/05, Velu Erwan <erwan@seanodes.com> wrote:
> Bruno Harbulot a =E9crit :
>
> > Hello,
> >
> >
> > I am trying to make a SATA drive work (fast) on an Asus Pundit-R
> > (P4R8L motherboard).
> > I have tried the patch posted on linux-ide by Erwan Velu on 10/10/0=
5. It
> > works and hdparm indicates about 55MB/s (thanks Erwan).
> >
> Glad to see my patch usefull to someone else :b
>
> > However, Erwan's patch relies on testing the name of the pci device=
, in
> > drivers/ide/pci/atiixp.c:
> > if (strncmp(drive->name,"hdc",strlen("hdc")) =3D=3D 0)
> >
> > This solution is obviously not very generic. (Perhaps I should say =
that,
> > at least in my case, hda is a DVD drive on the IDE connector and hd=
c is
> > the SATA drive). As Bartlomiej Zolnierkiewicz replied to Erwan's
> > message, using libata's ata_id_is_sata would probably be a better r=
oute.
> >
> I've asked the guy from ati about this issue but still no answer.
> My main question was "Does the sata port of the atiixp 200 chipset
> always assigned to hdc or not ?"

If the controller is using I/O ports other than legacy ISA
ones (0x170 and 0x1f0) and you have other controllers
naming will be dependent on order in which you load
IDE host drivers.  Plus we don't want naming to be
hard-coded in the kernel.

Bartlomiej
