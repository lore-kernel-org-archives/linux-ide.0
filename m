From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode) (resend:
 v0.22)
Date: Wed, 05 Oct 2005 13:10:45 -0400
Message-ID: <43440915.7060405@emc.com>
References: <20050930053600.F3B821CDD0@lns1058.lss.emc.com> <4341E420.6070808@pobox.com> <Pine.GSO.4.63.0510051912230.10241@ra.sai.msu.su> <434407A2.6010605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030270AbVJERMJ@vger.kernel.org>
In-Reply-To: <434407A2.6010605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Evgeny Rodichev <er@sai.msu.su>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Evgeny Rodichev wrote:
> 
>> On Mon, 3 Oct 2005, Jeff Garzik wrote:
>>
>>> applied
>>>
>>
>> This patch leads to freeze with Marvell MV88SX6041 4-port SATA II 
>> PCI-X Controller (rev 03), as I wrote already
>> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0510.0/0203.html)
>>
>> It is impossible to reboot the system without  harware reset (after 
>> modprobe).
> 
> 
> I'm betting a temporary workaround should be to disable CONFIG_SMP.
> 
> The first attached patch (patch.1) fixes one of the lockups.  The second 
> attached patch (patch.2) should fix all the lockups, but that's just a 
> guess, and it's a very ugly patch.
> 
> Note that patch.2 depends on patch.1.


I'm testing a more extensive patch that should address these issues.  I 
had sent something similar to the patches above to several users and it 
fixed the lockup and brought 60xx to a working condition.

BR

PS...please CC the linux-ide mailing list in the future with these 
problem reports, I am not subscribed to lkml.
