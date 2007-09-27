From: Tejun Heo <htejun@gmail.com>
Subject: Re: Maxtor 6L200M0 sata irq timeouts
Date: Thu, 27 Sep 2007 16:08:31 +0900
Message-ID: <46FB56EF.8050703@gmail.com>
References: <a5d587fb0709090234x1942e987u4187bf0dbe977a06@mail.gmail.com>	 <6b9952490709090740t188d5b71x26b90421bfe948bf@mail.gmail.com>	 <a5d587fb0709090920y1241a528x4f5a1141026256a7@mail.gmail.com>	 <46E473D2.20907@gmail.com>	 <a5d587fb0709100711s16a6df24i8fac5693c5cc8952@mail.gmail.com>	 <46E5F15A.2090803@gmail.com> <a5d587fb0709110429j6ce52fb2wb1d558281b36f8a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:24210 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758922AbXI0SQx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 14:16:53 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2379119rvb
        for <linux-ide@vger.kernel.org>; Thu, 27 Sep 2007 11:16:53 -0700 (PDT)
In-Reply-To: <a5d587fb0709110429j6ce52fb2wb1d558281b36f8a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Joris <joris@v5.be>, linux-ide@vger.kernel.org

Michal Suchanek wrote:
> Hello
> 
> (please CC me when replying)
> 
> On 11/09/2007, Tejun Heo <htejun@gmail.com> wrote:
>> Michal Suchanek wrote:
>>>> What does 'smartctl -a /dev/sda' say?
>>>>
>>> Attaching output.
>> Hmmm... How often does the condition occur?  smartlog records only two
>> occasions.
>>
> 
> Every few minutes when the system is under load, less often when not.
> 
> I think the logged drive errors are unrelated, the drive delivers the
> interrupt, just a bit later than Linux expects. At least that is my
> impression after looking at the these logs and the logs from the old
> system (I am not sure I could still find the saved logs but with some
> combination of irq related kernel options I got spurious interrupt
> instead of timeout, and the drive got disabled).

Can you please test the latest rc kernel and see whether this problem is
still there?

Thanks.

-- 
tejun

