From: Jeff Garzik <jeff@garzik.org>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017	ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 10:03:05 -0500
Message-ID: <4968B8A9.3060408@garzik.org>
References: <200901091334.55823.borntraeger@de.ibm.com>	 <200901101009.13699.borntraeger@de.ibm.com>	 <20090110104114.633cacd8@lxorguk.ukuu.org.uk>	 <200901101242.05203.borntraeger@de.ibm.com>	 <49688B63.5030105@ru.mvista.com>	 <20090110122130.318cf168@lxorguk.ukuu.org.uk> <1231598170.3642.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34468 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZAJPDX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 10:03:23 -0500
In-Reply-To: <1231598170.3642.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

James Bottomley wrote:
> Your problem is that the *device* is wanting to transfer a set of bytes
> not divisible by four.

That's my initial guess, too...

	Jeff


