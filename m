From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: maintenence sata_sis
Date: Mon, 22 Aug 2005 13:48:25 +0200
Message-ID: <m3k6iechva.fsf@anduin.mandrakesoft.com>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>
	<4309A268.8090203@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751178AbVHVWL2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:11:28 -0400
Received: from anduin.mandrakesoft.com (ezoffice.mandriva.com [84.14.106.134])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MBjkQs005267
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 04:45:49 -0700
In-Reply-To: <4309A268.8090203@gmx.net> (Uwe Koziolek's message of "Mon, 22
 Aug 2005 12:01:12 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Rainer.Koenig@fujitsu-siemens.com

Uwe Koziolek <uwe.koziolek@gmx.net> writes:

> Hello Jeff,
Hi

>
> currently it exists 3 variants to support the SiS182 Chipset
> - use SiS182 with the code from SiS180, only add the PCI-ID to the driver

Adding only the pci-id is not a good solution as the registers of the
second sata port have differents addresses than the one of the SiS180
chipset. To sum-up, with this patch, only the first port will work.

> - the source code from OSDL
> - the source code from www.sis.com

Jeff issued some comments about their patch for adding the support of
the SiS182.


Regards,
Arnaud

