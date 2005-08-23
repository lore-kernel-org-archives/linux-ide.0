From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: libata passthru  (S.M.A.R.T.) support for 2.4.31?
Date: Tue, 23 Aug 2005 09:22:37 -0400
Message-ID: <20050823132235.GA21267@tuxdriver.com>
References: <430B1E7A.30406@permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:64519 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932151AbVHWNXC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2005 09:23:02 -0400
Content-Disposition: inline
In-Reply-To: <430B1E7A.30406@permabit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Fortson <mfortson@permabit.com>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 23, 2005 at 09:02:50AM -0400, Michael Fortson wrote:
> Apologies if this is the wrong list for this question.
> 
> Is there a patch which provides libata passthru support for the 2.4.31 
> kernel?  I've seen that Jeff Garzik has a patch for 2.6.x which provides 
> S.M.A.R.T. support for SATA disks using the libata passthru stuff and 
> I'd like to apply a similar patch to 2.4.31, if one exists.

Have you tried applying that passthru patch to the 2.4.31 sources?
I do not know if that will work or not, but in the past the 2.4 libata
code was very close to the 2.6 libata code.  So, it might just apply
directly...?

Give it a try.  If it doesn't work-out, I'll be happy to try to
assist you.

John
-- 
John W. Linville
linville@tuxdriver.com
