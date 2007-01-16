From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_uli: ignore SIMPLEX
Date: Tue, 16 Jan 2007 11:46:03 +0000
Message-ID: <20070116114603.725a8d1b@localhost.localdomain>
References: <20070116055551.GN10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46419 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbXAPLeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 06:34:15 -0500
In-Reply-To: <20070116055551.GN10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, 16 Jan 2007 14:55:51 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Some uli controllers have stuck SIMPLEX bit which can't be cleared
> with ata_pci_clear_simplex(), but the controller is capable of doing
> DMAs on both channels simultaneously.  Ignore it.

Acked-by: Alan Cox <alan@redhat.com>
