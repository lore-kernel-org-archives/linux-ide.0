From: Moritz Heiber <moe@lunar-linux.org>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 7 May 2006 16:52:40 +0200
Message-ID: <20060507165240.2c949d17.moe@lunar-linux.org>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
	<445D6298.7090003@gmail.com>
	<20060507140443.7ae89a68.moe@lunar-linux.org>
	<445DE5D1.3010203@gmail.com>
	<20060507151021.2986c766.moe@lunar-linux.org>
	<445DF4EF.3080509@gmail.com>
Reply-To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:35050 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932166AbWEGOwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 10:52:42 -0400
In-Reply-To: <445DF4EF.3080509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 07 May 2006 22:23:59 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The digit in the middle is the SPD limit and 0 means no limit.
> Hmm... wait, this is a hitachi disk.  Have you tried the feature
> tool?  Hitachi limits the spd of the harddrive tso 1.5 gbps, probably
> for compatibility reasons, and allows users to enable it with the
> feature tool.
> 
> http://www.hitachigst.com/hdd/support/download.htm#FeatureTool

That did it. Thank you very much Tejun. I promise I'll be looking for
such a tool next time before I bother any of the kernel related
mailinglists. My Hitachi is now officially running at 3.0Gbps .. and I
even managed to enable some of the other features (Accustic Management
and Power Management).

As a sidenote: Hitachi also provides bootable CD images. Very
convenient!

> > Given your patch though .. your git-based code looks much simpler. I
> > wonder if that is a good or a bad thing and wether I should try a
> > more recent kernel .. (?)
> 
> The patch was pulled from libata devel tree.  I was being lazy again
> and didn't test it on 2.6.16.14.  :p  However, I can assure you
> libata doesn't play much role in PHY spd configuration.

Nevermind here, I'm a long term C lover .. so it wasn't all that
complicated to adjust the patch. Besides, you've been very kind in
providing a patch at least .. since otherwise I'd have to dig one up
myself (and I am lazy as well ;-).

Thanks again.

Regards,

Moritz
