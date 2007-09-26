From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 25 Sep 2007 22:12:46 -0400
Message-ID: <46F9C01E.8010503@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbXIZCMt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:12:49 -0400
In-Reply-To: <46F9BF3E.5050708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Just like the Linux kernel MM platform API presents 3 levels of page 
> table entries, even when the hardware may only have 2, libata high level 
> API _must_ be implemented as 100% asynchronous event driven API.


To be more clear, non-taskfile packets/commands should be delivered via 
->qc_issue, just like taskfiles.

This is similar to sas_task in libsas, which can be a SATA packet, a SAS 
packet, a management packet, ...

In the long run, we should probably look at integrating ata_queued_cmd 
and sas_task.  Once ata_queued_cmd becomes multi-protocol (tf, pmp, 
sgpio, ...), it becomes more generic.  sas_task is also multi-protocol.

	Jeff



