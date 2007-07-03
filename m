From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI 3124 bus reset issues
Date: Tue, 03 Jul 2007 15:58:23 +0900
Message-ID: <4689F38F.2000305@gmail.com>
References: <1182294980.7072.31.camel@sally>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:24923 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbXGCG63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:58:29 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1130407nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 23:58:28 -0700 (PDT)
In-Reply-To: <1182294980.7072.31.camel@sally>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Gustafson <jeffgus@zimage.com>
Cc: linux-ide@vger.kernel.org

Jeff Gustafson wrote:
> Hi all,
> 	I found issue similar to the one I am having in the archive on this
> list.  I never found a resolution to the problem in the archive.
> 	I have a 4-port Sil 3124 64-bit PCI-X card in a Dell PowerEdge 750.  It
> is connected to four SATA hard drives in an external drive bay that
> provides power and hotswap rails.
> 	There doesn't seem to be a problem running three drives, but as soon as
> I do something with a forth drive all hell breaks loose.  The problem
> doesn't seem localized to a slot in the drive bay or a particular drive.
> The issue seems to only happen when I try to access a forth drive.
> 	I have also tried the card in another system (in a 32-bit slot) and I
> experience the same problem.

What if you take the fourth drive out of the bay and power it directly
from the computer's PSU?

-- 
tejun
