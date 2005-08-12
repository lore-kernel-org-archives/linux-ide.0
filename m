From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
Date: Fri, 12 Aug 2005 17:44:08 -0400
Message-ID: <42FD1828.6030003@didntduck.org>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quark.didntduck.org ([69.55.226.66]:30090 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751291AbVHLVmh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 17:42:37 -0400
In-Reply-To: <20050812182253.GA7842@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Brett Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 12, 2005 at 01:10:43PM -0400, Brett Russ wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Brett Russ wrote:
>>>
>>>
>>>>Simple cleanup to eliminate X copies of the same function in libata.  
>>>>Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
>>>>and use them throughout libata and msi.c.
>>>>
>>>>Signed-off-by: Brett Russ <russb@emc.com>
>>>
>>>
>>>Though there is nothing wrong with this patch, I would prefer a single 
>>>function, pci_intx(), as found in drivers/scsi/ahci.c.
>>>
>>>Would you be willing to move that one to the PCI layer, eliminate the 
>>>multiple copies of pci_enable_intx(), and replace the calls to 
>>>pci_enable_intx() with calls to pci_intx() ?
>>
>>Sounds like what I did, except for the naming change.  I did away with
>>pci_disable_intx() and changed the names.  Look ok?
> 
> 
> Looks ok to me, care to resend it with a Signed-off-by: and a new
> changelog entry so I can apply it?
> 
> 
>>+EXPORT_SYMBOL(pci_intx);
> 
> 
> Hm, for new pci functions, I prefer to have them marked as
> EXPORT_SYMBOL_GPL(), is that ok with you?

It's not really "new".  It's simply a trivial wrapper around other pci 
functions.

--
				Brian Gerst
