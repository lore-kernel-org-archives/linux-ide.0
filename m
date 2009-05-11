From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Mon, 11 May 2009 14:20:33 +0100
Message-ID: <4A082621.7030008@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <200905082002.38487.bzolnier@gmail.com> <4A047718.2000707@inov.pt> <200905082055.29993.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010105030107080909090407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:37988 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZEKNVR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 09:21:17 -0400
In-Reply-To: <200905082055.29993.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105030107080909090407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


>>>>     
>>>>         
>>> Well, yes.  Though I hoped that you would at least give a try to fixing
>>> IDE core to program PIO0 initially for all host drivers that implement
>>> ->set_pio_mode method...
>>>   
>>>       
>> Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
>> Maybe with a little help, but I can try. You mean, when the host driver 
>> is registered (ide_host_register, or ide_host_add that later calls 
>> ide_host_register), maybe in the 'ide_init_port' method (sorry, I need 
>> some guidance here...) check if the 'set_pio_mode' method is 
>> implemented, and after initializing each port (d->init_hwif(hwif)) 
>> default it to PIO Mode 0, calling set_pio_mode method.
>>     
>
> ide_init_port() seems OK but I think that ide_port_init_devices()
> [it is called after ide_init_port()] would be a bit safer and more
> flexible (some host drivers may also require special ->init_dev
> setup first) and the check for ->set_pio_mode method presence can
> be done just before actually using the method, i.e.
>
> 	const struct ide_port_ops *port_ops = hwif->port_ops;
>
> 	if (port_ops && port_ops->set_pio_mode)
> 		port_ops->set_pio_mode(...)
>
>   

Ok, so the patch for this is attached in this e-mail.

Please confirm and make your comments.

Best regards,
João Ramos

-- 
************************************************************************

    João Ramos        <joao.ramos@inov.pt>

    INOV INESC Inovação - ESTG Leiria
    Escola Superior de Tecnologia e Gestão de Leiria
    Edíficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

************************************************************************


--------------010105030107080909090407
Content-Type: text/plain;
 name="set_pio_mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="set_pio_mode.patch"

Initially set PIO Mode 0 for all host drivers that use PIO transfer mode
(and export a 'set_pio_mode' method) before the IDE core figures out
the most suited PIO mode for the attached device.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

---

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..f92cac4 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1031,6 +1031,13 @@ static void ide_port_init_devices(ide_hwif_t *hwif)
 
 		if (port_ops && port_ops->init_dev)
 			port_ops->init_dev(drive);
+
+		/*
+		 * if driver uses PIO mode, default to PIO Mode 0 before we
+		 * figure out the most suited mode for the attached device
+		 */
+		if (port_ops && port_ops->set_pio_mode)
+			port_ops->set_pio_mode(drive, 0);
 	}
 }
 

--------------010105030107080909090407--
