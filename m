From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 09:45:54 -0500
Message-ID: <44046222.4090008@rtr.ca>
References: <44045FB1.5040408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:31932 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751002AbWB1OqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 09:46:00 -0500
In-Reply-To: <44045FB1.5040408@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hannes Reinecke wrote:
> Hi all,
> 
> the current ahci doesn't handle suspend / resume cycles too well.
> On certain machines the disk just locks up and refuses to work after a
> resume.
> 
> This is due to a initialisation error after resume; ahci has fo[u]r
> registers containing DMA addresses (which are obviously allocated by the
> kernel). Of course there is no guarantee that these addresses are
> unchanged across reboots. So ahci loads the suspended image, and after
> the suspended image is started the driver is presented with different
> DMA addresses, whereas the chip still uses the original ones.
> 
> This patch rearranges the suspend / resume code to properly initialise
> those registers after a resume. It also contains some initialisation
> fixes to make the driver behave more spec-compliant.
..

Is ahci the *only* interface afflicted with this problem?
