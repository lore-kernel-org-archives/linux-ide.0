From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH8 CF timeout (regression)...
Date: Sat, 04 Aug 2007 15:04:54 +0900
Message-ID: <46B41706.4080008@gmail.com>
References: <6278d2220708020348k26ac2293v648442f2281eca70@mail.gmail.com>	 <46B20D6B.1060506@gmail.com>	 <6278d2220708021411q17cdc151p79922e5dab74add4@mail.gmail.com>	 <46B25DE1.4050105@rtr.ca>	 <6278d2220708030322h2c779fa3o1e2e2d9c83ff62e8@mail.gmail.com>	 <46B30651.9030505@gmail.com> <6278d2220708031538s4a57f126ybfa0486816de4401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:11619 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXHDGF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 02:05:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1073260wah
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 23:05:56 -0700 (PDT)
In-Reply-To: <6278d2220708031538s4a57f126ybfa0486816de4401@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Daniel J Blueman wrote:
> Tejun,
> 
> On 03/08/07, Tejun Heo <htejun@gmail.com> wrote:
>> Daniel J Blueman wrote:
>>> The ICH8 south-bridge I have is the mobile variant and does come
>>> equipped with native parallel IDE - see page 447:
>>> http://download.intel.com/design/chipsets/datashts/31305603.pdf . I do
>>> see 35MB/s with DMA enabled from my CF on the 1 in 15 times the
>>> libata-kernel does work.
>>>
>>> I can dump off and decode the configuration registers for the timing
>>> and bus master registers in the working and non-working libata cases,
>>> and the legacy ATA working case and see what's different.
>> Does the attached patch change anything?
> 
> This addresses the issue 100%!
> 
> Due to the differences between the ICH8 non-mobile and mobile
> variants, I've cooked the change into a new initialisation structure
> for the ICH8M in the attached patch, if that helps at all.
> 
> The changes thus affect (correct) behaviour on the ICH8M in IDE mode
> only...so should be safe for inclusion. There may be a similar
> situation with ICH9Ms also.

[cc'ing Kristen, hello]

I think [P0 P2 IDE IDE] is correct for MAP 01b but can't find anything
about it in the datasheet or spec update.  Kristen, can you please
verify this.  The following bug is also fixed by using [P0 P2 IDE IDE].

http://bugzilla.kernel.org/show_bug.cgi?id=8809

Thanks.

-- 
tejun
