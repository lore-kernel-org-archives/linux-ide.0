From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Wed, 23 Jan 2008 13:15:33 +0900
Message-ID: <4796BF65.6040005@gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org> <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com> <478DD615.1050309@garzik.org> <47944A51.2090504@gmail.com> <4796BCEB.1090207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:10417 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbYAWEPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 23:15:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2354992rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 20:15:39 -0800 (PST)
In-Reply-To: <4796BCEB.1090207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> saeed bishara wrote:
>>>> -    if (unlikely(irq_stat & PCI_ERR)) {
>>>> +    if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {
>>>>          mv_pci_error(host, mmio);
>>>>          handled = 1;
>>>>          goto out_unlock;    /* skip all other HC irq handling */
>>> the unlikely() should cover the entire expression.
>>
>> Hmm... I also sometimes hesitate about these things.  I think when the
>> first condition is unlikely but the latter isn't so, it's better to tell
>> the compiler that the first part is unlikely and let it figure out the
>> rest.  Another thing is using unlikely on the return value of helper
>> function like the following.
>>
>> static bool test_some_condition(arg)
>> {
>>     return unlikely(unlikely_test_on_arg(arg));
>> }
>>
>> I haven't looked at the generated code yet but hope the compiler can
>> DTRT if the function body is visible when compiling.  Has anyone played
>> with these?
> 
> Think about the question being answered -- this is branch prediction.
> After all tests in an 'if' are complete, the question is:  do we take
> this branch or not?  (yes/no)

Well, if (a && b) is not a single branch.  It's two (or more) branches.
 Let's say a is unlikely but b is; then with unlikely(a && b), the
compiler do something like the following.

	jmp L0 if !a
	jmp L0 if !b
	jmp L1
.L0	continue excution after if block

---------
cold unlikely block
.L1	body of if

Or some other form.  With (unlikely(a) && b), the compiler knows the
optimal form is...

	jmp L1 if a
.L0	continue excution after if block

---------
cold unlikely block
.L1	jmp L0 if !b
	body of if

> And while it is valid to note unlikely() as done above, it doesn't
> necessarily give the compiler the best idea about how to predict the
> ultimate end result of all the tests, which is the decision on whether
> or not to take the branch.

It actually gives the compiler better information to optimize with and
test conditions in if() can get quite involved and it also gives better
idea of what the writer was thinking when writing the likely/unlikely
when the code is read later.

-- 
tejun
