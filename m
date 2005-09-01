From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Date: Thu, 01 Sep 2005 16:03:27 -0400
Message-ID: <43175E8F.7080700@pobox.com>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <43175B23.8040803@pobox.com> <20050901195832.GA14602@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030350AbVIAUDh@vger.kernel.org>
In-Reply-To: <20050901195832.GA14602@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Sep 01, 2005 at 03:48:51PM -0400, Jeff Garzik wrote:
> 
>>Christoph Hellwig wrote:
>>
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/module.h>
>>>>+#include <linux/pci.h>
>>>>+#include <linux/init.h>
>>>>+#include <linux/blkdev.h>
>>>>+#include <linux/delay.h>
>>>>+#include <linux/interrupt.h>
>>>>+#include <linux/sched.h>
>>>>+#include <linux/dma-mapping.h>
>>>>+#include "scsi.h"
>>>
>>>
>>>pleaese don't include "scsi.h" in new drivers.  It will go away soon.
>>>Use the <scsi/*.h> headers and get rid of usage of obsolete constucts
>>>in your driver.
>>
>>
>>It stays until the rest of the libata drivers lose the include.
>>
>>After ATAPI support is done, I can stop 2.4.x support, and this and 
>>several other compat-isms will go away.
> 
> 
> NACK.  Jeff, I accept that you don't want to convert old drivers yet,
> but this is not acceptable for new drivers.  We don't allow it for any
> new scsi LLDDs, and that includes libata drivers.

Sorry, you don't get to NAK that change, since it affects 2.4.x 
maintenance of this new driver.

As I said, the include does away simultaneously for all libata drivers.

	Jeff
