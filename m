From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Fri, 09 May 2008 11:06:26 -0400
Message-ID: <48246872.8000502@rtr.ca>
References: <20080508161008.59361de5@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3219 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYEIPG1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 May 2008 11:06:27 -0400
In-Reply-To: <20080508161008.59361de5@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> power off unused ports
> 
> If the port isn't either a drive bay or an external SATA port, do not 
> keep the phy powered on if the port is unoccupied. This saves .75 watts
> on most laptops.  A module parameter can be used to override this 
> behavior and allow the phy's to be powered up regardless of whether it
> has externally accessible SATA ports. 
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
..
> +static void ata_phy_offline(struct ata_link *link)
> +{
> +	u32 scontrol;
> +	int rc;
> +
> +	/* set DET to 4 */
> +	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
> +	if (rc)
> +		return;
> +	scontrol &= ~0xf;
> +	scontrol |= (1 << 2);
> +	sata_scr_write(link, SCR_CONTROL, scontrol);
> +}
..

I don't like to be picky, but we already have an "ata_link_offline"
function in libata, which tests *whether* a link is offline,
as opposed to *setting* a link to be offline.

So in that context, I find the name ata_phy_offline slightly confusing.
Perhaps something like ata_set_phy_offline would make it more clear?

And a more general note:  I still believe we should have a follow-up
feature to this one, to enable polling for newly inserted drives.

That would allow powering down idle ports to save money/planet/whatever,
but still with hotplug capability.  The polling interval should be
tunable in /sys, with a default of, say, once every couple of seconds.

Thanks for working on this stuff.

Cheers
