From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 22 Jan 2008 23:04:59 -0500
Message-ID: <4796BCEB.1090207@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org> <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com> <478DD615.1050309@garzik.org> <47944A51.2090504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45193 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbYAWEFC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 23:05:02 -0500
In-Reply-To: <47944A51.2090504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> saeed bishara wrote:
>>> -    if (unlikely(irq_stat & PCI_ERR)) {
>>> +    if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {
>>>          mv_pci_error(host, mmio);
>>>          handled = 1;
>>>          goto out_unlock;    /* skip all other HC irq handling */
>> the unlikely() should cover the entire expression.
> 
> Hmm... I also sometimes hesitate about these things.  I think when the
> first condition is unlikely but the latter isn't so, it's better to tell
> the compiler that the first part is unlikely and let it figure out the
> rest.  Another thing is using unlikely on the return value of helper
> function like the following.
> 
> static bool test_some_condition(arg)
> {
> 	return unlikely(unlikely_test_on_arg(arg));
> }
> 
> I haven't looked at the generated code yet but hope the compiler can
> DTRT if the function body is visible when compiling.  Has anyone played
> with these?

Think about the question being answered -- this is branch prediction. 
After all tests in an 'if' are complete, the question is:  do we take 
this branch or not?  (yes/no)

And while it is valid to note unlikely() as done above, it doesn't 
necessarily give the compiler the best idea about how to predict the 
ultimate end result of all the tests, which is the decision on whether 
or not to take the branch.

	Jeff




