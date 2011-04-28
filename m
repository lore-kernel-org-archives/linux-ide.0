From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Thu, 28 Apr 2011 23:06:05 +0100
Message-ID: <20110428230605.78c55c70@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60413 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754392Ab1D1WE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Apr 2011 18:04:58 -0400
In-Reply-To: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: linux-ide@vger.kernel.org

> We have written a new block driver for our AHCI based PCIe SSDs. The
> main objective of our product is providing high performance. Traffic
> through OS storage stack is not to able fully utilize the device's
> capabilty. To improve the traffic to the device and hence
> showcase/utilize the device's capability, we have come up with this new
> block driver. This driver includes
> 	* utilize device's increased queue depth
> 	* workaround for hardware errata
> 
> We want to get this driver into kernel tree to support the device out of
> the box. Attached this driver as a patch for latest kernel. We would
> like to get your comments, and also open for discussion.

The kernel starting point would be that we have an AHCI driver. If you
need workarounds for hardware errata then they can go into it and that is
fine. We support NCQ so we can use the queue depths. If there are
extensions then the AHCI driver can be enhanced.

Similarly if you've got performnace problems going through the libata
core and AHCI driver the right thing to do is to fix the performance
problems in the core (or rewrite bits of the core as needed).

I think the starting point would be to explain what problems you see with
the existing driver, and where the profiling tools say the bottlenecks
are when you try and get full speed under libata + libata ahci driver.

Otherwise we will end up with one AHCIish driver per vendor and it turns
into a nightmare for maintenance.

Alan
