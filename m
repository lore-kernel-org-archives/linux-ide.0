From: Mikael Pettersson <mikpe@it.uu.se>
Subject: libata NCQ implementation questions
Date: Mon, 12 May 2008 01:19:20 +0200
Message-ID: <18471.32504.953679.399689@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39606 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756503AbYEKXTa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 May 2008 19:19:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

I've started working on NCQ support for sata_promise,
and I have a few questions regarding NCQ and libata:

1. Can I rely not seeing any non-NCQ commands while there
   are uncompleted NCQ commands on a port?

   I _believe_, from the comment at ata_std_qc_defer(), that
   this is the case, but I'd like to get that confirmed.

2. Assuming NCQ and non-NCQ commands cannot be mixed, is there
   a defined way to detect when a port transitions from non-NCQ
   to NCQ mode and vice versa, or do I have to detect that myself?

   The mode affects the programming of the Promise SATA "sequence
   counter control" registers.

3. Is qc->tag defined (to zero for instance) for non-NCQ commands?

   For sata_promise NCQ I need to allocate packets and prds from
   per-port pools indexed by tag. To handle non-NCQ commands it's
   easiest to assume they map to tag 0, but the code to set a tag
   conditionally based on qc->tf.protocol is a bit ugly.

4. What are these "internal commands" that map to ATA_TAG_INTERNAL?
   Are they NCQ or not?
   Does the existence of ATA_TAG_INTERNAL limit queue depth for NCQ?

5. Does dmam_alloc_coherent() give the same alignment guarantees
   that pci_alloc_consistent() does? That is, both CPU and bus
   addresses will be aligned to the smallest PAGE_SIZE order that
   fits the requested size.

   On x86, pci_alloc_consistent() is implemented directly on top of
   dma_alloc_coherent(), which would imply that dma_alloc_coherent()
   has at least as strong alignment guarantees as pci_alloc_consistent().
   And since dmam_alloc_coherent() is documented to be exactly like
   dma_alloc_coherent() except for being managed, similar alignment
   guarantees for dmam_alloc_coherent() should be true. However, this
   refers to one platform's implementation; I can't find any generic
   documentation about alignment for dma_alloc_coherent().

   I've looked at pci_set_dma_mask(), but as far as I can tell, it
   can only express size limits of addresses, it cannot express alignment
   constraints.

   The issue is that NCQ on Promise SATA is done by an FPDMA engine
   that unfortunately has a rather annoying addressing limitation:
   it requires that all NCQ packet and SG data for all active tags
   on a port is located in a single physical memory region that does
   not cross a 64KB physical memory boundary.

/Mikael
