From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Merging libata PATA support into the base kernel
Date: Wed, 23 Aug 2006 23:38:16 -0400
Message-ID: <44ED1F28.4070808@pobox.com>
References: <1155144599.5729.226.camel@localhost.localdomain> <44ED1D93.3020203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030252AbWHXDiX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2006 23:38:23 -0400
In-Reply-To: <44ED1D93.3020203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Albert Lee wrote:
> Alan Cox wrote:
>> Jeff (rightly) thinks the plan should be discussed publically, so here
>> is the plan
>>
>> For 2.6.19 to move the libata drivers to drivers/ata
>> Add a subset of the new PATA drivers living in -mm to the base kernel
>>
> 
> Is it planned for the pata_pdc2027x driver to be included in the
> subset of upstream PATA drivers? It would be nice to have the driver
> for the adapter hotplug on ppc64.

Yes.  That driver will go along with all the other PATA drivers in the 
#pata-drivers branch.

	Jeff



