From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Tue, 11 Mar 2008 20:37:50 +0900
Message-ID: <47D66F0E.9020703@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange> <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange> <47D485EC.1060103@gmail.com> <Pine.LNX.4.64.0803100821440.3948@axis700.grange> <47D53231.30107@gmail.com> <Pine.LNX.4.64.0803111058090.5503@axis700.grange> <47D66071.7010906@gmail.com> <Pine.LNX.4.64.0803111210010.5775@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:53104 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbYCKLh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 07:37:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2455998wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 04:37:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803111210010.5775@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Guennadi Liakhovetski wrote:
>> Guennadi Liakhovetski wrote:
>>> Well, I am not sure, whether it helps, tried booting with both 1.5Gbps and 
>>> this patch, it recovers now within 30 sec in both cold- and hot-plug 
>>> cases. To really state, that it has improved from about 55 sec down to 30 
>>> sec one would need more testing. Is this the kind of improvement you 
>>> expected?
>> Not really.  :-P
>>
>>> Can it be, that with this hardware it just cannot get better? 
>>> Remember, the disk is an external eSATA enclosure with a (relatively new) 
>>> PATA disk inside.
>> Can you try out a shorter cable?  I had a lot of troubles with eSATA +
>> long cable + PMP combinations.  Using shorter cable usually solves the
>> problem for me.
> 
> Well, this cable is only about 50cm long, or even shorter, and using a 
> shorter one would be difficult there, even if I manage to get hold of one. 
> But, in principle, if this is not a generic ahci problem that needs to be 
> solved, I personally can somehow live with it. Having to wait 1 minute is 
> not very nice, but so far not critical.

50cm gotta be short enough.  For intel ahci, it definitely isn't a
general problem but it would still be nice if we can find out what's
going on but I don't have much idea what to do next.  I'll keep your
problem in mind and see whether any pattern emerges.  If you find out
something new, please let us know.

Thanks.

-- 
tejun
