From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Fri, 20 Nov 2009 22:17:31 +0100
Message-ID: <200911202217.31982.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911192249.16860.bzolnier@gmail.com> <4B05C0B1.2020307@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48138 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZKTVSR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 16:18:17 -0500
In-Reply-To: <4B05C0B1.2020307@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 19 November 2009 11:03:29 pm Jeff Garzik wrote:
> On 11/19/2009 04:49 PM, Bartlomiej Zolnierkiewicz wrote:

> >> Absent stronger justification, libata remains with separate drivers,
> >> even if that means some code duplication.
> >
> > I can always hold my own tree with such changes if needed.
> 
> If it really bugs you, you could take the drivers/ata/sata_promise.h 
> approach, or do multi-file modules.

One of the main problems with separate drivers is a needless complexity
of the detection logic (different chips share same PCI IDs) and relevant
code parts presenting the issue were already posted in this thread.

PS It would bug me really if I were the author or the maintainer of said
code but since I'm not I'll get to fixing it only when I'm bored enough..

--
Bartlomiej Zolnierkiewicz
