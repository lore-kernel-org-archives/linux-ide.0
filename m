From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 12 May 2009 20:57:52 +0400
Message-ID: <4A09AA90.30906@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <200905082002.38487.bzolnier@gmail.com> <4A047718.2000707@inov.pt> <200905082055.29993.bzolnier@gmail.com> <4A082621.7030008@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11564 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752581AbZELQ5R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 12:57:17 -0400
In-Reply-To: <4A082621.7030008@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Jo=E3o Ramos wrote:

>>>> Well, yes.  Though I hoped that you would at least give a try to f=
ixing
>>>> IDE core to program PIO0 initially for all host drivers that imple=
ment
>>>> ->set_pio_mode method...

>>> Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
>>> Maybe with a little help, but I can try. You mean, when the host=20
>>> driver is registered (ide_host_register, or ide_host_add that later=
=20
>>> calls ide_host_register), maybe in the 'ide_init_port' method (sorr=
y,=20
>>> I need some guidance here...) check if the 'set_pio_mode' method is=
=20
>>> implemented, and after initializing each port (d->init_hwif(hwif))=20
>>> default it to PIO Mode 0, calling set_pio_mode method.

>> ide_init_port() seems OK but I think that ide_port_init_devices()
>> [it is called after ide_init_port()] would be a bit safer and more
>> flexible (some host drivers may also require special ->init_dev
>> setup first) and the check for ->set_pio_mode method presence can
>> be done just before actually using the method, i.e.

>>     const struct ide_port_ops *port_ops =3D hwif->port_ops;

>>     if (port_ops && port_ops->set_pio_mode)
>>         port_ops->set_pio_mode(...)

> Ok, so the patch for this is attached in this e-mail.

> Please confirm and make your comments.

> Best regards,
> Jo=E3o Ramos

> ---------------------------------------------------------------------=
---
>=20
> Initially set PIO Mode 0 for all host drivers that use PIO transfer m=
ode

    All drivers have to use the PIO mode (at least to transfer the task=
file=20
-- and for some PIO only commands too).

> (and export a 'set_pio_mode' method)

    s/export/have/

> before the IDE core figures out
> the most suited PIO mode for the attached device.

> Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

    Alan is hardly much interested in the IDE patches. :-)

> ---

> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 7f264ed..f92cac4 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -1031,6 +1031,13 @@ static void ide_port_init_devices(ide_hwif_t *=
hwif)
> =20
>  		if (port_ops && port_ops->init_dev)
>  			port_ops->init_dev(drive);
> +
> +		/*
> +		 * if driver uses PIO mode,

    This passage is pointless.

> default to PIO Mode 0 before we
> +		 * figure out the most suited mode for the attached device
> +		 */
> +		if (port_ops && port_ops->set_pio_mode)
> +			port_ops->set_pio_mode(drive, 0);
>  	}
>  }
> =20

MBR, Sergei
