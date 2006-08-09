From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/9] libata: rework legacy handling to remove much of
 the cruft
Date: Wed, 09 Aug 2006 00:27:39 -0400
Message-ID: <44D9643B.2050008@pobox.com>
References: <11547252931651-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60572 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030448AbWHIE1p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:27:45 -0400
In-Reply-To: <11547252931651-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>

Tejun Heo wrote:
> Kill host_set->next
> Fix simplex support
> Allow per platform setting of IDE legacy bases
> 
> Some of this can be tidied further later on, in particular all the
> legacy port gunge belongs as a PCI quirk/PCI header decode to understand
> the special legacy IDE rules in the PCI spec.
> 
> Longer term Jeff also wants to move the request_irq/free_irq out of core
> which will make this even cleaner.
> 
> (tj: folded in two followup patches - ata_piix fix & broken arch fix -
> as compilation fails without those, and separated per-dev xfermask
> into separate patch)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


