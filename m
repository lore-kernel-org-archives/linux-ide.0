From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Marvell 6121 SATA support?
Date: Tue, 11 Mar 2008 10:31:12 -0400
Message-ID: <47D697B0.90009@garzik.org>
References: <47D6945F.3080201@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37034 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975AbYCKOb2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2008 10:31:28 -0400
In-Reply-To: <47D6945F.3080201@aquazul.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mourad De Clerck <mourad@aquazul.com>
Cc: linux-ide@vger.kernel.org

Mourad De Clerck wrote:
> Hello,
> 
> I was wondering what the status was of Marvell 6121 SATA support. I've
> seen earlier messages saying it was pretty much working with the AHCI
> driver, and that it would be merged in mainline soon, but that was in
> 2.6.22 times.
> 
> I've not seen support for it in 2.6.25-rc5's ahci, so I guess I
> shouldn't expect it in 2.6.25?

I would just add the PCI ID to ahci.c, it should most likely work...

	Jeff



