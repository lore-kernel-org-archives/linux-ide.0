From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 16:28:47 +0100
Message-ID: <20060228152847.GE24981@suse.de>
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com> <20060228151928.GC24981@suse.de> <44046AC2.1060002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:27909 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932207AbWB1P3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 10:29:11 -0500
Content-Disposition: inline
In-Reply-To: <44046AC2.1060002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hannes Reinecke <hare@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, Feb 28 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Upstream 2.6.x certainly _does_ care about suspend/resume! To me, this
> >patch seems simple enough to be included. It's little more than
> >splitting the register init out form the port_stop/start functions and
> >calling them on resume/suspend appropriately.
> 
> Upstream _libata_ doesn't care much about suspend/resume.  Officially, 
> its a work in progress with major pieces -- your patch and ACPI -- still 
> missing.

Eh my patch is not missing, it's been merged since the start of
2.6.16-rc. The acpi patch is still missing, however that's not required
on all machines. So SATA suspend should work now, at least on ata_piix
which is the only driver that currently enables it.

For 2.6.15 I agree, we don't care about suspend since it basically
cannot work. That's not the case for 2.6.16 though.

> Further, good improvements covering some of the changes in Hannes' patch 
> are already in #upstream.
> 
> Thus, it's more work than its worth to care about the patch as-is.  It 
> should be redone against #upstream, which is where all suspend/resume 
> development is occurring.

I'm sure Hannes will regenerate against upstream as well if necessary,
however that depends on when this should be applied.

-- 
Jens Axboe

