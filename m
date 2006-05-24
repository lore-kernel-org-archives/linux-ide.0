From: Tejun Heo <htejun@gmail.com>
Subject: Re: hotplug works, but newly plug not
Date: Wed, 24 May 2006 14:25:16 -0700
Message-ID: <4474CF3C.4050504@gmail.com>
References: <1148484316.26093.72.camel@localhost.localdomain>	 <4474C737.9000600@gmail.com>	 <1148504987.26093.177.camel@localhost.localdomain> <1148505606.26093.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:49441 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932475AbWEXVZb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 17:25:31 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1986077ugf
        for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 14:25:29 -0700 (PDT)
In-Reply-To: <1148505606.26093.179.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mingz@ele.uri.edu
Cc: linux-ide-list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Ming Zhang wrote:
> my fault. forgot to say that the patch does not change the behavior.
> nothing happen after plug a disk to empty slot.
> 

Can you change 0xf to 0xff of the following line in the patch and see if 
anything changes?

pci_write_config_byte(pdev, 0x92, 0xf);
                                   ^^^^-> 0xff


-- 
tejun
