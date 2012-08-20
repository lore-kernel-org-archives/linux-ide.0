From: Tejun Heo <tj@kernel.org>
Subject: Re: Deferred disk spinup during system resume
Date: Mon, 20 Aug 2012 13:57:46 -0700
Message-ID: <20120820205746.GV24861@google.com>
References: <CAN8TOE_Y2EgSoK4euCC6fp1jr8bKyjdoVJq=Kk8fnG6qZboTGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45427 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2HTU5u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2012 16:57:50 -0400
Content-Disposition: inline
In-Reply-To: <CAN8TOE_Y2EgSoK4euCC6fp1jr8bKyjdoVJq=Kk8fnG6qZboTGQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

Hello, Brian.

On Fri, Aug 17, 2012 at 07:12:30PM -0700, Brian Norris wrote:
> I understand that your original patch was given the "not tested"
> disclaimer, but I wanted to know if you had any immediate advice on
> why this failed so miserably for me, before I go trying to dig in to
> this issue more deeply. For instance, maybe there's been enough code
> change between 2.6.37 and 3.3 (or current upstream - 3.6-rc2) that
> would require a change in approach.

Yeah, I'm not particularly fond of how resume is implemented.  It can
and should be more asynchronous, I think. :( Unfortunately, I'm a bit
too preoccupied at the moment.  A quick & dirty hack would be simply
skipping ATA_CMD_VERIFY so that the drive spins up on the actual next
command.  If that's acceptable, just add "goto skip;" right after "if
(cdb[4] & 0x1)" test in ata_scsi_start_stop_xlat().

Thanks.

-- 
tejun
