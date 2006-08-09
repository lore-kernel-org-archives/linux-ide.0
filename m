From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Wed, 09 Aug 2006 02:41:12 -0400
Message-ID: <44D98388.8030005@pobox.com>
References: <1154919840689-git-send-email-htejun@gmail.com> <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31907 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030557AbWHIGl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 02:41:26 -0400
In-Reply-To: <44D9782A.30405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> This is definitely the wrong direction.
> 
> Ouch...  The whole patch?
> 
>> We don't want to keep crowding knowledge of multiple bus technologies 
>> into the same function.
> 
> Do you mean PCI-IDE (legacy/BMDMA), PCI-native and newer controllers 
> (including MSI stuff)?  Bus-wise they're all PCI.

ata_generic, ISA, VLB, and embedded controllers that use libata are not 
PCI.  libata-bmdma can drive older non-PCI controllers.

Its a bit confusing because "PCI IDE" is often used to refer to the 
legacy IDE shadow register interface.  I started to use "bmdma" to 
describe the interface, but it drives Alan crazy :)


>> ata_pci_request_irq() and other code above follows the same theme... 
>> but its an unmaintainable direction.
>>
>> This sort of stuff needs to be split up, not coalesced.
> 
> ata_pci_*() functions are PCI helpers and I wanted to move most of PCI 
> resource bookkeeping into helpers.  Less clutter in LLDs and less errors.

Putting legacy IDE resource allocation and ultra-modern (MSI) resource 
allocation in the same function is the wrong direction.

Legacy LLDDs should not be traversing code that has to worry about PCI 
MSI, and PCI MSI controllers should not be traversing code paths that 
deal with legacy IDE.

I'm looking forward to having ARM and PowerMac IDE drivers ported to 
libata soon, and we don't need to be adding special ARM/PPC bus handling 
stuff to these already-gigantic resource routines.


>> Another thing to think about:  IMO it makes sense to separate out the 
>> PCI IDE resource handling, because that set of technology is largely 
>> static.
>  >
>> Most newer controllers will only have a few resources, normally MMIO, 
>> and may even support MSI-X (multiple messages for different event 
>> types, rather than a single message for all events like MSI).
>>
>> So, I'd like to see some of this inside libata-bmdma.c to keep the 
>> core free of such nastiness.
> 
> I'm having a little bit difficult time following what you're thinking. 
> Whatever the final interface is, the goals would be similar to what's 
> listed in the head message of this patchset, and I think 
> alloc/init/attach model is a good way to achieve that thus killing 
> probe_ent.  Can you explain in more detail how the interface should look 
> like?

Killing probe_ent is a good thing, definitely.  Ideally we should have 
an interface for the LLDD like

	host_set = alloc_ata()
	[ fill in host_set ]
	rc = register_ata()
	...
	unregister_ata()
	free_ata()

Additionally, to take into account strange resource allocation stuff, 
BMDMA drivers should eventually do

	host_set = alloc_bmdma()
	[ fill in host_set ]
	rc = register_bmdma()
	...
	unregister_bmdma()
	free_bmdma()

That keeps all the legacy IDE crap out of the core completely.

Overall, your movement towards killing probe_ent and filling in host_set 
directly is a good one, as I illustrate above.  But lumping all the 
resource allocation and irq registration into a few big functions is the 
wrong direction.  Consider for example an LLDD that supports MSI-X in 
your design.  That's a good proof of concept.

	Jeff


