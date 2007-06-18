From: "Maurizio Monge" <maurizio.monge@gmail.com>
Subject: Re: [PATCH] Add new ICH9M pci id (8086:2850) to ata_piix id list
Date: Mon, 18 Jun 2007 05:40:00 +0200
Message-ID: <e4c519350706172040x2ee3474bw3f7a618352921b22@mail.gmail.com>
References: <e4c519350706171423ldf77f77ve7080c213e6ec3fc@mail.gmail.com>
	 <4675A948.80007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:56799 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXFRDkC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jun 2007 23:40:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1307800ugf
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 20:40:00 -0700 (PDT)
In-Reply-To: <4675A948.80007@googlemail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jeff@garzik.org>

Well, you are probably right, it is probably just an ide controller, i
have an acer laptop (tm5720) and to make work the hd the driver ahci
was required, and my patch made work the dvd-rw too.
If so, maybe some other delegate is better for this controller than
"ich8_sata_ahci", but please consider that i am very ignorant about
this driver and i simply posted this patch beacuse it made work my
device.
If there is any test that i can do to sort out this just let me know.

On 6/17/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> Maurizio Monge pisze:
> > To make ata_piix recognize my ich9m chip i had to apply the
> > modification that follows.
> >
> > Best regards
> > Maurizio Monge
> >
> >
> > diff -Nurb old/drivers/ata/ata_piix.c new/drivers/ata/ata_piix.c
> > --- old/drivers/ata/ata_piix.c  2007-06-17 23:06:12.000000000 +0200
> > +++ new/drivers/ata/ata_piix.c  2007-06-17 23:15:57.000000000 +0200
> > @@ -243,6 +243,8 @@
> >        { 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> >        /* SATA Controller IDE (ICH9M) */
> >        { 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> > +       /* Mobile SATA Controller IDE (ICH9M) */
> > +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>                       ^^^^
> http://pci-ids.ucw.cz/iii/?i=80862850
>
> Is this really a SATA controller?
> ((ICH8M/ICH8M-E) IDE Controller)
>
> Regards,
> Michal
>
> --
> LOG
> http://www.stardust.webpages.pl/log/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Ciao
Maurizio
http://stregatto.wordpress.com

"Well we all shine on
Like the moon and the stars and the sun" (John Lennon)
