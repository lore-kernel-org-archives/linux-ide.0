From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux libata, Sil3124, and SATA staggered spin-up support
Date: Wed, 11 Apr 2007 17:22:10 +0900
Message-ID: <461C9AB2.9070807@gmail.com>
References: <20070331162941.93F61582C@rmail.inner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:9427 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXDKIWQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 04:22:16 -0400
Received: by nz-out-0506.google.com with SMTP id s1so70930nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 01:22:15 -0700 (PDT)
In-Reply-To: <20070331162941.93F61582C@rmail.inner.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Metz <cmetz@inner.net>
Cc: linux-ide@vger.kernel.org

Hello,

Craig Metz wrote:
>   I was hoping that Linux would be able to do staggered spin-up itself in a
> reasonable manner. And, if it doesn't today, I am hoping that is just a matter
> of someone writing the code.
> 
>   I have done some digging in with the 2.6.20.3 libata code, and one thing I
> have noticed that is specific to the Sil3124 driver is that the controller
> init function starts up all the ports, which spins up all the drives. Does
> anyone know if the Sil3124 hardware really supports the necessary things to do
> staggered spin-up in a rational manner? I have done some digging and some
> playing with the code, and from what I see, the controller likes to either
> cause all the ports to come up (drives to spin up) or not.

Yeah, the silicon can do staggered spin up.  SATA disks shouldn't spin
up till PHY gets reset.  libata currently probes each port serially, so
it should sequentially spin up each drive.  Or do they spin up during
controller initialization?

>   Is this something that folks would be willing to support in libata if
> reasonable code existed? At some level, staggered spin-up should be done in
> the BIOS. However, I expect that Sil3124 is far from the only controller whose
> BIOS does it wrong but could be disabled. So I personally see value in having
> Linux able to do it and do it right, but if you two don't and the patch would
> never go in, then I would be wasting my time continuing to work on this.

Yeah, staggered spin up support would be good to have.

>   What is the right sequence of events for staggered spin-up? I was thinking
> that the process should as a first cut happen iteratively/serially:
> 
>   Init controller
>   Add controller to libata, get resources
>   for each port
>     Init port
>     Add port to libata
>     Tell SCSI layer to identify
> 
>   This is a different flow than what libata/Sil3124 currently does:
> 
>   Init controller
>   for each port
>     Init port
>   Add controller to libata
>   for each port
>     More init port
>     Add port to libata
>   Get resources
>   for each port 
>     Tell SCSI layer to identify
> 
>   I am not an expert on libata, so I don't really understand the design
> decisions that led to the current design. I would greatly appreciate it if
> you had any suggestions or could give me additional clues about what the
> right design should be to implement a feature like this along with everything
> else libata needs to do.

Hmmm... Most of ATA probing occurs in EH between ata_port_schedule_eh()
and ata_port_wait_eh() in ata_device_add().  For ATAPI devices, SCSI
probing plays a role but for ATA devices the probing just fetches some
info from libata and configures SCSI layer accordingly.

-- 
tejun
