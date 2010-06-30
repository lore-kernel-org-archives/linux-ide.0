From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Subject: Re: [PATCH]ata:ahci.c Fix warning: comparison between 'enum
	<anonymous>' and 'enum <anonymous>'
Date: Wed, 30 Jun 2010 08:11:18 +0200
Message-ID: <AANLkTinetp4EnDl_O89pvccbJnuzRRQc5FHDX3-P3-Jv@mail.gmail.com>
References: <1277866406-8253-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40414 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0F3GLT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 02:11:19 -0400
Received: by fxm14 with SMTP id 14so151586fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 23:11:18 -0700 (PDT)
In-Reply-To: <1277866406-8253-1-git-send-email-justinmattock@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, tj@kernel.org

On 30 June 2010 04:53, Justin P. Mattock <justinmattock@gmail.com> wrot=
e:
> - =C2=A0 =C2=A0 =C2=A0 int n_ports, i, rc;
> + =C2=A0 =C2=A0 =C2=A0 int n_ports, i, rc, sum =3D 32;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0VPRINTK("ENTER\n");
>
> - =C2=A0 =C2=A0 =C2=A0 WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
> + =C2=A0 =C2=A0 =C2=A0 WARN_ON(ATA_MAX_QUEUE > sum);

Should'nt that rather be

       int n_ports, i, rc, sum =3D AHCI_MAX_CMDS;

?

BR H=C3=A5kon L=C3=B8vdal
