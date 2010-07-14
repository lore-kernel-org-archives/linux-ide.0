From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: timeout problems on onboard SATA 6.0 controller on Asus P7H57D-V
 EVO
Date: Tue, 13 Jul 2010 19:44:36 -0600
Message-ID: <4C3D1684.3050107@gmail.com>
References: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se> <4C3962C8.60000@gmail.com> <alpine.DEB.1.10.1007110842150.23489@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49367 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0GNBoj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 21:44:39 -0400
Received: by iwn7 with SMTP id 7so6462691iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 13 Jul 2010 18:44:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.1007110842150.23489@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: linux-ide@vger.kernel.org

On 07/11/2010 12:47 AM, Mikael Abrahamsson wrote:
> On Sun, 11 Jul 2010, Robert Hancock wrote:
>
>> Unfortunately that's a pretty generic timeout error that could be
>> caused by quite a few things, like a hardware issue, bad cable, etc.
>> as well as possible driver problem..
>
> Oki, in my case I saw it with multiple drives (all WD though) and
> multiple cables, but with just a single motherboard. The other people in
> the threads I quoted seem to have worked around it by disabling NCQ. I
> saw it on both channels on my motherboard as well, but I guess that
> could be hardware issue. I don't really have any way of fault finding
> this further as I have no lab machine, but it was fairly easy to
> reproduce (letting mdadm hammer the drive with an array check made it
> happen every time).
>
> mdadm never kicked the drive, so whatever was going on was handled
> gracefully, but of course any file access was stopped for 10+ seconds.

In a lot of cases with people having trouble when running multiple hard 
drives in a machine - especially with simultaneous access situations, 
like a RAID check/rebuild - the problem has been a power issue. It seems 
that some hard drives can cause power draw spikes that some PSUs can't 
handle, especially if multiple drives are connected to the some cable 
from the power supply.
