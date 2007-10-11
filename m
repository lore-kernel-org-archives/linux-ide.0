From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: struct pci_dev cleanups
Date: Thu, 11 Oct 2007 22:32:28 +0100
Message-ID: <20071011223228.2b472707@the-village.bc.nu>
References: <20071011211317.GA30328@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35736 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755235AbXJKV14 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2007 17:27:56 -0400
In-Reply-To: <20071011211317.GA30328@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

>     * pata_cs5520: delete cs5520_remove_one(), it was a duplicate of
>       ata_pci_remove_one()

Acked-by: Alan Cox <alan@redhat.com>

Now that pci_remove_one() doesn't go doing disable_device thats sensible.

Alan
