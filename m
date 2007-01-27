From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: Marvell 6145 SATA support (preliminary)
Date: Sat, 27 Jan 2007 11:56:12 -0500
Message-ID: <45BB842C.4030303@garzik.org>
References: <20070127034023.GA25959@havoc.gtf.org> <20070127134346.71d8ecf4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53645 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbXA0Q4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Jan 2007 11:56:15 -0500
In-Reply-To: <20070127134346.71d8ecf4@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Alan wrote:
>> Were it not for the PATA and interrupt storm bits, I would say that
>> Marvell 6145 works with a simple PCI ID addition.
> 
> 
> The 6101 driver should drive the 6145 pata port via the legacy registers

They cannot co-exist, unfortunately.

	Jeff



