From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: Deferred disk spinup during system resume
Date: Fri, 14 Sep 2012 20:36:30 -0700
Message-ID: <CAN8TOE9Nxf9X6Ftm0S_zDAU633f1_FhTyvOOLd6R7gN_e=rTMQ@mail.gmail.com>
References: <CAN8TOE_Y2EgSoK4euCC6fp1jr8bKyjdoVJq=Kk8fnG6qZboTGQ@mail.gmail.com>
	<20120820205746.GV24861@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61749 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175Ab2IODgd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2012 23:36:33 -0400
In-Reply-To: <20120820205746.GV24861@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

Hi Tejun,

Thanks for the tips. Sorry for the delay in response; I meant to
respond sooner...

On Mon, Aug 20, 2012 at 1:57 PM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Aug 17, 2012 at 07:12:30PM -0700, Brian Norris wrote:
>> I understand that your original patch was given the "not tested"
>> disclaimer, but I wanted to know if you had any immediate advice on
>> why this failed so miserably for me, before I go trying to dig in to
>> this issue more deeply. For instance, maybe there's been enough code
>> change between 2.6.37 and 3.3 (or current upstream - 3.6-rc2) that
>> would require a change in approach.
>
> Yeah, I'm not particularly fond of how resume is implemented.  It can
> and should be more asynchronous, I think. :( Unfortunately, I'm a bit
> too preoccupied at the moment.

I understand the "preoccupied"! I'm interested in seeing this done at
some point, but like you, I don't have a lot of time. And unlike you,
I'm not so familiar with the current resume process :(

> A quick & dirty hack would be simply
> skipping ATA_CMD_VERIFY so that the drive spins up on the actual next
> command.  If that's acceptable, just add "goto skip;" right after "if
> (cdb[4] & 0x1)" test in ata_scsi_start_stop_xlat().

This worked OK. However, it means that the drive doesn't even start
spinning up until resume is totally complete and somebody/something
makes a request to the drive. Then, the requester waits just as long
for the spinup. This isn't really "asynchronous" as much as reordering
the resume sequence (or delaying spinup indefinitely, if the disk is
not being used).

Regards,
Brian
