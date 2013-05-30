From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Thu, 30 May 2013 15:58:50 +0900
Message-ID: <20130530065850.GA22604@mtj.dyndns.org>
References: <1369842679-9680-1-git-send-email-mark.langsdorf@calxeda.com>
 <CAOZdJXUHb1Kbu=LoqUgKA3_EMjPU3Q1KrZ-pENb-0Siym8_Pvw@mail.gmail.com>
 <51A66690.6060109@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46950 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967623Ab3E3G67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 02:58:59 -0400
Content-Disposition: inline
In-Reply-To: <51A66690.6060109@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Timur Tabi <timur@tabi.org>, lkml <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, May 29, 2013 at 03:35:28PM -0500, Mark Langsdorf wrote:
> On 05/29/2013 03:12 PM, Timur Tabi wrote:
> > On Wed, May 29, 2013 at 10:51 AM, Mark Langsdorf
> > <mark.langsdorf@calxeda.com> wrote:
> >>
> >>  {
> >> -       const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> >> +       unsigned long timing[] = { 5, 100, 500};
> > 
> > 
> > You didn't address my comments the last time you posted this.  I'll
> > post them again:
> > 
> > 
> > Why are you dropping the 'const'?
> > 
> > Assuming it works, this should be more efficient:
> > 
> > static const unsigned long timing[] = {5, 100, 500};
> 
> I thought there was a compile issue, but I just rechecked and there
> wasn't. I'll fix for the next submission.

Also, please add a comment explaining why those parameters are
necessary and how they're determined - ie. the bulk of the commit
message; otherwise, it looks pretty random.

Thanks.

-- 
tejun
