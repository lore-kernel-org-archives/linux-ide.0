From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.0test10 hangs just after IDE detection
Date: Wed, 26 Nov 2003 23:11:47 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200311262311.48092.bzolnier@elka.pw.edu.pl>
References: <20031126215448.GA1801@bijwaard.dyns.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39410 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264375AbTKZWKm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2003 17:10:42 -0500
In-Reply-To: <20031126215448.GA1801@bijwaard.dyns.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Dennis Bijwaard <bijwaard@home.nl>
Cc: linux-ide@vger.kernel.org


IDE related changes in 2.6.0-test10 are:
ide-tape fixes, alim15x3 fix, AMD and nVidia update and TCQ disable.

If you are using aic7xxx SCSI you should try -test11 first (fixes hang).

If it doesn't help you can easily verify if this hang is caused by IDE,
just try to boot kernel compiled without IDE support.

--bart

On Wednesday 26 of November 2003 22:54, Dennis Bijwaard wrote:
> Hi,
>
> I've been running 2.6.0test9 and earlier without much problems w.r.t.
> IDE. Now with test10 it hangs just after IDE detection. I suspect this
> is because I have IDEDISK configured as a module because my main drives are
> all SCSI. I use CONFIG_PREEMPT.
>
> This is the last that the kernel reports before it stops (does not react
> to SysRq interupts):
>
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

