From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Mon, 10 Mar 2008 09:50:52 +0900
Message-ID: <47D485EC.1060103@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange> <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:47921 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYCJAu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 20:50:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1610397wff.4
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 17:50:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803092221560.7385@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Sun, 9 Mar 2008, Tejun Heo wrote:
> 
>> Guennadi Liakhovetski wrote:
>>> On Fri, 7 Mar 2008, Tejun Heo wrote:
>>>
>>>>> Looks like almost a minute to me? On another occurence I see about 1.5 
>>>>> minutes, then "port is slow to respond, please be patient (Status 0x80)" 
>>>>> has been repeated 3 times. On cold-plug also 3 times, I think, about the 
>>>>> same time then (time is not updated in the log).
>>>> I see.  Does the attached patch make any difference?
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 4fbcce7..abebdcc 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -6712,6 +6712,7 @@ int sata_link_init_spd(struct ata_link *link)
>>>  	spd = (scontrol >> 4) & 0xf;
>>>  	if (spd)
>>>  		link->hw_sata_spd_limit &= (1 << spd) - 1;
>>> +	link->hw_sata_spd_limit = 1;
>>>  
>>>  	ata_force_spd_limit(link);
>>>  
>>> Hm, this would force 1.5Gbps on all ports and devices, right? Cannot I 
>>> just boot with "libata.force=4:1.5Gbps"?
>> Yeap, you can do that.  Wasn't sure you were using .25-rc or .24.
> 
> Yctually it was 2.6.24 before, rebuilt 2.6.25-rc4, booted as above, it did 
> say:
> 
> ata4: FORCE: PHY spd limit set to 1.5Gbps
> 
> but hot-plugging the drive still took 50 seconds to recover.

How about cold plugging?

-- 
tejun
