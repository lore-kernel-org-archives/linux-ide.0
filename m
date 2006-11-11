From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS P5B and AHCI with 4 SATA drives (reminder)
Date: Sat, 11 Nov 2006 11:45:09 +0900
Message-ID: <45553935.7020508@gmail.com>
References: <20061111002016.GA3742@mail.majes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:35056 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946974AbWKKCpY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 21:45:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1523840nfa
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 18:45:22 -0800 (PST)
In-Reply-To: <20061111002016.GA3742@mail.majes.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathias Jeschke <jeschke@informatik.hu-berlin.de>
Cc: linux-ide@vger.kernel.org

Mathias Jeschke wrote:
> Hallo kernel hackers,
> 
> as I mentioned in my last mail from 2006-08-31 [1],
> the AHCI driver (ahci.c) from the default linux kernel tree
> does not support all 4 ports of my ASUS P5B mainboard.
> (only 2 of 4 hard discs)
> 
> I ask you, what is wrong with my patch I attached at the mail
> to Jeff and this mailing-list?
> I know that introducing a new kernel commandline argument is no smart
> way to solve it, but better than no solution, yet. Isn't it?
> 
> Has anybody more details about that problem of detecting the right
> number of physical ports and their mapping?
> 
> Regards,
> Mathias
> 
> [1] http://marc.theaimsgroup.com/?l=linux-ide&m=115705276301404&w=2

Hello, Mathias Jeschke.

The following fix is pending merge.

http://thread.gmane.org/gmane.linux.ide/13844/focus=13844

-- 
tejun
