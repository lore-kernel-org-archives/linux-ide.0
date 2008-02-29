From: Jeff Garzik <jeff@garzik.org>
Subject: devres and requesting resources
Date: Thu, 28 Feb 2008 19:36:34 -0500
Message-ID: <47C75392.3020606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47590 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbYB2Agh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 19:36:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Something I just noticed, which I missed during the initial devres review...

The vast majority of my ATA drivers originally called 
pci_request_regions(), to reserve all regions attached to a device.

In converting to pcim_iomap_regions(), we no longer reserve /all/ 
regions, only the ones requested.

This is actually a bug:  it was intentional to call 
pci_request_regions(), because that ensures that no other software will 
use our resources -- even if we are not actively using the resource in 
question.

Or IOW, I wanted to ensure that there would be no device sharing... 
which this devres conversion accidentally enabled.

The simple fix is obviously to replace pci_request_region() call with 
pci_request_regions() in lib/devres.c, but I wonder if that will break 
any existing driver?

	Jeff


