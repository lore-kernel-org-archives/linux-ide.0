From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_marvell: Add another PCI identifier
Date: Thu, 23 Aug 2007 13:24:27 +0100
Message-ID: <20070823132427.45ef0ad9@the-village.bc.nu>
References: <20070822232705.2decea96@the-village.bc.nu>
	<20070823001626.GO28502@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42273 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760463AbXHWMRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 08:17:00 -0400
In-Reply-To: <20070823001626.GO28502@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

On Wed, 22 Aug 2007 17:16:26 -0700
"Robin H. Johnson" <robbat2@gentoo.org> wrote:

> On Wed, Aug 22, 2007 at 11:27:05PM +0100, Alan Cox wrote:
> >  static const struct pci_device_id marvell_pci_tbl[] = {
> >  	{ PCI_DEVICE(0x11AB, 0x6101), },
> > -	{ PCI_DEVICE(0x11AB, 0x6145), },
> Why is this ID being removed?
> 
> Not that I have that model (I have 0x6101), it just looks weird given
> the patch description to "Add another PCI identifier" and I thought I
> should check.

Merge error - well spotted. I'll send a further patch to put it back
