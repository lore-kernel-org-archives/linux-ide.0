From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c	[ide_core]
Date: Thu, 21 Aug 2008 12:34:59 -0500
Message-ID: <48ADA743.1070000@lwfinger.net>
References: <20080820173122.GA7335@deprecation.cyrius.com> <48AC71D7.8050604@lwfinger.net> <20080821161610.GA2640@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:35331 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbYHURe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2008 13:34:56 -0400
In-Reply-To: <20080821161610.GA2640@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

Martin Michlmayr wrote:
> * Larry Finger <Larry.Finger@lwfinger.net> [2008-08-20 14:34]:
>> Please do the following, which will require the package containing  
>> objdump. First of all, do the command
>>
>> objdump -d -l drivers/ide/ide-core.o > ide_core.dump
>>
>> Next, open ide_core.dump with less or your favorite editor and search for 
>> the start of init_irq. Note that address. Add your offset of 0x18D to that 
>> value and find the instruction at that address. Move up in the file until 
>> you find a line that looks like
>> /home/finger/linux-2.6/drivers/ide/ide-probe.c:1054
> 
> Hey Larry,
> 
> The dump file doesn't contain any line numbers.  See the attached
> file.

I think the error is in hwif_to_node with dev set to NULL in the 
dereference of dev->bus. This inline routine is called from the 
following code fragment from ide-probe.c:

         if (match) {
                 hwgroup = match->hwgroup;
                 hwif->hwgroup = hwgroup;
                 /*
                  * Link us into the hwgroup.
                  * This must be done early, do ensure that 
unexpected_intr
                  * can find the hwif and prevent irq storms.
                  * No drives are attached to the new hwif, choose_drive
                  * can't do anything stupid (yet).
                  * Add ourself as the 2nd entry to the hwgroup->hwif
                  * linked list, the first entry is the hwif that owns
                  * hwgroup->handler - do not change that.
                  */
                 spin_lock_irq(&ide_lock);
                 hwif->next = hwgroup->hwif->next;
                 hwgroup->hwif->next = hwif;
                 BUG_ON(hwif->next == hwif);
                 spin_unlock_irq(&ide_lock);
         } else {
                 hwgroup = kmalloc_node(sizeof(*hwgroup), 
GFP_KERNEL|__GFP_ZERO,
                                        hwif_to_node(hwif));

The line above triggers the fault.

I don't know enough about the code to figure the rest out, but I 
expect that the experts will.

Did this work with precious versions? If so, it should be posted as a 
regression.

Larry

