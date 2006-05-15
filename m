From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 11:27:38 -0700
Message-ID: <20060515112738.5df30c19.akpm@osdl.org>
References: <20060515170006.GA29555@havoc.gtf.org>
	<20060515101831.0e38d131.akpm@osdl.org>
	<4468C530.6080409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:10881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964892AbWEOSZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 14:25:31 -0400
In-Reply-To: <4468C530.6080409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> Andrew Morton wrote:
> > I'd be a little concerned with that merge plan at this time - we have a lot
> > of sata bug reports banked up and afaict a pretty low fixup rate.  Then
> > again, these patches might fix some of those bugs...
> > 
> > I guess if we can get it all in early (which is only a couple of weeks
> > away!) and you and Tejun will have time set aside to work on problems then
> > OK.  But....
> 
> 
> As you can see from the list just sent, the improved error handling will 
> give libata much greater ability to diagnose "controller is being weird" 
> type situations, which is a lot of what the relevant bug reports need.
> 
> After reviewing those bug reports, I see a couple oopses -- caused by 
> BUG()-style code, and fixed in this update -- and one data corruption 
> which persists on Sil 311x on rare motherboards.  The rest are either 
> addressed with the improved error handling, or are ATAPI + VIA AFAICS.
> 

ok, thanks.

Next -mm I'll suck up the libata changes, drop a pile of the hairier stuff
and I'll ask each originator to test that patchset.
