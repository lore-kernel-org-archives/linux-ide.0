From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 02 Jul 2007 14:31:20 -0400
Message-ID: <46894478.9070808@garzik.org>
References: <200706302110.20766.bzolnier@gmail.com> <200707021956.32844.bzolnier@gmail.com> <46893D42.9070603@garzik.org> <200707022041.08350.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53515 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXGBSbX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 14:31:23 -0400
In-Reply-To: <200707022041.08350.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 July 2007, Jeff Garzik wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>> This would brake setups which currently work OK, i.e. BIOS set things up
>>> (reminds me about cmd64x vs broken MWDMA)...
>>>
>>> The RightThing(tm) to do is to fix alim15x3 driver to program DMA timings
>>> (especially given that pata_ali seems to already contain the needed code).
>> I am not ready to trust that pata_ali works as well as alim15x3 in all 
>> cases.  Someone should test e.g. Alpha AXP systems with IDE (use 
>> alim15x3) to make sure all is well.
> 
> Sure but there is no problem with the new code in alim15x3 being X86 until
> it is verified to work with Alpha AXP machines etc...

I'm not sure I follow.  You now want to mark alim15x3 X86-only?  Or add 
the new code inside #ifdef X86?


>> alim15x3 covers buggy, ugly, quirky chipsets.  I consider that coverage 
>> in general highly fragile.
> 
> and in case of MWDMA modes also highly dependent on BIOS settings
> which very likely results in broken suspend/resume...

Agreed.  But I would rather verify that timing programming works on 
supported platforms, before expanding use of said new code?

	Jeff


