From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Wed, 12 Oct 2011 10:03:11 -0400
Message-ID: <4E959E1F.20001@teksavvy.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com> <1317881037-11831-1-git-send-email-gwendal@google.com> <20111006080314.GB373@dhcp-172-17-108-109.mtv.corp.google.com> <CAMHSBOXhmhaRQgA104U+yajDLwyjVAeMqYUvUZFvZNroL0urug@mail.gmail.com> <20111006221026.GA7085@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:9138 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750936Ab1JLOMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 10:12:38 -0400
In-Reply-To: <20111006221026.GA7085@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gwendal Grignou <gwendal@google.com>, mihrcke@gmail.com, linux-ide@vger.kernel.org, derry@high-rely.com

On 11-10-06 06:10 PM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Oct 06, 2011 at 01:44:27PM -0700, Gwendal Grignou wrote:
>> Yes. Until the device sends the async D2H Reg FIS indicating the drive
>> spun up, the MPM does not accept the SoftRest FIS from the controller.
>> On most controller, that fine, the controller state machine keeps
>> retrying, but on Sil3132 it stops after a second or so and send an
>> error back to the driver.
> 
> I see.
> 
>>> So, now libata waits for full reset period before proceeding to reset
>>> PMP.  Hmmm... yeah, it makes sense.  Unfortunately, the only way to
>>> achieve spinup wait in this case is waiting blindly and libata's reset
>>> timeouts are configured to accomodate drive spinup times.  PMP SCR
>>> failure kinda destroys those blind wait periods.
>>
>> Yes, I totally agree this blind wait is not clean. Normally we would
>> wait until an event occurs [async FIS] and have the timeout just for
>> the error case.
>> Here we wait [10s] because we think the device is spinning up.
> 
> Yes but that's exactly how the reset timeouts are set up.  They're
> supposed to provide reasonable spinup timeouts when the proper wait
> mechanisms can't do so and here it becomes a problem because the blind
> timeouts are circumvented by SCR read failure handling.
> 
>>> I'm not too sure about ATA_LFLAG_WAIT_SRST.  I don't think making the
>>> new behavior default would hurt.
>>
>> I see your point. But if there is no PMP, Sil3132 is behaving, there
>> is no need of this logic.
> 
> Yes, sure, the behavior is necessary iff PMP is attached as that's
> only time SCR read failure can occur anyway and I think it would
> generally be a good idea to always enforce the blind timeouts if PMP
> is attached, so no need for ATA_LFLAG_WAIT_SRST.

I wonder if this same logic is more generally applicable for PMP
rather than sil3132 specific?  What I've read thus far in this thread
sounds very much like the issues I see here with PMPs not working
on JMB and Marvell controllers (where they USED to work fine).

Gwendal, have you got a version of that patch which applies the same
change globally rather than only for sil3132?  I'd like to try it out here.

Thanks
