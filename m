From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Tue, 4 Nov 2008 13:12:26 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811041307030.3419@nehalem.linux-foundation.org>
References: <20081104062734.GA4420@havoc.gtf.org> <alpine.LFD.2.00.0811040823350.3419@nehalem.linux-foundation.org> <20081104203036.GE5862@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754040AbYKDVMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 16:12:38 -0500
In-Reply-To: <20081104203036.GE5862@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On Tue, 4 Nov 2008, Pavel Machek wrote:
>
> (Is park command normally supported on modern disks? IIRC hdaps people
> had issues with not all disks supporting it?)

The modern version of parking is called "idle immediate". It may be that 
only laptop drives support the "unload" part. But it's definitely not an 
ancient and deprecated thing (although calling it "parking" is apparently 
old-fashioned :)

			Linus
