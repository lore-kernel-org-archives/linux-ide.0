From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Mon, 21 Jan 2008 16:31:29 +0900
Message-ID: <47944A51.2090504@gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org> <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com> <478DD615.1050309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:62752 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037AbYAUHbh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 02:31:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1695950rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2008 23:31:35 -0800 (PST)
In-Reply-To: <478DD615.1050309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

Jeff Garzik wrote:
> saeed bishara wrote:
>> -    if (unlikely(irq_stat & PCI_ERR)) {
>> +    if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {
>>          mv_pci_error(host, mmio);
>>          handled = 1;
>>          goto out_unlock;    /* skip all other HC irq handling */
> 
> the unlikely() should cover the entire expression.

Hmm... I also sometimes hesitate about these things.  I think when the
first condition is unlikely but the latter isn't so, it's better to tell
the compiler that the first part is unlikely and let it figure out the
rest.  Another thing is using unlikely on the return value of helper
function like the following.

static bool test_some_condition(arg)
{
	return unlikely(unlikely_test_on_arg(arg));
}

I haven't looked at the generated code yet but hope the compiler can
DTRT if the function body is visible when compiling.  Has anyone played
with these?

Thanks.

-- 
tejun
