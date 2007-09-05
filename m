From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 05 Sep 2007 05:08:00 -0700
Message-ID: <46DE9C20.9030007@vc.cvut.cz>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz> <46DC030E.9070704@gmail.com> <46DCB709.902@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:48269 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbXIEMJO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Sep 2007 08:09:14 -0400
In-Reply-To: <46DCB709.902@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org

Petr Vandrovec wrote:
> Tejun Heo wrote:

Hello,

>>
>> Petr Vandrovec wrote:
>>> I have recompiled kernel with all debugging disabled, and it brought me
>>> 1.5MBps, so it is still consistently 1MBps slower than on sil. Disabling
>>> NCQ seems to improve concurrent access a bit (for which I have no
>>> explanation), while slows down single drive scenario:
>>>
>>> With NCQ:
>>>
>>> 1TB alone: 81.22, 79.86
>>> 1TB+1TB:   56.28+56.70, 53.51+56.11
>>>
>>> Without NCQ:
>>>
>>> 1TB alone: 79.78, 80.82
>>> 1TB+1TB:   57.99+58.12, 56.50+56.46
> 
> 3124-2 (norco 4618):
> 
> NCQ:
> 
> 1TB alone:   82.30, 82.43
> 1TB+1TB:     68.36+68.25
> 
> noNCQ:
> 
> 1TB alone:   82.39, 82.29
> 1TB+1TB:     70.33+70.32, 69.47+70.01
> 
> Unfortunately that enclosure has only two slots used.  I'll try to not 
> forget bring two more disks tomorrow to get it fully populated.

In case you are still follwing this thread, 3124-2 with 4 1TB drives 
delivers 58.5MBps for each drive with NCQ enabled, and 60MBps with NCQ 
disabled - total 235-240MBps read speed.  I would like to see 320MBps, 
but apparently today is not my lucky day...

>>> 3512 sil, no NCQ:
>>>
>>> 1TB alone: 82.28, 82.18
>>> 1TB+1TB:   47.20+47.54    # Here apparently command based switching or
>>> 1.5Gbps link between device and PMP becomes bottleneck
>>
>> Hmmmm.... Weird.  Is the different still there if you take PMP out of
>> the picture?
> 
> Will do tomorrow.  I need physical access to the box to do that.

Yes, no difference.  3512 is consistently about 1MBps faster than 3132 
when talking to single Hitachi 1TB drive.
							Petr


