From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA Port on PDC20378 (FastTrak 378/SATA 378) (rev 02) Asus K8V
 Deluxe
Date: Wed, 02 Feb 2005 05:00:12 -0500
Message-ID: <4200A4AC.8020009@pobox.com>
References: <4200A27E.2070401@darkskiez.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16602 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262231AbVBBKA0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 05:00:26 -0500
In-Reply-To: <4200A27E.2070401@darkskiez.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Bryars <linuxide@darkskiez.co.uk>
Cc: linux-ide@vger.kernel.org

Mark Bryars wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> I have an Asus K8V Mainboard, the promise sata controller has a PATA
> port in addition to the two SATA channels and the HDD I have connected
> is detected by the controller as displayed on boot. The sata_promise
> driver as of stock 2.6.10 seems to only probe the two sata ports. Is
> this meant to also handle the pata port or is a separate driver/patch
> needed? I've searched the list and not found anything appropriate.

Support for the PATA port exists in the libata-dev-2.6 queue.

Current patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-bk9-libata-dev1.patch.bz2

	Jeff



