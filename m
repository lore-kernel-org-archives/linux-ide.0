From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 10:22:42 -0500
Message-ID: <44046AC2.1060002@pobox.com>
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com> <20060228151928.GC24981@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8331 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751374AbWB1PWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 10:22:45 -0500
In-Reply-To: <20060228151928.GC24981@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> Upstream 2.6.x certainly _does_ care about suspend/resume! To me, this
> patch seems simple enough to be included. It's little more than
> splitting the register init out form the port_stop/start functions and
> calling them on resume/suspend appropriately.

Upstream _libata_ doesn't care much about suspend/resume.  Officially, 
its a work in progress with major pieces -- your patch and ACPI -- still 
missing.

Further, good improvements covering some of the changes in Hannes' patch 
are already in #upstream.

Thus, it's more work than its worth to care about the patch as-is.  It 
should be redone against #upstream, which is where all suspend/resume 
development is occurring.

	Jeff


