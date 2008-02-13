From: Greg KH <greg@kroah.com>
Subject: "ide=reverse" do we still need this?
Date: Tue, 12 Feb 2008 16:15:07 -0800
Message-ID: <20080213001506.GA13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59743 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbYBMASk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 19:18:40 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

Hi,

I'm reworking the pci device list logic (we currently keep all PCI
devices in 2 lists, which isn't the nicest, we should be able to get
away with only 1 list.)

The only bother I've found so far is the pci_get_device_reverse()
function, it's used in 2 places, IDE and the calgary driver.

I'm curious if we really still support the ide=reverse option?  It's a
config option that I don't think the distros still enable (SuSE does
not).  Is this still needed these days?

In digging, we changed this option in 2.2.x from being called
"pci=reverse" and no one else seems to miss it.

Any thoughts?

thanks,

greg k-h
