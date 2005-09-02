From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Date: Thu, 01 Sep 2005 21:32:48 -0400
Message-ID: <4317ABC0.3040603@emc.com>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <20050901222617.2455520F96@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:52055 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030631AbVIBBdV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Sep 2005 21:33:21 -0400
In-Reply-To: <20050901222617.2455520F96@lns1058.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

Brett Russ wrote:
> This is my libata compatible low level driver for the Marvell SATA
> family.  Currently it successfully runs in PIO mode on a 6081 chip.
> EDMA support is in the works and should be done shortly.  Review,
> testing (especially on other flavors of Marvell), comments welcome.

Note that this patch depends on the PCI INTx patch I submitted earlier:

http://lkml.org/lkml/2005/8/15/165

Sorry for the delayed notice,
BR
