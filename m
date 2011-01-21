From: Tejun Heo <tj@kernel.org>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Fri, 21 Jan 2011 17:39:06 +0100
Message-ID: <20110121163906.GG2832@htj.dyndns.org>
References: <4D395B74.1010705@st.com>
 <20110121101400.GC2832@htj.dyndns.org>
 <4D395FE8.8000902@st.com>
 <4D39752B.7000202@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60288 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab1AUQjL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2011 11:39:11 -0500
Received: by fxm20 with SMTP id 20so1951178fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2011 08:39:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D39752B.7000202@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>, viresh kumar <viresh.nitj@gmail.com>

Hey,

On Fri, Jan 21, 2011 at 05:29:39PM +0530, viresh kumar wrote:
> This error:
> > # ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> 
> is coming only when i insert/remove my card after board has booted up. If i keep it
> inserted, and then boot the board: No such error occurs.
> 
> As suggested by you earlier, i am doing following on card insertion and removal,
> after resetting card through controller.
> 
> 		ata_ehi_hotplugged(ehi);
> 		ata_port_freeze(ap);
> 
> and after that only i get that error message through following path:
> Kthread()->scsi_error_handler()->ata_scsi_error()->ata_bmdma_error_handler()
> ->ata_sff_error_handler()->ata_do_eh()

Hmmm... okay, so that's from the hotplugging.

> I tried again, but couldn't find why i am getting these two issues:
> 	ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen

Yeah, it should be possible to avoid the above if it's coming from
hotplug.  Identify where and why AC_ERR_ATA_BUS is being set and work
around it.  There's no reason for it to be set after a hotplug anyway.

> 	sda: unknown partition table

and then this probably is unrelated.  So, no IO error is being
reported but the above still fails?  How did you verify the read data
are actually the same?  Maybe there's a cache alias issue?

-- 
tejun
