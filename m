From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: New driver mtipx2xx submission
Date: Mon, 02 May 2011 14:40:09 -0400
Message-ID: <x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21092 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab1EBSkX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 May 2011 14:40:23 -0400
In-Reply-To: <20110428230605.78c55c70@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Thu, 28 Apr 2011 23:06:05 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> We have written a new block driver for our AHCI based PCIe SSDs. The
>> main objective of our product is providing high performance. Traffic
>> through OS storage stack is not to able fully utilize the device's
>> capabilty. To improve the traffic to the device and hence
>> showcase/utilize the device's capability, we have come up with this new
>> block driver. This driver includes
>> 	* utilize device's increased queue depth
>> 	* workaround for hardware errata
>> 
>> We want to get this driver into kernel tree to support the device out of
>> the box. Attached this driver as a patch for latest kernel. We would
>> like to get your comments, and also open for discussion.
>
> The kernel starting point would be that we have an AHCI driver. If you
> need workarounds for hardware errata then they can go into it and that is
> fine. We support NCQ so we can use the queue depths. If there are
> extensions then the AHCI driver can be enhanced.

Given the highly parallel nature of these parts, I wouldn't be surprised
if the ahci queue depth of 31 is one of the main bottlenecks.  Can you
think of a way to extend the ahci driver in this manner to accommodate
devices like this one?

Cheers,
Jeff
