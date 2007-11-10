From: Jeff Garzik <jeff@garzik.org>
Subject: Re: FIS structure and Command List structure for AHCI SATA controller
Date: Fri, 09 Nov 2007 22:03:04 -0500
Message-ID: <47351F68.3020307@garzik.org>
References: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>	 <20071109035506.GC25581@havoc.gtf.org> <5c9cd53b0711090539u79c1ba4fte46ee13f5906b42a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34664 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbXKJDDI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Nov 2007 22:03:08 -0500
In-Reply-To: <5c9cd53b0711090539u79c1ba4fte46ee13f5906b42a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mike zheng <mail4mz@gmail.com>
Cc: linux-ide@vger.kernel.org

mike zheng wrote:
> Hi Jeff,
> 
> Actually I am using Marvell's 88SE6121 on kernel 2.4. I just wonder do
> I have to enable the FIS? The SATA Command Table of the device have
> following definitions:
> 
> 00h Command FIS
> 40h ATAPI Command (CDB)
> 60h RSVD
> 80h Physical Region Descriptor Table
> 
> Does it mean I can only use FIS or ATAPI for this device?
> 
> Another confusion is the manual say that software should prepare the
> command header, command FIS and the ATAPI command (CDB) for the ATAPI
> command. Why it needs the FIS for ATAPI command?
> 
> Thanks for your help.

FIS == basic data message used by all Serial ATA.

Both SATA ATA and SATA ATAPI use a FIS, it is fundamental to the nature 
of Serial ATA.

	Jeff



