From: Tejun Heo <htejun@gmail.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Tue, 26 Feb 2008 08:44:41 +0900
Message-ID: <47C352E9.4060107@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com> <47C248C8.9090409@rtr.ca> <47C2503A.7040308@gmail.com> <47C2F308.1080602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:48786 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbYBYXow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 18:44:52 -0500
Received: by gv-out-0910.google.com with SMTP id s4so750120gve.37
        for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2008 15:44:51 -0800 (PST)
In-Reply-To: <47C2F308.1080602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Hello, Mark.

Mark Lord wrote:
> MMmm.. maybe the "vendor unique FIS" mechanism of the chipset
> can save the scenario here.  It would seem to be a reasonable
> way to direct a FIS (anything up to 8KB) at a specific pmp,
> without changing the "default" pmp on the channel.
> 
> I can have qc_issue use that mechanism for anything destined
> for pmp==15.  If it works.  The Marvell proprietary driver
> has some kludgey status polling wrapped around their own use of it.
> 
> One of the chip errata apparently requires this anyway for doing
> the READ_LOG_EXT commands after a device error, so perhaps it will
> work out to be useful in more ways.

Hmmm...

> Speaking of which.. I would like to sort out the "freeze" stuff,
> so that the sata_mv EH doesn't lock out the PMP commands as it
> does today.
> 
> Can you recap what a LLD should be doing in the presence of a PM
> for EH purposes?  Eg. media error on a PMP drive, so what core
> ATA functions should the sata_mv EH interrupt handler be calling,
> and in what sequence.. so that the libata-pmp/eh code can still
> succeed in it's queries to the PM?

libata doesn't really put much restrictions on what a LLD should do on
entering EH and if the controller's behavior is predictable, there's no
reason to freeze the port.  If the problem is that the DMA engine isn't
usable after PMP error but it's known that the controller isn't gonna
cause irq storm, no need to freeze.  The only command EH issues before
resetting which can use DMA protocol is READ_LOG_EXT.  Maybe there needs
to be a way to force PIO protocol for READ_LOG_EXT.  Other than that, if
no-data and PIO-only commands work fine, EH autopsy should work fine.

> Like I noted before, sata_mv will need to eventually hard reset
> the channel regardless, but it does seem permitted to use PIO
> or vendor-unique-FIS PIO (with polling for either) in the interim.

Just set ATA_EH_HARDRESET (which will soon become ATA_EH_RESET with
prefer-COMRESET patchset) from the interrupt handler before requesting EH.

Thanks.

-- 
tejun
