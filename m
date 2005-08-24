From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: libata passthru  (S.M.A.R.T.) support for 2.4.31?
Date: Wed, 24 Aug 2005 12:02:03 -0400
Message-ID: <20050824160201.GB1100@tuxdriver.com>
References: <430B1E7A.30406@permabit.com> <20050823132235.GA21267@tuxdriver.com> <430B7EC9.3050802@permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:35341 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751089AbVHXQCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2005 12:02:20 -0400
Content-Disposition: inline
In-Reply-To: <430B7EC9.3050802@permabit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Fortson <mfortson@permabit.com>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 23, 2005 at 03:53:45PM -0400, Michael Fortson wrote:
> John W. Linville wrote:

> >Have you tried applying that passthru patch to the 2.4.31 sources?

> I attempted to use 
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.13-rc6-git10-libata1.patch.bz2 
> against 2.4.31 but several portions of the patch were rejected and one file 
> (drivers/scsi/Kconfig) doesn't exist at all.

Hmmm...that patch seems to cover all the pending libata development
stuff, not just passthru/SMART.  I thought Jeff had a separate patch
available for that at one time, but I don't see it ATM...

You probably can tease such a patch out of git...will have to
investigate...

John
-- 
John W. Linville
linville@tuxdriver.com
