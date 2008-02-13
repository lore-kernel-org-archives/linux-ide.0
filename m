From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Wed, 13 Feb 2008 02:17:37 +0000
Message-ID: <20080213021737.72b9815d@core>
References: <20080213001506.GA13933@kroah.com>
	<20080213001638.GB13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40999 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753345AbYBMCZY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 21:25:24 -0500
In-Reply-To: <20080213001638.GB13933@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: muli@il.ibm.com, jdmason@kudzu.us, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

> Why does the calgary driver need this?  Can we just use pci_get_device()
> instead?  Why do you need to walk the device list backwards?  Do you get
> false positives going forward?

It doesn't look to be performance critical so the driver can
pci_get_device until the end and use the final hit anyway. IDE reverse is
more problematic but nobody seems to use it.
