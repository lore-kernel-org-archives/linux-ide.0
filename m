From: Jeff Garzik <jeff@garzik.org>
Subject: Re: The never enfind DRDY saga
Date: Thu, 08 May 2008 19:20:58 -0400
Message-ID: <48238ADA.5060206@garzik.org>
References: <20080509005111.7cf55350@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49399 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbYEHXVB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 May 2008 19:21:01 -0400
In-Reply-To: <20080509005111.7cf55350@werewolf.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: Linus-IDE <linux-ide@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>

J.A. Magall=F3n wrote:
> Hi all...
>=20
> I'm getting again my friendly DRDY errors, this time on the new disk =
I got
> to replace the old one (that fortunately was still under warranty...)=
=2E
> This is a brand new disk, it came perfectly packaged...
> Now it is not a Seagate, but a WD:

Note that DRDY is not an error:

	http://ata.wiki.kernel.org/index.php/Libata_error_messages

But moreover, for Serial ATA, timeouts are generally due to platform=20
problems, irq problems, or driver problems.  When we see timeouts, we=20
generally do not look at the hard drive as the primary cause.

Have you gone through the debugging process for irq problems -- turning=
=20
off ACPI, noapic, etc.?

	Jeff


