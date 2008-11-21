From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: Frequent head unloading
Date: Fri, 21 Nov 2008 13:11:03 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0811211309400.12550@gc.phys.uwm.edu>
References: <4920292B.5060804@gc-web.de> <4920E909.2030400@kernel.org>
 <4920FA98.5050108@gc-web.de> <4920FE45.1040504@kernel.org> <49214331.4020400@gc-web.de>
 <49266B9E.7050402@kernel.org> <4926A4A5.5070204@gc-web.de> <4926D2E7.60108@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gc.phys.uwm.edu ([129.89.61.147]:40264 "EHLO gc.phys.uwm.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbYKUULx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 15:11:53 -0500
In-Reply-To: <4926D2E7.60108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

Yes, this is hard to do in a general way.  The problem is that you have to 
correctly find the head load/unload counts in the SMART data.  This is not 
specified by any standard.  It might be there, it might not be.  I don't 
see a general solution to this.


On Sat, 22 Nov 2008, Tejun Heo wrote:

> Alexander Clausen wrote:
>> Tejun Heo wrote:
>>> So, it's basically a system you assembled, right?
>>
>> Yeah. So the storage-fixup thing only works for ready-made systems,>
>> like laptops or Macs?
>
> Well, it's basically blacklisting systems w/ certain configuration and
> is a very static solution by definition, so can't really be applied to
> random systems.  cc'ing Bruce Allen.  I think we definitely need
> something more dynamic but still don't have much idea how it should be
> done.  :-(
>
> Thanks.
>
>
