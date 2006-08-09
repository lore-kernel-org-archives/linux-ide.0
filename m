From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Wed, 09 Aug 2006 14:52:42 +0900
Message-ID: <44D9782A.30405@gmail.com>
References: <1154919840689-git-send-email-htejun@gmail.com> <44D96E8E.9020801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:42156 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030493AbWHIFws (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 01:52:48 -0400
Received: by wx-out-0506.google.com with SMTP id s14so87976wxc
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2006 22:52:47 -0700 (PDT)
In-Reply-To: <44D96E8E.9020801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> This is definitely the wrong direction.

Ouch...  The whole patch?

> We don't want to keep crowding knowledge of multiple bus technologies 
> into the same function.

Do you mean PCI-IDE (legacy/BMDMA), PCI-native and newer controllers 
(including MSI stuff)?  Bus-wise they're all PCI.

> ata_pci_request_irq() and other code above follows the same theme... but 
> its an unmaintainable direction.
> 
> This sort of stuff needs to be split up, not coalesced.

ata_pci_*() functions are PCI helpers and I wanted to move most of PCI 
resource bookkeeping into helpers.  Less clutter in LLDs and less errors.

> Another thing to think about:  IMO it makes sense to separate out the 
> PCI IDE resource handling, because that set of technology is largely 
> static.
 >
> Most newer controllers will only have a few resources, normally MMIO, 
> and may even support MSI-X (multiple messages for different event types, 
> rather than a single message for all events like MSI).
> 
> So, I'd like to see some of this inside libata-bmdma.c to keep the core 
> free of such nastiness.

I'm having a little bit difficult time following what you're thinking. 
Whatever the final interface is, the goals would be similar to what's 
listed in the head message of this patchset, and I think 
alloc/init/attach model is a good way to achieve that thus killing 
probe_ent.  Can you explain in more detail how the interface should look 
like?

Thanks.

-- 
tejun
