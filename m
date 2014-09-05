From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v2 6/6] pata_marvell: use async probe
Date: Fri, 5 Sep 2014 16:15:35 +0900
Message-ID: <20140905071535.GA9323@mtj.dyndns.org>
References: <1409899047-13045-1-git-send-email-mcgrof@do-not-panic.com>
 <1409899047-13045-7-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59206 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaIEHPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Sep 2014 03:15:45 -0400
Content-Disposition: inline
In-Reply-To: <1409899047-13045-7-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, falcon@meizu.com, tiwai@suse.de, arjan@linux.intel.com, linux-kernel@vger.kernel.org, oleg@redhat.com, hare@suse.com, akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp, joseph.salisbury@canonical.com, bpoirier@suse.de, santosh@chelsio.com, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-ide@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, patrakov@gmail.com

On Thu, Sep 04, 2014 at 11:37:27PM -0700, Luis R. Rodriguez wrote:
> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
> index ae9feb1..6a543b9 100644
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -175,6 +175,7 @@ static struct pci_driver marvell_pci_driver = {
>  	.suspend		= ata_pci_device_suspend,
>  	.resume			= ata_pci_device_resume,
>  #endif
> +	.driver.async_probe = true,

You can't do this.  There's nothing special about pata_marvell.  Sure
there was a bug report which made long probe durations more common on
this driver on certain configurations but those long durations can
happen on *any* libata driver and singling out pata_marvell for async
probing is adding a different probing behavior basically arbitrarily.
I really can't see how this marking random drivers with async probing
would work, so one driver does synchronous probing while the
equivalent next one doesn't?  That's crazy.

Thanks.

-- 
tejun
