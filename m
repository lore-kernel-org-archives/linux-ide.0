From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata: add @disable_on_err argument to ata_set_mode()
Date: Fri, 24 Mar 2006 23:03:55 -0500
Message-ID: <4424C12B.7070106@pobox.com>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3478 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750754AbWCYEEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 23:04:06 -0500
In-Reply-To: <20060325011432.GE5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_set_mode() used to disable whole port on failure.  This patch adds
> @disable_on_err which makes ata_set_mode() disable failing devices
> when non-zero, and simply return when zero.  Due to the port-wide
> characteristic of ATA xfer mode configuration, ata_mode_set() is the
> final place to determine device offlining; thus, the @disable_on_err
> mechanism to tell it which action to take on failure.
> 
> With this patch, only failing devices are disabled not the whole port.
> Transfer mode configuration must consider all devices on the port
> regardless of failure status; otherwise, device selection timing can
> be violoated resulting in malfunction.  This patch makes
> ata_dev_xfermask() consider disabled but present devices such that
> device timing selection timing is honored.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, but dropped due to dropping patch #1


> As said in the above comment, this patch makes sure that present but
> disabled devices are taken into account when determining transfer
> mode.  If IDENTIFY data is present, it is used; otherwise, PIO0 is
> forced.  I think this should be enough.

Several follow-up comments:

* Ideally, I think libata should re-read the identify data from the 
device.  This (a) makes sure PIO is working, and (b) tells us for 
certain what mode the device is.  That's fine for a follow-up patch 
though, since few will exercise this code anyway.

* skipping ->post_set_mode() in this error case being discussing is 
probably unwise.

BTW, got any PATA hardware lying about?  Since you're wandering into 
xfer mode territory, it would better to test PATA than SATA, as xfer 
mode matters more in the PATA realm.  Intel PATA should be fairly easy 
to find, covered by ata_piix, and all the docs are on developer.intel.com.

	Jeff


