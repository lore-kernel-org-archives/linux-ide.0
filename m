From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Wed, 07 Feb 2007 14:51:27 -0500
Message-ID: <45CA2DBF.9040403@pobox.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com> <20070207193513.GA1929@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rune.pobox.com ([208.210.124.79]:49796 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422742AbXBGTvh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 14:51:37 -0500
In-Reply-To: <20070207193513.GA1929@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Art Haas wrote:
> On Wed, Feb 07, 2007 at 11:53:17AM +0900, Tejun Heo wrote:
>> Art Haas wrote:
>>>>> Also, zero out the features register before issuing PACKET_IDENTIFY,
>>>>> if the code isn't already doing that.
>>>> Okay.
>>>SUCCESS!!!!!
>> Yay!
...
>> So, it succeeded without any DRQ wait.  Can you please apply only the 
>> attached patch over vanilla 2.6.20 and see if your problem is fixed?
>>
>> This problem has been around for quite a while now and there probably 
>> have been other users hit by this out there.  Thanks a lot, Mark.
> 
> SUCCESS (again)!!!!!

Good stuff, guys.
I'm happy to have been of service.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
