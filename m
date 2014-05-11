From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] Add lib/glob.c
Date: Sun, 11 May 2014 08:36:05 -0400
Message-ID: <20140511123605.GB22945@htj.dyndns.org>
References: <20140510031356.22726.qmail@ns.horizon.com>
 <536E61EE.3000705@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:52978 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245AbaEKMgJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 May 2014 08:36:09 -0400
Content-Disposition: inline
In-Reply-To: <536E61EE.3000705@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: George Spelvin <linux@horizon.com>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, torvalds@linux-foundation.org

On Sat, May 10, 2014 at 10:29:18AM -0700, Randy Dunlap wrote:
> > +	  select this option.  Say N unless you are compiling an out-of
> > +	  tree driver which tells you it depend on it.
> 
> 	To support out-of-tree drivers, I'm pretty sure that you will need
> 	to use obj- instead of lib-.  lib- drops unused code, like Tejun said.

I don't think we need to worry about out-of-tree drivers from the
beginning.

Thanks.

-- 
tejun
