From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Thu, 20 Sep 2007 10:18:47 +0900
Message-ID: <46F1CA77.5080102@gmail.com>
References: <20070822233710.415faaf0@the-village.bc.nu> <46F145E1.1050107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:47642 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXITBSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 21:18:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so308583nze
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 18:18:54 -0700 (PDT)
In-Reply-To: <46F145E1.1050107@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Chuck Ebbert wrote:
> On 08/22/2007 06:37 PM, Alan Cox wrote:
>> This is useful when debugging, handling problem systems, or for
>> distributions just to get the system installed so it can be sorted
>> out later.
>>
>> This is a bit smarter than the old IDE one and lets you do
>>
>> libata.pata_dma=0		Disable all PATA DMA like old IDE
>> libata.pata_dma=1		Disk DMA only
>> libata.pata_dma=2		ATAPI DMA only
>> libata.pata_dma=4		CF DMA only
>>
>> (or combinations thereof - 0,1,3 being the useful ones I suspect)
>>
> 
> This doesn't help distro installers with modular libata, as there's
> no good way to get the parameter to the driver. (libata.pata_dma=0
> just causes "unrecognized parameter" message on boot.)

Dunno how all those initrd black magics work but SUSE initrd manages to
deliver "module.param" parameters on kernel command line to respective
modules in initrd.  I don't think it gets to modules which are loaded
after root is mounted tho.

-- 
tejun
