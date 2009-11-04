From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -2nd repost 1/1] ATA: pata_via, fix double put on isa
 bridge
Date: Wed, 4 Nov 2009 16:36:11 +0000
Message-ID: <20091104163611.4e71f01d@lxorguk.ukuu.org.uk>
References: <1257351063-5616-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38428 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757015AbZKDQec (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Nov 2009 11:34:32 -0500
In-Reply-To: <1257351063-5616-1-git-send-email-jirislaby@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Wed,  4 Nov 2009 17:11:03 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> In via_init_one, when via_isa_bridges iterator reaches
> PCI_DEVICE_ID_VIA_ANON and last but one via_isa_bridges bridge is
> found but rev doesn't match, pci_dev_put(isa) is called twice.
> 
> Do pci_dev_put only once.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>

Acked-by: Alan Cox <alan@linux.intel.com>

Definitely a far saner way to do it.
