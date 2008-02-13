From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Wed, 13 Feb 2008 11:32:26 +0200
Message-ID: <20080213093225.GA16985@rhun.haifa.ibm.com>
References: <20080213001506.GA13933@kroah.com> <20080213001638.GB13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:57616 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYBMJcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 04:32:31 -0500
Content-Disposition: inline
In-Reply-To: <20080213001638.GB13933@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: jdmason@kudzu.us, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Tue, Feb 12, 2008 at 04:16:38PM -0800, Greg KH wrote:

> Why does the calgary driver need this?  Can we just use
> pci_get_device() instead?  Why do you need to walk the device list
> backwards?  Do you get false positives going forward?

It's not strictly needed, we used it for symmetry. Feel free to nuke
it and walk the list forward.

Cheers,
Muli
