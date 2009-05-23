From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29 kernels
Date: Sat, 23 May 2009 13:52:45 +0200
Message-ID: <200905231352.45740.bzolnier@gmail.com>
References: <bug-13345-11633@http.bugzilla.kernel.org/> <200905212104.n4LL4JwR010833@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:48667 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbZEWLr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 May 2009 07:47:57 -0400
Received: by ey-out-2122.google.com with SMTP id 9so591638eyd.37
        for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 04:47:58 -0700 (PDT)
In-Reply-To: <200905212104.n4LL4JwR010833@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Thursday 21 May 2009 23:04:19 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> 
> 
> 
> --- Comment #11 from Modestas Vainius <modestas@vainius.eu>  2009-05-21 21:04:19 ---
> In both cases? Or I'm just lucky that I have not seen problems with CD/DVD
> drive as hdc yet?

In both cases -- the drive is always tuned to UDMA/66.
