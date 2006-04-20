From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Thu, 20 Apr 2006 16:11:41 +0900
Message-ID: <20060420071141.GD25726@htj.dyndns.org>
References: <114476330353-git-send-email-htejun@gmail.com> <1145512872.3417.47.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:49577 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbWDTHLe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 03:11:34 -0400
Received: by pproxy.gmail.com with SMTP id i49so97594pye
        for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 00:11:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1145512872.3417.47.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Thu, Apr 20, 2006 at 02:01:12PM +0800, zhao, forrest wrote:
> 
> Hi, Tejun
> 
> When testing hotplug and reading your patches, I thought an interrupt
> lost might occur on AHCI in the following case:
> 
> 1 system boot up with SATA disk A attached to port 1 and disk B attached
> to port 2
> 2 disk B at port 2 is hot-unplugged
> 3 ata_eh_revive() will execute several round of soft-reset/hard-reset as
> we observed in dmesg
> 4 now imagine ata_eh_revive() start to execute the last round of
> hard-reset, so the code path comes into ata_do_reset(), then into
> ahci_hardreset()
> 5 disk B is hot-plugged to port 2, and an interrupt is triggered
> 6 CPU respond to this interrupt when code path execute between
> ahci_start_engine(); in ahci_hardreset() and
> ap->flags &= ~ATA_FLAG_FROZEN; in ata_do_reset();
> 7 then this interrupt is lost since no EH is scheduled to handle it.
> 
> I think invoking ata_eh_schedule_port() in ahci_postreset() can fix
> the problem, is it right?

Hello, Forrest.

Yes, you're right.  The problem is that we cannot tell whether such
interrupts are due to the reset or some other events.  The goal was to
make sure existing devices are okay on EH completion.  If new devices
get connected during EH, we might lose the event, which IMHO is okay.

Maybe this can be solved by merging EH and probe into one.  Probing
and EH revive are pretty similar in the first place.  I'll think about
that.  But I still think it's okay to lose hotplug interrupt during
EH.  All the user has to do is simply replug the device or issue
manual scan.

Thanks.

-- 
tejun
