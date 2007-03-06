From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Marvell 6145 SATA via AHCI
Date: Tue, 6 Mar 2007 23:26:59 +0100
Message-ID: <200703062327.00195.jareguero@telefonica.net>
References: <22E26940476D1E48AA6F292B5316C9C337D0@bes1.peakin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:17221 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932388AbXCFW1P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 17:27:15 -0500
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C337D0@bes1.peakin.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "George T. Joseph (development)" <gtj.devel@peakin.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

El Martes, 6 de Marzo de 2007, escribi=F3:
> Jose, Thanks for the pointer to your patch.  The bit that disables ms=
i
> helped.
>
> Have either of you (or anyone else) tested with NCQ capable drives?
> With NCQ enabled, I can get no more than a few minutes out of a stres=
s
> test before one or more of the drives hang and disconnect.  This is w=
ith
> both WD2500JS and Seagate 7200.10 drives.  If I black list the drives=
 or
> add AHCI_FLAG_NO_NCQ to the Marvell port info entry the drives will p=
ass
> an 8 hour stress test without error.
>
> Thanks...george
>

I use it with a NCQ disk: seagate ST3120827AS Barracuda, but it is only=
 a 1.5=20
Gbps disk.

Jose Alberto
