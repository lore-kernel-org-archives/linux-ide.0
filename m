From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core.c: ata_fill_sg() ... SATA AHCI
Date: Wed, 8 Aug 2007 12:27:06 +0100
Message-ID: <20070808122706.2ff5b631@the-village.bc.nu>
References: <loom.20070807T172323-813@post.gmane.org>
	<20070807180714.25b1a8c1@the-village.bc.nu>
	<loom.20070808T110804-590@post.gmane.org>
	<20070808110218.601fbda3@the-village.bc.nu>
	<loom.20070808T131038-725@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53884 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751404AbXHHLTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 07:19:36 -0400
In-Reply-To: <loom.20070808T131038-725@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org

> I note also that Intel's Serial ATA AHCI spec has a 22-bit DMA byte count
> in the PRDT, so 0 == 64k cannot be assumed here either.

Different standard and our AHCI driver doesn't use ata_fill_sg either 8)
