From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Libata PATA status
Date: Thu, 05 Jul 2007 19:25:08 -0400
Message-ID: <468D7DD4.9060306@garzik.org>
References: <20070703185116.59c8f5f5@the-village.bc.nu> <p73k5tg2uj9.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51760 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763436AbXGEXZM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 19:25:12 -0400
In-Reply-To: <p73k5tg2uj9.fsf@bingen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andi Kleen wrote:
> My personal wish list feature would be a little forwarder driver
> to forward /dev/hd* to /dev/sd* for this; then old IDE could be
> disabled without risking breaking old root file systems.


That's on the long-term TODO list.

libata is moving towards making libata-scsi an optional module (will 
always be around for ATAPI, and for compat with current ATA), and 
driving ATA disks as a native block driver, rather than having SCSI do 
the work for us.

libata's qc_issue/qc_complete high level API and internal modularity 
were designed to make this possible.  It is easy to see in the current 
code how libata-scsi is merely a user of the qc_issue/qc_complete API, 
with all the low-level details isolated away from that module.

Addendum:  Remember too, /dev/hdX is not just a major/minor pair, but a 
userspace interface, complete with expected ioctl support.

	Jeff


