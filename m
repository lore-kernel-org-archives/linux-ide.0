From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Seagate disk freeze for 30 seconds then comes back (RecovComm 10B8B)
Date: Fri, 30 Jan 2009 16:21:16 -0500
Message-ID: <20090130212115.GB26062@csclub.uwaterloo.ca>
References: <alpine.LFD.2.00.0901271739400.2013@mail.embedromix.ro> <20090128153141.GC26064@csclub.uwaterloo.ca> <498244D4.4060903@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:32826 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754615AbZA3VVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 16:21:17 -0500
Content-Disposition: inline
In-Reply-To: <498244D4.4060903@tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Catalin(ux) M. BOIE" <catab@embedromix.ro>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Jan 29, 2009 at 07:07:48PM -0500, Bill Davidsen wrote:
> Would you expect that firmware would be shared between old tech laptop 
> drives and desktop/server drives? Particularly since the laptop drive was 
> built before any of the 7200.11 drives?
> 
> I think this is a very unlikely part of the problem. Certainly the drive 
> might be dying or other hardware issue.

It does seem unlikely, although if it is a common design flaw in their
firmware, it could have been carried over from older drives and just not
be as noticeable on the older drives with smaller caches and less drive
space.

Now if the drive is really old, then year it might simply be failing.

-- 
Len Sorensen
