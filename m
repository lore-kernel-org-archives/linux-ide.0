From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] ide: clear bmdma status in ide_intr() for Intel
 controllers (revised #3)
Date: Tue, 30 Jan 2007 14:27:16 +0000
Message-ID: <20070130142716.35550e3a@localhost.localdomain>
References: <45AF57BE.7060505@tw.ibm.com>
	<58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>
	<45B12318.9000704@gmail.com>
	<45B467A9.6040404@tw.ibm.com>
	<45B479C2.7090300@tw.ibm.com>
	<58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com>
	<45B6D386.3030104@tw.ibm.com>
	<45B6D5A7.6080700@tw.ibm.com>
	<45B7596F.6080504@ru.mvista.com>
	<45B878F0.7060707@tw.ibm.com>
	<45B8CA02.4050701@ru.mvista.com>
	<45B8DD84.3090700@ru.mvista.com>
	<45BEB242.7070506@tw.ibm.com>
	<45BEB52B.4070307@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46897 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965487AbXA3OYB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 09:24:01 -0500
In-Reply-To: <45BEB52B.4070307@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

On Tue, 30 Jan 2007 11:02:03 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> patch 2/2 (revised):
> - Fix drive->waiting_for_dma to work with CDB-intr devices.
> - Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq for Intel controllers.

This should probably only be done for the ICH and later controllers with
SATA, as the older ones appear to work fine, as do any not in native mode.
