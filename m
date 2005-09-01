From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Date: Thu, 1 Sep 2005 20:58:32 +0100
Message-ID: <20050901195832.GA14602@infradead.org>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <43175B23.8040803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:43677 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030334AbVIAT6i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Sep 2005 15:58:38 -0400
Content-Disposition: inline
In-Reply-To: <43175B23.8040803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:48:51PM -0400, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> >>+#include <linux/kernel.h>
> >>+#include <linux/module.h>
> >>+#include <linux/pci.h>
> >>+#include <linux/init.h>
> >>+#include <linux/blkdev.h>
> >>+#include <linux/delay.h>
> >>+#include <linux/interrupt.h>
> >>+#include <linux/sched.h>
> >>+#include <linux/dma-mapping.h>
> >>+#include "scsi.h"
> >
> >
> >pleaese don't include "scsi.h" in new drivers.  It will go away soon.
> >Use the <scsi/*.h> headers and get rid of usage of obsolete constucts
> >in your driver.
> 
> 
> It stays until the rest of the libata drivers lose the include.
> 
> After ATAPI support is done, I can stop 2.4.x support, and this and 
> several other compat-isms will go away.

NACK.  Jeff, I accept that you don't want to convert old drivers yet,
but this is not acceptable for new drivers.  We don't allow it for any
new scsi LLDDs, and that includes libata drivers.

