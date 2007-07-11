From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 15/16] libata-link: update hotplug to handle PMP links
Date: Tue, 10 Jul 2007 21:59:20 -0400
Message-ID: <46943978.4070207@garzik.org>
References: <11832843613281-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37801 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbXGKB7X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:59:23 -0400
In-Reply-To: <11832843613281-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Update hotplug to handle PMP links.  When PMP is attached, the PMP
> number corresponds to I of SCSI C:H:I:L.

That doesn't sound right.  'I' == ID == SCSI concept of a target.  'I' 
needs to be the end device, with 'L' (LUN) being normally zero, but 
sometimes otherwise -- in the case of multi-LUN ATAPI devices.  Also, 
you have the order wrong, it's HCIL (host/channel/id/lun).

Since libata uses one SCSI host per port, HCIL translates to 
(port/link/id/lun) I should think.

	Jeff


