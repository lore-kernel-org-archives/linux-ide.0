From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: hotplug works, but newly plug not
Date: Thu, 25 May 2006 11:14:30 -0400
Message-ID: <4475C9D6.70904@pobox.com>
References: <1148484316.26093.72.camel@localhost.localdomain>	 <4474C737.9000600@gmail.com>	 <1148504987.26093.177.camel@localhost.localdomain> <1148569743.2956.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25001 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965200AbWEYPOe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 May 2006 11:14:34 -0400
In-Reply-To: <1148569743.2956.51.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mingz@ele.uri.edu
Cc: Tejun Heo <htejun@gmail.com>, linux-ide-list <linux-ide@vger.kernel.org>

Ming Zhang wrote:
> I read the whole AHCI but I still could not find out what is the magic
> number 0x92. Is this in some Intel doc?

AHCI spec only documents generic PCI config registers.  Each vendor has 
their own vendor-specific registers.  Intel's are documented publicly on 
the developer website.

	Jeff



