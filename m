From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with
 the 2.6.26.5 kernel
Date: Wed, 01 Oct 2008 12:04:01 +0900
Message-ID: <48E2E8A1.8090204@gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com> <20080930170849.52c00228.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:18984 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYJADFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Sep 2008 23:05:40 -0400
Received: by ti-out-0910.google.com with SMTP id b6so104197tic.23
        for <linux-ide@vger.kernel.org>; Tue, 30 Sep 2008 20:05:37 -0700 (PDT)
In-Reply-To: <20080930170849.52c00228.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: gettinther <gettinther@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> (cc linux-ide)
> 
> On Tue, 30 Sep 2008 00:01:34 +0100 gettinther <gettinther@gmail.com> wrote:
> 
>> Hi,
>>
>> I'm currently trying to get the 2.6.26.5 kernel to work but cannot get
>> the sata dvdrom to be recognized by the MCP55.  The controller works
>> with the 2.6.24.4 and 2.6.25.17 kernels.  I had to use
>> CONFIG_ACPI_DOCK=y for the 2.6.25.17 but this did not work with the
>> 2.6.26.5.  The problem has been confirmed on at least 2 machines.
> 
> It's a regression.
> 
>> I have tried various boot options (pci=nomsi, acpi=off and any other
>> relevant code I could find) but nothing seems to work.  The odd thing
>> is the sata dvdrom was recognized twice by the 2.6.26.5 kernel (2
>> different kernel tests) for no apparent reason (could not get it to
>> work afterward).
>>
>> Here's the cut info for each kernel from /var/log/messages (2.6.25.17,
>> 2.6.26.5 working, 2.6.26.5 not working).  If you require further
>> information I can submit it. I don't want to put too much on the first
>> message.

Does irqpoll help?

-- 
tejun
