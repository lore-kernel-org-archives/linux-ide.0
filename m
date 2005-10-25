From: Brian King <brking@us.ibm.com>
Subject: Re: [RFC 0/2] libata: support SATA devices on SAS HBAs
Date: Tue, 25 Oct 2005 12:57:23 -0500
Message-ID: <435E7203.8020008@us.ibm.com>
References: <4341A91A.3020000@us.ibm.com> <434251E0.9060000@pobox.com>	 <58cb370e0510040322q1cb7a13bjfc6c7875140d20a9@mail.gmail.com> <58cb370e0510041356h780e7a5aifda0c232f677471e@mail.gmail.com> <43443E99.4090008@pobox.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22729 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932275AbVJYR5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2005 13:57:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9PHvO7h030707
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2005 13:57:24 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9PHvOHM071484
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2005 13:57:24 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j9PHvOh0031576
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2005 13:57:24 -0400
In-Reply-To: <43443E99.4090008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>>[PATCH] libata: add ops->qc_transport for SAS
>>
>>* add ->qc_transport to struct ata_port_operations
>>* add default ata_qc_transport() and update all host drivers
>>
>>Thanks to this change we won't have to depend on host_set
>>and host_set->lock for devices attached to SAS HBAs.
>>
>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> 
> 
> Seems sane at a quick glance, though I'm a bit disappointed we have to 
> add yet another level of indirection to the hot path.
> 
> You made a good point, though, by pointing out that all the ata_qc_xxx 
> stuff is essentially completely inside a single lock domain.
> 
> Other notes:  There may be other dependencies such as wanting to 
> reference the struct device pointer in host_set and similar details that 
> need handling.  Also, I was planning to move some of the ata_port_ops 
> into a separate host_set ops, since they (hooks such as ->irq_clear or 
> ->host_stop) are really host-wide hooks, not per-port hooks.

Jeff,

Is this patch on its way into one of your trees, or should I just pick
it up add it to my libata SAS patchset so you can just grab the whole
patchset once it is ready?

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
