From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 11:05:40 +0800
Message-ID: <421D4484.5090205@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>	 <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <58cb370e050223085039cb0731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:39905 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261700AbVBXDGA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 22:06:00 -0500
In-Reply-To: <58cb370e050223085039cb0731@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>


Hi Bart,

> 
> [ generic comment about PATA support in libata, yes wrong thread 8) ]
> 
> I think that at one point libata and IDE drivers should be merged.
> Yes, this is doable and I plan to prove it soon (this shouldn't be so
> hard nowadays :-).  

   Do you mean the IDE subsystem and libata sharing the same lowlevel drivers?

> I really don't want to have two PATA drivers in
> the tree with subtle differences (i.e. CHS handling) when one would
> work in some cases (i.e. 4 Promise controllers) and the second one
> in other cases (i.e. ATAPI support).  I'm sure you get the point.
> 

   Yes, it is a problem. When I was asked to look at pdc2027x host
adapter hotplug issue, I saw libata already have the HBA hotplug feature.
So, that's why the pdc202xx_new driver was ported to libata as pata_pdc202xx driver.
However, currently libata needs enhancements like PATA, ATAPI, etc.
And the IDE subsystem needs some enhancements like HBA hotplug, etc.
   It will be great if some kind of integration can be done.

Before the dream come true, could I work on the following items on pdc202xx_new driver?
- Add PLL init code
   (This can fix the more than 2 adapters not supported limitation)
- Fix the hardware auto-set timing registers problem
- Fix the pdc2027x ATAPI DMA problem with the workaround
   (Currently pdc202xx_new driver alway use PIO mode for ATAPI)

The pdc202xx_new is the current driver used in production environment.
Fixing the above problems is really needed.

Best regards,

Albert


