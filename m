From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BUG] PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 13:37:16 +0100
Message-ID: <200803131337.17095.bzolnier@gmail.com>
References: <47D8F73F.4090501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:41149 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbYCMMXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 08:23:34 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3343141fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 05:23:32 -0700 (PDT)
In-Reply-To: <47D8F73F.4090501@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>


Hi,

On Thursday 13 March 2008, Richard Genoud wrote:
> Hi!
> On ubuntu bug tracker, there's some bug reports about DVD drives that don't respond anymore.
> 
> The affected drives are:
> PLEXTOR DVDR PX-740A
> BENQ DVD DD DW1620
> PHILIPS DVDR14P
> SS-SAMSUNG SCR-3232
> Matsushita SR-8584-B
> (for now)
> 
> the error message is :
> hda: status error: error=0x00 { }
> ide: failed opcode was: unknown
> hda: drive not ready for command
> hda: status error: status 0x59 { DriveReady SeekComplete DataRequest Error }

Could we get full dmesg for this particular system/problem?

Please also;
- test 2.6.25-rc5 on _your_ system
- verify that configuration of hda and hdb devices is correct
  (master/slave settings)

> more details on the ubuntu bug-tracker:
> https://bugs.launchpad.net/bugs/179336
> https://bugs.launchpad.net/bugs/182996
> https://bugs.launchpad.net/bugs/181561

There is far too much information there (different error messages,
different host drivers, some systems are using libata...) - please
open a new bug entry at http://bugzilla.kernel.org so we can start
"clean" and fully concentrate on fixing this bug.

PS Thanks for bisecting it.

Bart
