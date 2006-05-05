From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Move various PCI IDs to header file
Date: Fri, 5 May 2006 09:27:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0605050926250.3161@shark.he.net>
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
 <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:8593 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751626AbWEEQ1K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 May 2006 12:27:10 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 5 May 2006 09:27:06 -0700
In-Reply-To: <445AE690.5030700@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jes Sorensen <jes@sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com

On Fri, 5 May 2006, Jes Sorensen wrote:

> Randy.Dunlap wrote:
> > On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:
> >
> >> Move various QLogic, Vitesse, and Intel storage
> >> controller PCI IDs to the main header file.
> >>
> >> Signed-off-by: Brent Casavant <bcasavan@sgi.com>
> >>
> >> ---
> >>
> >> As suggested by Andrew Morton and Jes Sorenson.
> >
> > as compared to:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532
>
> I guess Andrew and I should be blamed for that. I Andrew suggested
> putting the IDs in the 'right place' and I took the right place as being
> the pci_ids.h file.
>
> Can't say I agree with the recommendation, having them in pci_ids.h is
> nice and clean and it allows one to go look through the list, instead
> they now really become random hex values :( Brent's patch is a perfect
> example of IDs being used in multiple places, ie. the qla1280 driver
> and in the IOC4 driver, so the claim in that Documentation/ file doesn't
> hold water.
>
> Anyway, if this is the new rule, then I guess it's back to using the
> ugly patch :(

FWIW, I'm not saying that I agree with the new rule, just that
it's there/merged.

-- 
~Randy
