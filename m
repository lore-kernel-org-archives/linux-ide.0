From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 2.6.21 fix lba48 bug in libata fill_result_tf()
Date: Wed, 04 Apr 2007 02:08:31 -0400
Message-ID: <461340DF.60508@pobox.com>
References: <46116593.6050609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41616 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992677AbXDDGIg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 02:08:36 -0400
In-Reply-To: <46116593.6050609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Ric Wheeler <ric@emc.com>

Mark Lord wrote:
> Tejun,
> 
> Current 2.6.21 libata does the following:
> 
> void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> {
>        struct ata_ioports *ioaddr = &ap->ioaddr;
> 
>        tf->command = ata_check_status(ap);
>     ...
>        if (tf->flags & ATA_TFLAG_LBA48) {
>                iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
>                tf->hob_feature = ioread8(ioaddr->error_addr);
>                ...
>        }
> }
> ...
> static void fill_result_tf(struct ata_queued_cmd *qc)
> {
>        struct ata_port *ap = qc->ap;
> 
>        ap->ops->tf_read(ap, &qc->result_tf);
>        qc->result_tf.flags = qc->tf.flags;
> }
> 
> Based on this, those last two statements fill_result_tf()
> appear to me to be in the wrong order, in that the tf->flags
> are uninitialized at the point where tf_read() is invoked.
> So for lba48 commands, tf_read() won't be reading back the
> full lba48 register contents..
> 
> Correct?
> 
> This patch corrects fill_result_tf() so that the flags
> get copied to result_tf before they are used by tf_read().
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

applied


