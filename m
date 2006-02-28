From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 10:14:35 -0500
Message-ID: <440468DB.5060605@pobox.com>
References: <44045FB1.5040408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:57738 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932155AbWB1POh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 10:14:37 -0500
In-Reply-To: <44045FB1.5040408@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> Subject: AHCI suspend / resume fixes.
> 
> The current ahci driver has the problem that it doesn't resume properly.
> Or rather, that resuming is unstable.
> Reason being is that AHCI has 4 registers containing the DMA address it
> should write things to. Of course there is no guarantee that Linux has
> assigned the same address to the DMA area across reboots.
> So we should better re-initialize those registers after resume.
> 
> The patch also improves the port_start / port_stop routines to be more
> closely modelled after the spec. This also avoids a nasty msleep(500)
> during initialisation.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>


Seems sane at first glance, but can you please regenerate this against 
libata-dev.git#upstream ?

Upstream 2.6.x doesn't care at all about suspend/resume, and AHCI has 
seen several modifications in #upstream that are waiting for 2.6.17.

	Jeff


