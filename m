From: Felix Miata <mrmazda@ij.net>
Subject: Re: [RFC] Separating out libata out of SCSI (finally)
Date: Tue, 24 Jun 2008 12:27:36 -0400
Message-ID: <48612078.3000905@ij.net>
References: <485B2CC6.6070201@kernel.org>	 <1213993737.3443.35.camel@localhost.localdomain>	 <485C31FE.8050408@garzik.org>	 <87f94c370806231404t13586777x7f7bee24ebe25ffc@mail.gmail.com>	 <1214255460.3310.27.camel@localhost.localdomain>	 <4860B099.2030305@panasas.com> <1214318550.3299.7.camel@localhost.localdomain> <48610BDC.6090101@kernel.org> <486115DE.20805@ij.net> <4861176E.8040008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-knobcone.atl.sa.earthlink.net ([207.69.195.64]:57152 "EHLO
	pop-knobcone.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbYFXQ1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 12:27:20 -0400
Received: from user-142grnk.cable.mindspring.com ([72.40.110.244] helo=[192.168.0.51])
	by pop-knobcone.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1KBBMV-0005ww-00
	for linux-ide@vger.kernel.org; Tue, 24 Jun 2008 12:27:19 -0400
In-Reply-To: <4861176E.8040008@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2008/06/25 00:49 (GMT+0900) Tejun Heo apparently typed:

> Felix Miata wrote:

>> On 2008/06/24 23:59 (GMT+0900) Tejun Heo apparently typed:

>>> I'm currently working on a scheme where partitions above gd->minors get
>>> allocated dynamic MAJ:MIN.  It looks like it can be done mostly in block
>>> layer proper.  The only problem I can foresee is not being able to
>>> specify MAJ:MIN as root device but that shouldn't be a major problem.
>>> I'll report back when I make more progress.

>> Please correct me if I'm wrong, but on the following, would it not
>> be a major problem booting, without deleting any existing or moving
>> any existing, with only a few more upgrade cycles to replace what's
>> there installed now with current and near future distros?

> I'm not sure what you mean.  If you switch to libata now, you'll only be
> able to see 15 partitions, so, yes, you'll have problem updating to a

Well, on the Fedora 9 on hda9 that is already the case, as it provided no
option to not use libata. ;-)

> distro which uses libata now and in near future.  If the dynamic
> partition thing goes well, hopefully the next major distro releases work
> fine.

I responded as I did due to your statement "only problem I can foresee is not
being able to specify MAJ:MIN as root device", hoping to see some elaboration
on the statement from you. I read your statement as "don't expect to be able
to use any partition >15 as a root device". So, in the past root=3:17 would
have been a valid replacement for root =/dev/hda17? If so, sorry for the
noise, as I'd never seen that type of usage, and certainly would not miss it.
-- 
"Where were you when I laid the earth's
foundation?"		       Matthew 7:12 NIV

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
