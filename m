From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linux-next: first tree
Date: Thu, 14 Feb 2008 16:05:08 -0500
Message-ID: <47B4AD04.4000707@garzik.org>
References: <20080215003537.8911ce35.sfr@canb.auug.org.au> <47B4AC97.3040001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60180 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825AbYBNVFN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 16:05:13 -0500
In-Reply-To: <47B4AC97.3040001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Please add the 'NEXT' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> to your list.  This is a throwaway meta-branch that is rebased often.

Additional FYI:

Don't be worried if "git diff master..NEXT" is empty from time to time.

This condition occurs whenever the 'NEXT' queue is empty.

	Jeff



