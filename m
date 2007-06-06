From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [2/2] 2.6.22-rc4: known regressions with patches
Date: Wed, 6 Jun 2007 09:50:10 +0900
Message-ID: <20070606005010.GA8110@linux-sh.org>
References: <46657866.7000108@googlemail.com> <4665792B.8030005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:47819 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215AbXFFAvW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jun 2007 20:51:22 -0400
Content-Disposition: inline
In-Reply-To: <4665792B.8030005@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>, "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, Tom Long Nguyen <tom.l.nguyen@intel.com>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

On Tue, Jun 05, 2007 at 04:54:35PM +0200, Michal Piotrowski wrote:
> SATA/PATA
> 
> Subject    : libata reset-seq merge broke sata_sil on sh
> References : http://lkml.org/lkml/2007/5/10/63
> Submitter  : Paul Mundt <lethal@linux-sh.org>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
> Patch      : http://lkml.org/lkml/2007/5/19/161
> Status     : patch available
> 
Fixed by fd7fe701612e42fb8780d7bf61fbb0467a488c9b, which was already in
-rc3.
