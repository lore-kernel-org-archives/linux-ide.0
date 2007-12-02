From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 22:49:00 -0500
Message-ID: <47522B2C.2010205@rtr.ca>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu> <475110A8.5090709@clear.net.nz> <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com> <4751B3DA.6030508@clear.net.nz> <4751BDA4.9080102@rtr.ca> <4751C6DA.3080409@garzik.org> <4751F482.60204@clear.net.nz> <47522A45.50706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2698 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbXLBDtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 22:49:01 -0500
In-Reply-To: <47522A45.50706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Oh, more fiction:

> Because SATA uses point-to-point connectivity, the scaling
> available with SAS controllers is not possible with SATA
> controllers. SATA drives must be connected on a one-to-one
> basis with the SATA connectors on the controller =96 i.e, a fourport
> SATA controller can connect up to four drives, an eight-port
> SATA controller can connect up to eight drives, etc. This means
> that the number of drives needed must be known prior to
> purchasing a SATA controller, or additional hardware costs will
> be incurred.

Ignoring port multipliers (hubs) again there.

A SATA hub can connect up to 31 drives to a single SATA port,
or up to 248 drives per 8-port PCI(X/e) controller card.

I don't know if anyone currently sells a 31-port multiplier, though.

Cheers

