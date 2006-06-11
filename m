From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Sun, 11 Jun 2006 17:48:39 +0200
Message-ID: <1150040920.3131.74.camel@laptopd505.fenrus.org>
References: <20060610115636.57029.qmail@web26907.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:28584 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751279AbWFKPss (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jun 2006 11:48:48 -0400
In-Reply-To: <20060610115636.57029.qmail@web26907.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org


>  The simple solution is: you never boot from the hard disk, but from a
>  physically write protected device (write protected floppy, non writeable
>  CD or CDRW in a non writing CDROM drive, USB thumb drive with a physical
>  write protect switch).


that's not totally fool proof either; after all an attacker can adjust
the nvram to change the boot device order.



