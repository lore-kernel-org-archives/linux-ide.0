From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linux-next: first tree
Date: Thu, 14 Feb 2008 16:03:19 -0500
Message-ID: <47B4AC97.3040001@garzik.org>
References: <20080215003537.8911ce35.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60167 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695AbYBNVD1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 16:03:27 -0500
In-Reply-To: <20080215003537.8911ce35.sfr@canb.auug.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Stephen Rothwell wrote:
> Also, more trees please ...  :-) 

Please add the 'NEXT' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to your list.  This is a throwaway meta-branch that is rebased often.

The 'master' branch of libata-dev.git always contains the base commit 
from torvalds/linux-2.6.git from which all other branches are based.  I 
never ever commit to the 'master' branch, only update it from 
torvalds/linux-2.6.git.


Andrew,

I will continue to maintain the 'ALL' branch exactly as before.  It may 
contain changes not suitable for 'NEXT', but suitable for -mm testing.

In my new development process, things will almost always land in 'ALL' 
before 'NEXT'.

	Jeff



