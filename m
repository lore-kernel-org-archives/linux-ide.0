From: Brad Fitzpatrick <brad@danga.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Sat, 13 Jan 2007 23:40:39 +0000 (UTC)
Message-ID: <Pine.LNX.4.58.0701132336370.17363@mailx>
References: <Pine.LNX.4.58.0701050332200.26166@mailx> <45A1AD84.5060202@gmail.com>
 <Pine.LNX.4.58.0701130214230.17363@mailx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.danga.com ([207.7.148.197]:55187 "EHLO danga.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422834AbXAMXkQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jan 2007 18:40:16 -0500
In-Reply-To: <Pine.LNX.4.58.0701130214230.17363@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, 13 Jan 2007, Brad Fitzpatrick wrote:

> I tried another disk (but of the same type), and got the same results both
> direct and via PMP.
>
> Are these disks too old to be hot-plugged?  (but I recall the
> identical errors happening on boot after I power-cycled the enclosure
> and the host...)

Conclusion to this story, for posterity:

Seems to be the disk type.

I have six Western Digital WD2500JD-00GBB0.  Tried two both direct and
PMP, no success.

Went and bought a new Segate ST3500630AS 500GB and it hotplugged both
direct and PMP without problems.

So I guess the old WD2500JD-00GBB0 aren't compatible?

- Brad

