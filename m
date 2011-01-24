From: viresh kumar <viresh.kumar@st.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Mon, 24 Jan 2011 16:50:29 +0530
Message-ID: <4D3D607D.7030401@st.com>
References: <4D395B74.1010705@st.com> <20110121101400.GC2832@htj.dyndns.org> <4D395FE8.8000902@st.com> <4D39752B.7000202@st.com> <20110121163906.GG2832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:54158 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129Ab1AXLVO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 06:21:14 -0500
In-Reply-To: <20110121163906.GG2832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>, viresh kumar <viresh.nitj@gmail.com>

Tejun,

On 01/21/2011 10:09 PM, Tejun Heo wrote:
>> > As suggested by you earlier, i am doing following on card insertion and removal,
>> > after resetting card through controller.
>> > 
>> > 		ata_ehi_hotplugged(ehi);
>> > 		ata_port_freeze(ap);
>> > 
>> > and after that only i get that error message through following path:
>> > Kthread()->scsi_error_handler()->ata_scsi_error()->ata_bmdma_error_handler()
>> > ->ata_sff_error_handler()->ata_do_eh()
> Hmmm... okay, so that's from the hotplugging.
> 
>> > I tried again, but couldn't find why i am getting these two issues:
>> > 	ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> Yeah, it should be possible to avoid the above if it's coming from
> hotplug.  Identify where and why AC_ERR_ATA_BUS is being set and work
> around it.  There's no reason for it to be set after a hotplug anyway.
> 

I debugged it further, ehi->err_mask |= AC_ERR_ATA_BUS is done in
ata_ehi_hotplugged(). I tried to find the place where it should be cleared in
code path, but couldn't find it.

Further i checked the order in which code is executed and taken dump of that:
ata_ehi_hotplugged, ata_port_freeze, ata_port_abort, ata_do_link_abort,
ata_port_schedule_eh, scsi_schedule_eh.

And just after this following error was printed:
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen

I feel ata_port_schedule_eh() shouldn't have been called. It is called because
there were no qc's in ata_port.

--
viresh
