From: Jeff Garzik <jeff@garzik.org>
Subject: Re: regarding ACPI support in 2.6.21
Date: Mon, 12 Mar 2007 11:03:49 -0400
Message-ID: <45F56BD5.6040408@garzik.org>
References: <45F5648C.7020506@gmail.com> <20070312154649.5f661a39@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51046 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030342AbXCLPDw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 11:03:52 -0400
In-Reply-To: <20070312154649.5f661a39@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org

Alan Cox wrote:
>> I think it might be better to give up ACPI support in 2.6.21 and target
>> 2.6.22.  What do you think?
> 
> I removed it from my tree already so that I can actually use libata and
> do real work. The "crash every non PCI controller" feature in the current
> ACPI hacks means PCMCIA and ISAPnP do not work any more with libata.

It sounds like your tree is out-of-date.  Your patch to fix that went in 
days ago, applied by Linus directly:

commit ca4266359d0c1199af088447f209ab5bcc32a989
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Thu Mar 8 23:13:50 2007 +0000

      [PATCH] libata-acpi: Try and stop all the non PCI devices crashing


> In its current state it should be disabled, its broken, its wrong.

Does the above change your opinion any?

I lean towards disabling it by default in 2.6.21 anyway, but am 
interested in hearing an updated opinion on what's actually in the 
public tree.

	Jeff


