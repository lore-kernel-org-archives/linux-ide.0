From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [sata] new driver -- AHCI
Date: Thu, 29 Apr 2004 04:56:46 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4090C34E.8080107@pobox.com>
References: <408C1F41.3060206@pobox.com> <40905997.9020107@tomt.net> <409073B1.1020901@pobox.com> <4090B9F5.3040207@epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27279 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263714AbUD2I5C
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Apr 2004 04:57:02 -0400
In-Reply-To: <4090B9F5.3040207@epita.fr>
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <bevand_m@epita.fr>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Marc Bevand wrote:
> Jeff Garzik wrote:
> 
>> Andre Tomt wrote:
>>
>>> What about the Marvell 88SX5040 PCI-X SATA Controller?
>>
>>
>> Coming RSN.  That's my next priority, but I'm not as thrilled because 
>> Marvell isn't an open design like AHCI.  I'm much more happy to 
>> promote AHCI's sane, open design.
> 
> 
> And what about the upcomming Promise SATAII150 SX8 PCI-X SATA Controller ?
> Will it be based on an AHCI design ?


No, very different.  And the driver for the SX8 has been in the upstream 
tree for a little while now too, if you missed it:  "carmel"

	Jeff



