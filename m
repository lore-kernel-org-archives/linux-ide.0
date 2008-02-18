From: Daniel Exner <dex@dragonslave.de>
Subject: Re: 2.6.25 Regression: DriveStatusError
Date: Mon, 18 Feb 2008 16:23:27 +0100
Message-ID: <200802181623.28009.dex@dragonslave.de>
References: <200802110927.36109.dex@dragonslave.de> <200802112051.45395.bzolnier@gmail.com>
Reply-To: webmaster@dragonslave.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server009.webpack.hosteurope.de ([80.237.130.17]:55970 "EHLO
	server009.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754726AbYBRPX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 10:23:59 -0500
In-Reply-To: <200802112051.45395.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

Bartlomiej Zolnierkiewicz wrote:

> On Monday 11 February 2008, Daniel Exner wrote:
> > Hi!
> >
> > Please CC me as I'm not subscribed to any list, thx in advance.
> >
> > I tried all -git Kernels since begining of cycle and starting when they
> > finaly compiled fine, they weren't able to mount my root.
> >
> > As my laptop with the serial cable is on the run currently I wasn't able
> > to get a trace (perhaps by the we) but error written by hand from screen
> > was this:
> >
> > hda: task_no_data_intr: status=0x51 {DriveReady SeekComplete Error}
> > hda: task_no_data_intr: error=0x04 {DriveStatusError}
> > failed opcode was: 0xe1
>
> [...]
>
> Could you please try 2.6.25-rc1-git1:
>
> http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.25-rc1-git1.bz2
Fixed, as is in rc2.

thx 

P.S. (OT)
2.6.25-rc2 gives 200 points more in Geekbench then 2.6.24.x :)

-- 
Greetings
Daniel Exner
