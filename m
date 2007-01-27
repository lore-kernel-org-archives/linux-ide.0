From: Jim Paris <jim@jtan.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Fri, 26 Jan 2007 20:08:00 -0500
Message-ID: <20070127010800.GA21341@jim.sh>
References: <Pine.LNX.4.58.0701050332200.26166@mailx> <45A1AD84.5060202@gmail.com> <Pine.LNX.4.58.0701130214230.17363@mailx> <Pine.LNX.4.58.0701132336370.17363@mailx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:55427 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbXA0BIJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 20:08:09 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0701132336370.17363@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Fitzpatrick <brad@danga.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Brad Fitzpatrick wrote:
> Conclusion to this story, for posterity:
> 
> Seems to be the disk type.
> 
> I have six Western Digital WD2500JD-00GBB0.  Tried two both direct and
> PMP, no success.
> 
> Went and bought a new Segate ST3500630AS 500GB and it hotplugged both
> direct and PMP without problems.
> 
> So I guess the old WD2500JD-00GBB0 aren't compatible?

Hi Brad,

I came across a WD2500KS-00MJB0, and recalling this thread I gave it a
try on my system.  It worked fine connected through the PMP on my
kernel (2.6.17.4 + libata-tj-2.6.17.4-20060710).  This disk is a newer
revision, so perhaps bugs were fixed, but it's also possible that you
just got unlucky with bad disks.  At the very least the entire WD2500
line isn't necessarily bad.

-jim
