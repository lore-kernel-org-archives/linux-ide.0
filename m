From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Sat, 27 May 2006 16:56:56 -0400
Message-ID: <4478BD18.6010908@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527205213.GA30686@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3743 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964931AbWE0U4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:56:55 -0400
In-Reply-To: <20060527205213.GA30686@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org

I tried merging Linus's one-liner in front of alt4_v2,
and the screen came back right away (instead of stalling 30seconds),
and then the alt4_v2 code killed the interface as before.  :)

Jeff Garzik wrote:
> Here's alt4 v3.  Having the host_stat == 0x1 was suspicious.
> After digging through the hardware manual, it might be a good idea to
> configure BMDMA registers properly, in case that was done by BIOS but
> not by D3->D0 silicon reset values.

I'll try that.  But does it make sense that Linus's one-liner
would also work, if this was really the problem?  (dunno, just asking)

> One core problem with all of libata suspend/resume is that
> * we boot from a configuration set up by BIOS
> * but going D3->D0, we simply get silicon defaults
> 
> Randy Dunlap's ACPI patches will probably help a bit.

The ACPI patches have indeed been working here for over a year now,
on all kernels up to 2.6.15 --> not needed for 2.6.16.

Cheers
