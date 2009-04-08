From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Prepare for hard drives w/ non-512 sector sizes
Date: Wed, 08 Apr 2009 15:08:14 -0400
Message-ID: <49DCF61E.2000703@garzik.org>
References: <20090408065955.GA29845@havoc.gtf.org> <20090408183243.GK20983@parisc-linux.org> <49DCF14F.1060407@garzik.org> <20090408185639.GL20983@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39066 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbZDHTIR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 15:08:17 -0400
In-Reply-To: <20090408185639.GL20983@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Matthew Wilcox wrote:
> On Wed, Apr 08, 2009 at 02:47:43PM -0400, Jeff Garzik wrote:
>> Matthew Wilcox wrote:
>>> On Wed, Apr 08, 2009 at 02:59:55AM -0400, Jeff Garzik wrote:
>>>> I checked this into libata-dev.git#sectsize and #NEXT...  comments
>>>> welcome.  It's willy's patch, cut down such that it introduces no
>>>> major behavior changes [READ CAPACITY improves slightly].
>>> Umm.  If you wanted me to split the patch up, why didn't you ask?
>> I've had trouble until recently simply getting you to post patches at 
>> all.  It was faster and simpler for me to do it myself.
> 
> ?!  Are you referring to the one incident where you asked me if I had
> any patches for 2.6.30, I pointed at the TRIM patches and you quibbled
> that I hadn't reposted the updates, only a git tree?

On multiple occasions.  You're the only one I have to poke to get 
updates on pending libata patches, in some cases, patches that really 
should have gone upstream long ago.


>>> I really do think I should be credited as 'Author' here.  You credit me
>>> in the patch description, but the automated tools don't show that.
>> If that is your preference, that's fine.  I did it this way to avoid 
>> your taking the blame for anything I did, while still noting in the 
>> patch description you did the original work.
> 
> Yes, that's my preference.  It's also the documented way to do things in
> SubmittingPatches.

The patch was changed from your original work, in several places.  That 
makes the issue of From header not so clear cut.  See what I said about 
blame etc. in the original email :)  If there were bugs in my changes, 
you would probably be annoyed to get bug reports about that :)

	Jeff


