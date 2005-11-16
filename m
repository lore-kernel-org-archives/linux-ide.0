From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ata_port->device[] question
Date: Wed, 16 Nov 2005 16:13:14 +0100
Message-ID: <58cb370e0511160713l1f888d8bhe7d9433c744f67e9@mail.gmail.com>
References: <Pine.LNX.4.58.0511151328070.28745@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:45874 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030362AbVKPPNP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Nov 2005 10:13:15 -0500
Received: by nproxy.gmail.com with SMTP id k26so348653nfc
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 07:13:14 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0511151328070.28745@shark.he.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 11/15/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>
> libata-core.c, around line 1299, says:
>
> static inline u8 ata_dev_knobble(const struct ata_port *ap)
> {
>         return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
> }
>
> That's the same as this: (right?)
>
>         return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device[0]->id)));
>                                                                         ~~~
>
> and is this intentional?
> I.e., always using device[0] for this bridge check?

Yes, this is only valid for SATA (=> only primary device).

Bartlomiej
