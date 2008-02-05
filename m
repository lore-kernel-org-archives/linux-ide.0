From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Tue, 05 Feb 2008 21:21:02 +0900
Message-ID: <47A854AE.5070403@gmail.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com> <47A71538.50803@gmail.com> <47A8228B.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.249]:59788 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808AbYBEMVP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 07:21:15 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2166370hsz.5
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 04:21:14 -0800 (PST)
In-Reply-To: <47A8228B.76E4.0078.0@novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jan Beulich wrote:
>> Yes, we can be more smart if necessary.  I don't know.  The hardware is
>> clearly violating the spec which requires those two values to agree.
> 
> So are you saying the ESB2 spec is violating a higher level spec? I know
> almost nothing about AHCI, so please forgive that question...

n_ports and PI should agree with each other.  That's what the ahci spec
requires.  If ESB2 spec has different opinion about n_ports, it's in
violation of AHCI spec but I don't think it explicitly state such
things, does it?

>> What status values are you seeing?  Hardware vendors usually don't get
>> n_ports wrong from the start, they probably have forgotten to decrement
>> it by one when one of the ports is plugged for some reason.  I bet the
>> silicon for the port is there and reporting offline PHY, right?
> 
> This is output from our SLE10SP2 kernel, the output is similar for others:
> 
> <6>scsi2 : ahci
> <6>ata3: SATA link down (SStatus 0 SControl 300)
> <6>scsi3 : ahci
> <6>ata4: SATA link down (SStatus 0 SControl 300)
> <6>scsi4 : ahci
> <6>ata5: SATA link down (SStatus 4 SControl 300)
> <6>scsi5 : ahci
> <6>ata6: SATA link down (SStatus 0 SControl 0)
>
> Even the message relating to ata5 seems a little dubious to me, as it's
> not in sync with what the other unused ports say (and also not in sync
> with what I see on other boxes - SStatus is always 0 for such ports).

I'd like to see more output including leading controller detection but
yeah, it seems there's no silicon implemented for the last port.  The
SStatus value 4 indicates that PHY is offline which usually happens when
the PHY is turned off from SControl.  Hmm... weird.  How many ports does
the machine actually have?  I agree we'll need to adjust PI handling for
the controller.

Thanks.

-- 
tejun
