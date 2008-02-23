From: Tejun Heo <htejun@gmail.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sat, 23 Feb 2008 11:43:37 +0900
Message-ID: <47BF8859.4000505@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:53294 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbYBWCnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 21:43:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so701773wah.23
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 18:43:43 -0800 (PST)
In-Reply-To: <47BEDAF2.8000301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jeff@garzik.org>

Hello, Mark.

Mark Lord wrote:
>> This patch provides two new struct ata_port_operations methods for this,
>> and modifies the code in libata-pmp to use them if provided.
> ...
> 
> Note that, while this does work for sata_mv, I'm still thinking about it.
> 
> I'm not totally clear yet (more reading to do) as to how/when
> the ATA shadow/taskfile registers get updated to reflect those
> for the currently selected pmp..
> 
> It would seem that with other parts of libata-sff directly reading
> from the ctl, status, and altstatus "registers" during polling,
> command setup, and probing, that there might (?) be a loophole
> somewhere in this strategy.

Yeah, this is an interesting problem.  There are basically multiple sets
of TF registers and the SFF way of assuming single set doesn't really
work well and I don't really think adding ->pmp_read/write is the
correct long term solution to the problem.  We need to confine direct TF
register accesses to SFF layer only as controllers which don't implement
SFF interface may or may not emulate TF registers and even when they do,
it sometimes can't really match the SFF behavior.

For command execution, TF write is already performed by qc_prep and
issue and TF read back should be performed by LLD if RESULT_TF is set.
For EH, the reset methods should be responsible whether or how the TF
registers are accessed.

Mark, for your case, I think the correct thing to do is to factor out
the necessary bare-bone part from SFF implementation and use it with
necessary PMP register setup once the necessary change is made to the
core layer.  The controller is NOT a SFF one and I don't think
stretching SFF implementation to fit mv's PMP-aware emulation of it is a
good idea.  Maybe we can fit libata to it but it's likely we'll need to
modify it again to fit different emulation from different vendor.

> Is this scenario going to be possible:  somebody calls sata_pmp_read()
> as part of, say, hotplug polling, and after that operation completes
> we then have code that calls ata_check_status() prior to the next
> tf_load / command issue ?  If so, they'll see the wrong cached shadow
> status register.

I think what should happen is that any of TF registers isn't accessed
behind LLD's back.  Then, you don't have nothing to worry about.  If the
controller emulates some of SFF interface, you can always properly wrap
SFF helpers with necessary setup and teardown added.

> Mmm.. an amazing amount of complexity there for something that
> ought to be very simple.

I wish things are a bit clearer now.  I think the problem here is that
we're assuming SFF TF access on controllers which aren't really SFF.
For sil24 and ahci, the driver emulates it and it isn't too difficult.
The picture gets more interesting for sata_mv as its hardware interface
much closer to SFF than sil24 or ahci and TF registers matter much more.
 For ahci and sil24, LLD can just fool libata core layer which assumes
ubiquitous TF access.  TF registers don't really matter to controller
operation anyway and feeding bogus values work well.  For sata_mv, it's
different.  Those registers are integral part of controller operation
and sata_mv can't really tolerate core layer stepping in w/o notifying LLD.

Thanks.

-- 
tejun
