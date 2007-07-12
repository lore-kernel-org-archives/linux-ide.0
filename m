From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT][PATCH v7] sata_mv: convert to new EH
Date: Thu, 12 Jul 2007 15:04:28 -0400
Message-ID: <46967B3C.708@garzik.org>
References: <20070711200538.GA7374@havoc.gtf.org> <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org> <46960225.5000502@garzik.org> <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54986 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbXGLTEc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 15:04:32 -0400
In-Reply-To: <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dean gaudet <dean@arctic.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dave@thedillows.org

dean gaudet wrote:
> On Thu, 12 Jul 2007, Jeff Garzik wrote:
> 
>> dean gaudet wrote:
>>> oh very nice... no warnings on boot, and no warnings while i "dd if=/dev/sdX
>>> of=/dev/null" and i'm seeing 74MB/s+ from each disk on this simple read
>>> test.
>>>
>>> for lack of a better test i started an untar/diff stress test on the
>>> disks... we'll see how it goes.  (it's based on doug ledford's memtest.sh)
>> Thanks for the testing.  Looks like we might have hit on something good...
> 
> yep this does look good.  no problems overnight in the untar/diff/rm 
> workload.  if you've got any other workload you'd like me to throw at it, 
> let me know.  i might be able to scare up a disk or two with errors to 
> check error handling.

Nothing specific.  I usually just throw various workloads at it, both 
throughput-intensive, seek-intensive, multiple threads at the same time, 
stressing multiple disks at the same time, etc.

I presume from your past messages your tests include multiple disks at 
the same time?


> i tested hotplug just for kicks... no luck there :)  but then you didn't 
> say that would work yet.

hehehe Well I sorta didn't want to mention it, to avoid clouding the 
waters further.

In theory, hotplug and hot unplug -should- work, in version 7.  Your 
report is a useful contradiction of that theory, and signals where to 
poke next.  Since all this hacking is a spare-time effort, so promises 
as to when next I'll poke at it.   It might be tomorrow, or a month from 
now.  Getting "new EH" upstream was a big hurdle to overcome, and your 
testing really helped that along.

Anyway, something like Version 7 is probably what I will push upstream 
for 2.6.23-rc1.

	Jeff


