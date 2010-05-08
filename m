From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Sat, 08 May 2010 17:53:30 -0400
Message-ID: <4BE5DD5A.8030701@garzik.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org> <4BE31D57.6020400@garzik.org> <4BE3A1A6.1040106@kernel.org> <4BE48742.8060604@garzik.org> <4BE52383.9080908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55642 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab0EHVxd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 May 2010 17:53:33 -0400
Received: by vws3 with SMTP id 3so625441vws.19
        for <linux-ide@vger.kernel.org>; Sat, 08 May 2010 14:53:33 -0700 (PDT)
In-Reply-To: <4BE52383.9080908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 05/08/2010 04:40 AM, Tejun Heo wrote:
> On 05/07/2010 11:33 PM, Jeff Garzik wrote:
>> I'm not sure the usefulness is limited, as it definitely avoids power
>> spikes on server BIOSen that care.
>
> So, are there actually machines which get affected by this?  In that
> case, sure, the current behavior is the right one.

The current behavior is the safe, conservative interpretation.  The 
alternative is risking unwanted power spikes for the sake of boot speed.

I would set a high barrier for taking that risk:  polling multiple 
hardware vendors about in-the-field SSS usage.


>> Also, it seems unwise for the Linux SATA driver to do the exact
>> -opposite- of what the SSS bit intends, by default.
>
> Yeah, well, the thing is that SSS in itself doesn't really indicate
> need for staggered spin up.  It just says it knows how to.

A valid point, I agree.  But absent any other method of communicating 
that SSS behavior is desired, activating staggered spin-up based on SSS 
is the only logical interpretation, AFAICS.  SSS bit set implies SSS 
-might- be needed.  If SSS might be needed, then one must stagger 
spin-up or risk failing to meet the requirement.  !SSS is the only case 
where you are -guaranteed- not to need staggered spin-up.

	Jeff



