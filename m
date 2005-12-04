From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
Date: Mon, 05 Dec 2005 01:44:15 +0900
Message-ID: <43931CDF.3080202@gmail.com>
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com> <438D3AA8.9030504@gmail.com> <438FAADC.6060907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932277AbVLDQoZ@vger.kernel.org>
In-Reply-To: <438FAADC.6060907@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
>> m15w quirk for 3114's for the time being?  Better be slow than hang. 
>> Whatever bug the m15w quirk was hiding.
> 
> 
> A generic 'slow_down_io' module option is reasonable.
> 
> It is not appropriate to apply mod15write quirk to hardware that isn't 
> affected by the chip bug.
> 
> A better solution is to write a 311x-specific interrupt handler.
> 

Hello, Jeff.  Hello, Carlos.

I bought a sii3114 controller yesterday and took out my ST3120026AS for 
testing.  The drive times out during a WRITE_EXT, and locks up.

* The ST3120026AS works perfectly on a VIA controller.
* The sii3114 controller works perfectly with Maxtor 6B080M0 drives.

I don't know.  It acts and smells like m15w problem.  What are the odds 
of having the same symptom on the same combination?

Also, I've asked one of my friends who has a sii3512 onboard controller 
and an affected seagate drive to test.  The harddisk works on 2.6.13 
with the quirk, but it freezes on 2.6.14.  m15w affected seagate drives 
does _NOT_ work on 3512 and 3114 on 2.6.14, be it m15w or something else.

-- 
tejun
