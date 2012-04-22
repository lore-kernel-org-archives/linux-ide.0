From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: libata: init ata_print_id to 0
Date: Sun, 22 Apr 2012 07:57:28 -0700
Message-ID: <CABE8wws+5xo5b2dzQQqgwT6DqfUb_WOxr+D7TFHTUMkm4o+y7w@mail.gmail.com>
References: <alpine.LFD.2.02.1204221136450.1947@terrop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24884 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab2DVO5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2012 10:57:30 -0400
Received: by bkcji2 with SMTP id ji2so278092bkc.25
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2012 07:57:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1204221136450.1947@terrop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tero Roponen <tero.roponen@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>

On Sun, Apr 22, 2012 at 1:38 AM, Tero Roponen <tero.roponen@gmail.com> =
wrote:
>
> When comparing the dmesg between 3.4-rc3 and 3.4-rc4 I found the
> following differences:
>
> =A0-ata1: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff100 irq=
 47
> =A0-ata2: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff180 irq=
 47
> =A0-ata3: DUMMY
> =A0+ata2: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff100 irq=
 47
> =A0+ata3: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff180 irq=
 47
> =A0ata4: DUMMY
> =A0ata5: DUMMY
> =A0-ata6: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff380 irq=
 47
> =A0+ata6: DUMMY
> =A0+ata7: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff380 irq=
 47
>
> The change of numbering comes from commit 85d6725b7c0d7e3f ("libata:
> make ata_print_id atomic") that changed lines like
>
> =A0 =A0 =A0 =A0ap->print_id =3D ata_print_id++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to
> =A0 =A0 =A0 =A0ap->print_id =3D atomic_inc_return(&ata_print_id);
>
> As the latter behaves like ++ata_print_id, we must initialize
> it to zero to start the numbering from one.
>
> Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
