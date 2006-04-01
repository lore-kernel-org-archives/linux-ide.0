From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 14/15] libata: improve ata_bus_probe()
Date: Sat, 01 Apr 2006 14:58:23 -0500
Message-ID: <442EDB5F.9020402@pobox.com>
References: <1143823099974-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39133 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751606AbWDAT62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:58:28 -0500
In-Reply-To: <1143823099974-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Improve ata_bus_probe() such that configuration failures are handled
> better.  Each device is given ATA_PROBE_MAX_TRIES chances, but any
> non-transient error (revalidation failure with -ENODEV, configuration
> failure with -EINVAL...) disables the device directly.  Any IO error
> results in SATA PHY speed down and ata_set_mode() failure lowers
> transfer mode.  The last try always puts a device into PIO-0.
> 
> After each failure, the whole port is reset to make sure that the
> controller and all the devices are in a known and stable state.  The
> reset also applies SATA SPD configuration if necessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

seems sane at first glance


