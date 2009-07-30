From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA II NCQ and multi-port add-on card (PCI or PCIe x1)
Date: Thu, 30 Jul 2009 08:47:56 -0400
Message-ID: <4A71967C.1010808@rtr.ca>
References: <0KNK00628MWA08Z1@vms173005.mailsrvcs.net> <4A712A22.6030708@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50865 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbZG3Mr6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 08:47:58 -0400
In-Reply-To: <4A712A22.6030708@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: dhdurgee@verizon.net, linux-ide@vger.kernel.org

Tejun Heo wrote:
>
> I know sil3132 generally works well although it's quirky at times and
> has bandwidth limitation.  Mark, how well do marvell chips preform?
> Do they have performance limitations like 3132s?
..

They don't seem to have any significant bottlenecks,
so performance is limited only by the bus-width for
the card/slot into which it gets inserted.

Up to a point, somewhere in the mid-100's of MBytes/second.
And the PCIe 7042 / PCI(x) 6042 chips handle FIS-based switching,
plus all of the other SATA bells and whistles, including ATAPI.

I think the only significant thing that's missing now
is power-management, which probably isn't that hard to
add now that there are other in-kernel SATA drivers
that include some PM functionality.

Cheers

