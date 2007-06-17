From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH] Add new ICH9M pci id (8086:2850) to ata_piix id list
Date: Sun, 17 Jun 2007 23:36:08 +0200
Message-ID: <4675A948.80007@googlemail.com>
References: <e4c519350706171423ldf77f77ve7080c213e6ec3fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:12785 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbXFQVgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jun 2007 17:36:35 -0400
Received: by py-out-1112.google.com with SMTP id a29so2728082pyi
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 14:36:34 -0700 (PDT)
In-Reply-To: <e4c519350706171423ldf77f77ve7080c213e6ec3fc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maurizio Monge <maurizio.monge@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jeff@garzik.org>

Hi,

Maurizio Monge pisze:
> To make ata_piix recognize my ich9m chip i had to apply the
> modification that follows.
> 
> Best regards
> Maurizio Monge
> 
> 
> diff -Nurb old/drivers/ata/ata_piix.c new/drivers/ata/ata_piix.c
> --- old/drivers/ata/ata_piix.c  2007-06-17 23:06:12.000000000 +0200
> +++ new/drivers/ata/ata_piix.c  2007-06-17 23:15:57.000000000 +0200
> @@ -243,6 +243,8 @@
>        { 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>        /* SATA Controller IDE (ICH9M) */
>        { 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +       /* Mobile SATA Controller IDE (ICH9M) */
> +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
                      ^^^^
http://pci-ids.ucw.cz/iii/?i=80862850

Is this really a SATA controller?
((ICH8M/ICH8M-E) IDE Controller)

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
