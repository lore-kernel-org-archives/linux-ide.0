From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH] ata: increase retry count but shorten duration for Calxeda
 controller
Date: Wed, 29 May 2013 15:35:28 -0500
Message-ID: <51A66690.6060109@calxeda.com>
References: <1369842679-9680-1-git-send-email-mark.langsdorf@calxeda.com> <CAOZdJXUHb1Kbu=LoqUgKA3_EMjPU3Q1KrZ-pENb-0Siym8_Pvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp65.ord1c.emailsrvr.com ([108.166.43.65]:44612 "EHLO
	smtp65.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966083Ab3E2Uf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 May 2013 16:35:29 -0400
In-Reply-To: <CAOZdJXUHb1Kbu=LoqUgKA3_EMjPU3Q1KrZ-pENb-0Siym8_Pvw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 05/29/2013 03:12 PM, Timur Tabi wrote:
> On Wed, May 29, 2013 at 10:51 AM, Mark Langsdorf
> <mark.langsdorf@calxeda.com> wrote:
>>
>>  {
>> -       const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>> +       unsigned long timing[] = { 5, 100, 500};
> 
> 
> You didn't address my comments the last time you posted this.  I'll
> post them again:
> 
> 
> Why are you dropping the 'const'?
> 
> Assuming it works, this should be more efficient:
> 
> static const unsigned long timing[] = {5, 100, 500};

I thought there was a compile issue, but I just rechecked and there
wasn't. I'll fix for the next submission.

Thanks for the review.

--Mark Langsdorf

