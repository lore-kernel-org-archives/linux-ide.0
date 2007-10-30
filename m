From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly compatible
 emulations
Date: Tue, 30 Oct 2007 09:57:23 -0400
Message-ID: <47273843.2010007@garzik.org>
References: <20071025142116.7e38ee86@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57965 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040AbXJ3N5f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:57:35 -0400
In-Reply-To: <20071025142116.7e38ee86@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Some it821x RAID firmwares return 0 for the err return off both devices.
> A similar issue occurs with the slave returning 0 not 1 if you plug a
> gigabyte sata ramdisk into a controller that fakes two SATA ports as
> master/slave on an SFF channel.
> 
> The patch does the following
> 
> - Allow the 'failed diagnostics' case on both master and slave
> - Move the HORKAGE_DIAGNOSTIC check after ->dev_config
> 
> This second change also allows IT821x to fix up a problem where we report
> drive diagnostic failures when in fact the drive is fine but the
> microcontroller firmware doesn't appear to get it right. IT821x clears
> the flag again to avoid giving the user bogus warnings about their disk.
> 
> The other IT821x change is a bit ugly, we slightly abuse the cable type
> hook to fiddle with the identify data for the devices. We could add a new
> hook for this but as we have only one offender and no more seeming likely
> it seems better to keep libata-core clean.
> 
> Please let this sit in -mm briefly, just in case the relaxed checking
> breaks some other emulated interface.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #for-testing


