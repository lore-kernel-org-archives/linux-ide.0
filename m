From: Greg KH <greg@kroah.com>
Subject: pci_get_device_reverse(), why does Calgary need this?
Date: Tue, 12 Feb 2008 16:16:38 -0800
Message-ID: <20080213001638.GB13933@kroah.com>
References: <20080213001506.GA13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59745 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbYBMASk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 19:18:40 -0500
Content-Disposition: inline
In-Reply-To: <20080213001506.GA13933@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: muli@il.ibm.com, jdmason@kudzu.us
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Tue, Feb 12, 2008 at 04:15:06PM -0800, Greg KH wrote:
> Hi,
> 
> I'm reworking the pci device list logic (we currently keep all PCI
> devices in 2 lists, which isn't the nicest, we should be able to get
> away with only 1 list.)
> 
> The only bother I've found so far is the pci_get_device_reverse()
> function, it's used in 2 places, IDE and the calgary driver.

Why does the calgary driver need this?  Can we just use pci_get_device()
instead?  Why do you need to walk the device list backwards?  Do you get
false positives going forward?

thanks,

greg k-h
