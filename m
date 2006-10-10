From: Elias Oltmanns <oltmanns@uni-bonn.de>
Subject: Re: Debugging strange system lockups possibly triggered by ATA commands
Date: Tue, 10 Oct 2006 20:58:30 +0200
Message-ID: <87ejtgatgp.fsf@denkblock.local>
References: <741Eo-2m9-5@gated-at.bofh.it> <742hc-4n3-25@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.uni-bonn.de ([131.220.15.112]:32149 "EHLO uni-bonn.de")
	by vger.kernel.org with ESMTP id S1751092AbWJJS7s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Oct 2006 14:59:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, hdaps-devel@sourceforge.net

Hi Shem,

"Shem Multinymous" <multinymous@gmail.com> wrote:
> Hi Elias,
>
> On 10/9/06, Elias Oltmanns <oltmanns@uni-bonn.de> wrote:
>
>> A slightly stripped version of the patch is available too, which has
>> been verified to trigger the described problem in exactly the same way
>> as the original but lacks the IDLE IMMEDIATE feature (leaving the
>> STANDBY IMMEDIATE option only) in order to make it (hopefully) more
>> readable and easier to understand.
>
> What happens if you strip away *all* the head parking code, leaving
> only the queue freeze code? Conversely, what happens if you issue the
> head park command but don't freeze the queue?

In all setups the loop
# while true; do hdparm -q -y /dev/hda; hdparm -q -C /dev/hda; done
didn't trigger the freeze. This should be very close to the effect of
the patch with all queue freezing stuff removed.

Regarding your question, it seems rather difficult to test the right
thing. Just issuing the commands and leaving the queue alone is easy
to implement and I couldn't reproduce the problem running such a
kernel. Testing the queue handling stuff without actually issuing any
commands seems rather difficult to me as its the callback mechanism
used to freeze the queue after command completion which I'd really
like to test. If I don't issue any command, I don't know how to test
whether the callback procedure and all the rest works as expected.

Regards,

Elias
