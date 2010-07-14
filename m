From: "Paul Check" <paul@thechecks.ca>
Subject: Re: timeout problems on onboard SATA 6.0 controller on Asus
 P7H57D-V EVO
Date: Wed, 14 Jul 2010 02:56:52 -0400
Message-ID: <840a37fc6ead7840793234cdef8c90c4.squirrel@thechecks.ca>
References: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se>
    <4C3962C8.60000@gmail.com>
    <alpine.DEB.1.10.1007110842150.23489@uplift.swm.pp.se>
    <4C3D1684.3050107@gmail.com>
    <alpine.DEB.1.10.1007140839020.9875@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:3738 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751380Ab0GNG44 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 02:56:56 -0400
In-Reply-To: <alpine.DEB.1.10.1007140839020.9875@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

I have an 850W PSU...and I have my drives split across rails. My drives
are raided and the problem I have is that on boot, about 25-45% of the
time one drive will be missing, so I have to reboot again, hoping that it
appears and rebuild my RAID.  It's quite annoying.  I don't think it's a
montherboard issue since the Windows drive never seems to be missing when
Windows boots....   ....   ....    P

> On Tue, 13 Jul 2010, Robert Hancock wrote:
>
>> In a lot of cases with people having trouble when running multiple hard
>> drives in a machine - especially with simultaneous access situations,
>> like a RAID check/rebuild - the problem has been a power issue. It seems
>> that some hard drives can cause power draw spikes that some PSUs can't
>> handle, especially if multiple drives are connected to the some cable
>> from the power supply.
>
> I have a 550W common rail PSU and after moving the drive away from the
> SATA 6 port to a SiL controller port I haven't seen any more problems.
>
> I saw the same timeouts when I first did some lab with the same
> motherboard, then I only had 1-2 drives in the machine. I doubt my
> perticular problem is power related.
>
> It's a consistent problem, either it's a hw issue with my motherboard or
> it's a driver issue.
>
> --
> Mikael Abrahamsson    email: swmike@swm.pp.se
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


