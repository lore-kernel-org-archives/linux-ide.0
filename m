From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2/2] set default of ahci driver to power off unused ports
Date: Fri, 04 Jul 2008 09:02:47 -0400
Message-ID: <486E1F77.6010909@garzik.org>
References: <20080702225743.518230210@intel.com> <20080702161407.13be7fc9@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56034 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757934AbYGDNCu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jul 2008 09:02:50 -0400
In-Reply-To: <20080702161407.13be7fc9@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: linux-ide@vger.kernel.org

kristen.c.accardi@intel.com wrote:
> If the port isn't either a drive bay or an external SATA port, 
> mark the port not-hotpluggable.

That's just flat out incorrect, though.

We've been hotplugging SATA cables since SATA began, when the _most 
common_ hotplug case was where a port was neither a drive bay nor eSATA. 
  Part of the beauty of SATA is being able to just 'yank the cable'.

PORT_CMD_ESP and PORT_CMD_HPCP are positive indicators of hotplug 
capability, but are not exclusively such.

So, this patch would create regressions for people in servers or 
desktops or development systems that wish to retain their _existing_ 
ability to hotplug.

One guaranteed way to avoid regressions is to default ahci_power_save to 
zero, but that's then not helpful to Linux users in general, few of 
which will know of this module option and turn it on.

This is actually wandering into system-wide power policy :/

	Jeff



