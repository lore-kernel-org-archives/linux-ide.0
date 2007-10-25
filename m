From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Deal with ATA8-ACS proposed Trusted/Treacherous
 Computing features
Date: Thu, 25 Oct 2007 13:47:22 +0100
Message-ID: <20071025134722.1206b675@the-village.bc.nu>
References: <20071012173918.3f6d2760@the-village.bc.nu>
	<47205B46.2010706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60495 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751505AbXJYMoi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 08:44:38 -0400
In-Reply-To: <47205B46.2010706@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 25 Oct 2007 05:00:54 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > - Make dword_io check the ATA version
> 
> speaking of dword_io, it would be nice to add 32-bit functions for I/O 
> rather than hand-rolling like pdc_data_xfer_vlb() does.

Agreed, good project for someone 8)

Alan
