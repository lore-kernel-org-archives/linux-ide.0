From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 8 Jun 2007 11:55:02 -0400
Message-ID: <20070608155502.GH25649@havoc.gtf.org>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org> <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com> <466196AD.3090502@garzik.org> <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com> <46667466.4010500@gmail.com> <9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com> <4667B347.9040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57477 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938935AbXFHPzD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2007 11:55:03 -0400
Content-Disposition: inline
In-Reply-To: <4667B347.9040900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>


I just confirmed that two PATA-era major BIOS brands do SRST.  They do
check for the device signature in TF registers...  but only for the ATA
device signature.

	Jeff



