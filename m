From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable
 chips
Date: Mon, 7 Dec 2009 17:53:14 +0000
Message-ID: <20091207175314.2ef480e2@lxorguk.ukuu.org.uk>
References: <20091130132005.27236.77890.stgit@localhost.localdomain>
	<4B1D0268.4090508@ru.mvista.com>
	<200912071605.28364.bzolnier@gmail.com>
	<200912071734.40916.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37557 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935535AbZLGRvd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 12:51:33 -0500
In-Reply-To: <200912071734.40916.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

> Hmm.. why cannot ->qc_issue be used here (like in all other host drivers with
> shared PIO/MWDMA timings) instead of some new 'clipping'?

Agreed it would probably work providing the 8bit timings are not affected
by any of this.

> ->qc_issue is the standard way to do it, takes care of more corner cases
> and would also allow for faster MWDMA0 timings. 

All yours.. just revert the buggy patch and fix it. I won't have time to
look at it until next year and I freecycled all my SiS hardware some time
ago.

Alan
