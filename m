From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 0/2] libata: support SATA devices on SAS HBAs
Date: Wed, 05 Oct 2005 16:59:05 -0400
Message-ID: <43443E99.4090008@pobox.com>
References: <4341A91A.3020000@us.ibm.com> <434251E0.9060000@pobox.com>	 <58cb370e0510040322q1cb7a13bjfc6c7875140d20a9@mail.gmail.com> <58cb370e0510041356h780e7a5aifda0c232f677471e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58331 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbVJEU7N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 16:59:13 -0400
In-Reply-To: <58cb370e0510041356h780e7a5aifda0c232f677471e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: brking@us.ibm.com, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] libata: add ops->qc_transport for SAS
> 
> * add ->qc_transport to struct ata_port_operations
> * add default ata_qc_transport() and update all host drivers
> 
> Thanks to this change we won't have to depend on host_set
> and host_set->lock for devices attached to SAS HBAs.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


Seems sane at a quick glance, though I'm a bit disappointed we have to 
add yet another level of indirection to the hot path.

You made a good point, though, by pointing out that all the ata_qc_xxx 
stuff is essentially completely inside a single lock domain.

Other notes:  There may be other dependencies such as wanting to 
reference the struct device pointer in host_set and similar details that 
need handling.  Also, I was planning to move some of the ata_port_ops 
into a separate host_set ops, since they (hooks such as ->irq_clear or 
->host_stop) are really host-wide hooks, not per-port hooks.

	Jeff


