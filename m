From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] ide/amd74xx: fix section references
Date: Fri, 04 Mar 2005 07:33:20 -0800
Message-ID: <42287FC0.6060204@osdl.org>
References: <20050303194821.55fec933.rddunlap@osdl.org>	 <20050304080307.GC1646@ucw.cz> <58cb370e05030402122a9290b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from fire.osdl.org ([65.172.181.4]:21923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbVCDPcl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 10:32:41 -0500
In-Reply-To: <58cb370e05030402122a9290b6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Fri, 4 Mar 2005 09:03:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
>>On Thu, Mar 03, 2005 at 07:48:21PM -0800, Randy.Dunlap wrote:
>>
>>>ide/pci/amd74xx:  data structs point to __init text which should be
>>>  __devinit;
>>>unless (a) these are going away real soon,
>>>or (b) this just can't happen, isn't a real problem,
>>>or (c) other ?
>>
>>This is a problem in most of the IDE PCI drivers. It is a problem if IDE
>>hotplug is to be expected, and shouldn't be causing any immediate harm
>>if IDE controllers can't be hotplugged. AMD74xx certainly can't.

Yes, I have a list of other offenders, I just wanted to get
comments first.

>>However, I believe it's correct to fix that.
> 
> 
> Some time ago hch made a patch fixing all IDE PCI drivers.
> It was queued to be merged after hotplug support is added
> but may be merged earlier if needed (to kill sparse warnings?).

So I don't need to fix the remaining offenders, right?

-- 
~Randy
