From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 02:41:07 +0100
Message-ID: <47B24AB3.3040009@keyaccess.nl>
References: <20080213001506.GA13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:57167 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYBMBja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 20:39:30 -0500
In-Reply-To: <20080213001506.GA13933@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On 13-02-08 01:15, Greg KH wrote:

> I'm reworking the pci device list logic (we currently keep all PCI
> devices in 2 lists, which isn't the nicest, we should be able to get
> away with only 1 list.)
> 
> The only bother I've found so far is the pci_get_device_reverse()
> function, it's used in 2 places, IDE and the calgary driver.
> 
> I'm curious if we really still support the ide=reverse option?  It's a
> config option that I don't think the distros still enable (SuSE does
> not).  Is this still needed these days?
> 
> In digging, we changed this option in 2.2.x from being called
> "pci=reverse" and no one else seems to miss it.
> 
> Any thoughts?

While details escape me somewhat again at the monment, a few months ago I 
was playing around with a PCI Promise IDE controller and needed ide=reverse 
to save me from having to switch disks around to still have a bootable system.

Or some such. Not too clear anymore, but I remember it saved the day.

Rene.
