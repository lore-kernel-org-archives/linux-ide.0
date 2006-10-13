From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: How to test SATA NCQ feature
Date: Thu, 12 Oct 2006 18:42:12 -0600
Message-ID: <311601c90610121742v60721c3eocc8fc74e43ae1794@mail.gmail.com>
References: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
	 <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com>
	 <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:19259 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWJMAmO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 20:42:14 -0400
Received: by nf-out-0910.google.com with SMTP id x30so755452nfb
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 17:42:12 -0700 (PDT)
In-Reply-To: <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On 10/12/06, Fajun Chen <fajunchen@gmail.com> wrote:
> Hi Eric,
>
> Thanks for your detailed explanation.
>
> In terms of ops/sec, I currently implemented it as the amout of data
> transferred per seconds.  Please let me know if I need to implement it
> differently.

Ops/sec and blocks/s can easily be translated.  Doesn't really matter
which metric you use.

> I also have a question about NCQ error handling. Among all the
> outstanding commands, if one command fails,  what will happen to the
> rest of the commands?

Per the specification, upon any error, all commands internal to the
device are aborted.  Now, there's optimizations to this behavior
(drives may have internally queued command completions that they can
let finish before they report the error) but they don't affect the
host in any meaningful way.

>                                     I understand that all the commands in the device
> will be aborted by LOG PAGE 10h command, but how about the commands
> enqueued but haven't been sent to the device?  In my particular
> application, one thread is blocked for every outstanding command. So
> depending on how libata handles outstanding commands,  it will have
> significant implication to my user space application.

If queued in hardware but not yet issued to the device, I am not sure
how those would be handled... probably up to each vendor's hardware
specification.  Don't really know beyond that as I haven't written an
HBA driver before.  My work has all been on the device side.

--eric
