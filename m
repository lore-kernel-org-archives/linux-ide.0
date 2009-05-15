From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #sx4] sata_sx4: fixup interrupt handling
Date: Fri, 15 May 2009 14:08:48 -0400
Message-ID: <4A0DAFB0.1040604@garzik.org>
References: <20090513230221.GB5863@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55631 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbZEOSJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 May 2009 14:09:08 -0400
In-Reply-To: <20090513230221.GB5863@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: mikpe@it.uu.se, tj@kernel.org, linux-ide@vger.kernel.org

David Milburn wrote:
> Issuing ATA_CMD_SET_FEATURES (0xef) times out because 
> pdc20621_interrupt ignores command completion since
> ATA_TFLAG_POLLING flag is set.
> 
> This has already been fixed for sata_promise:
> 
> commit 51b94d2a5a90d4800e74d7348bcde098a28f4fb3
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Fri Jun 8 13:46:55 2007 -0700
> 
>     sata_promise: use TF interface for polling NODATA commands
> 
> Also, this patch includes Mikael's original patches:
> 
> http://marc.info/?l=linux-ide&m=121135828227724&w=2
> http://marc.info/?l=linux-ide&m=121144512109826&w=2
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/sata_sx4.c |   22 +++++++++-------------
>  1 files changed, 9 insertions(+), 13 deletions(-)

applied, and forwarding upstream (w/ #sx4 branch) for 2.6.30, since 
sata_sx4 is broken.


