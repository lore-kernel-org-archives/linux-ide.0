From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Fri, 2 Sep 2011 10:13:05 +0900
Message-ID: <20110902011305.GE2752@htj.dyndns.org>
References: <20110430140109.GJ29280@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com>
 <20110525094127.GF10146@htj.dyndns.org>
 <4DF20E03.9030502@teksavvy.com>
 <20110610140155.GJ15235@htj.dyndns.org>
 <4DF25526.9010800@teksavvy.com>
 <20110611121957.GA7980@mtj.dyndns.org>
 <4DF4F30B.70702@teksavvy.com>
 <20110613104856.GC16021@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32D8D984D03@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43999 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab1IBBNN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Sep 2011 21:13:13 -0400
Content-Disposition: inline
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32D8D984D03@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

On Mon, Aug 29, 2011 at 04:49:29PM +0100, Bruce Stenning wrote:
> I should mention that we are now working on kernel 2.6.39.4 (and are choosing
> not to go with 3.x to limit changes as we progress towards final testing.)

I don't think it would make any difference.  The core EH hasn't
changed for some time now.

> [...]
> ata4: EH complete
> ata_scsi_error: EXIT
> __ata_port_freeze: ata4 port frozen
> ata_port_schedule_eh: port EH scheduled
> ata_scsiop_noop: ENTER
> ata_scsiop_read_cap: ENTER
> ata_scsiop_mode_sense: ENTER
> ata_scsiop_mode_sense: ENTER
> ata_scsiop_mode_sense: ENTER

That's weird.  Another EH is scheduled after one completes but EH
doesn't kick in.  Hmmm... can't see how that can happen.  How easily
can you reproduce the problem?

Thanks.

-- 
tejun
