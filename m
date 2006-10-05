From: David Chinner <dgc@sgi.com>
Subject: Re: PROBLEM: Hardlock with 2.6.1[678] on Abit AI7, ICH5 + XFS, SATA under heavy I/O load
Date: Thu, 5 Oct 2006 14:31:54 +1000
Message-ID: <20061005043154.GA11811@melbourne.sgi.com>
References: <9a0545880610041828w658d7aaco20348d54e9321d8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:42948 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750792AbWJEEdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2006 00:33:17 -0400
Content-Disposition: inline
In-Reply-To: <9a0545880610041828w658d7aaco20348d54e9321d8f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steve Hindle <mech422@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Oct 04, 2006 at 06:28:35PM -0700, Steve Hindle wrote:
> Hello,
> 
>  My machine is hardlocking with recent kernels (including 2.6.18-mm3)
> under heavy I/O load (for instance, just compiling the kernel is
> enough to lock the machine).  No bug,oops,or panic and nothing in the
> system logs.

Does it happen on any other filesystems? Is this your root filesystem
that is hanging?

> Hasn't seemed to cause any fs corruption (which strikes
> me as odd, since its generally writing files when it hangs..)

Journalling filesystems shouldn't get corrupted by hangs or
crashes...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
