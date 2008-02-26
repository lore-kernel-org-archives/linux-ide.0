From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Mon, 25 Feb 2008 19:12:21 -0500
Message-ID: <47C35965.7030905@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com> <47C248C8.9090409@rtr.ca> <47C2503A.7040308@gmail.com> <47C2F308.1080602@rtr.ca> <47C352E9.4060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4002 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760076AbYBZAJe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:09:34 -0500
In-Reply-To: <47C352E9.4060107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
>
> libata doesn't really put much restrictions on what a LLD should do on
> entering EH and if the controller's behavior is predictable, there's no
> reason to freeze the port.  If the problem is that the DMA engine isn't
> usable after PMP error but it's known that the controller isn't gonna
> cause irq storm, no need to freeze.  The only command EH issues before
> resetting which can use DMA protocol is READ_LOG_EXT.  Maybe there needs
> to be a way to force PIO protocol for READ_LOG_EXT.  Other than that, if
> no-data and PIO-only commands work fine, EH autopsy should work fine.
..

Eh?  READ LOG EXT *is* a PIO command, as opposed to READ LOG DMA EXT
which uses DMA.

And the EH also issues PIO READ_BUFFER commands for PM ports, if a PM is present.

???
