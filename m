From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel history of ide performance
Date: Tue, 5 Apr 2005 11:00:40 +0200
Message-ID: <58cb370e0504050200759f42f1@mail.gmail.com>
References: <1112690797.4252506dd574e@kiun.homelinux.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:41488 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261628AbVDEJAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 05:00:40 -0400
Received: by wproxy.gmail.com with SMTP id 68so364569wra
        for <linux-ide@vger.kernel.org>; Tue, 05 Apr 2005 02:00:40 -0700 (PDT)
In-Reply-To: <1112690797.4252506dd574e@kiun.homelinux.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kiu <kiu@gmx.net>
Cc: linux-ide@vger.kernel.org

Hi,

On Apr 5, 2005 10:46 AM, kiu <kiu@gmx.net> wrote:
> Hi ide team,
> 
> i often heard "uh, since kernel 2.6.bla the ide perfomance is soo bad".
> Because of that (and the joy of writing bash scripts noone else will understand
> *g*) i wrote an automated test script to get comparable measurements.

Please note that hdparm results can be highly influenced 
by changes in the Virtual Memory management.

One of my TODO items is tool for testing raw IDE performance,
so we know where to put blame for degraded results... :)
[ but it should wait until all IDE driver is taskfile based ]

> The script compiles 2.6.0-2.6.11.6 (yes "" | make oldconfig), boots each kernel,
> runs hdparm/bonnie++ and create some pngs with gnuplot.
> 
> I ran the script on a Intel 82371AB/EB/MB PIIX4/PIICeleron 333/IC35L040AVER07
> machine and you can find the results here:
> 
>     http://www.kiu.weite-welt.com/misc/idetest

Good job, thanks for doing this.

> I am quite busy at the moment and hopefully have time next month to clean up the
> scripts for a release (are you interested?) and do further testing...

It would be great to test at least every -rc kernel so eventual
regressions can be discovered (and fixed) before final release.

Bartlomiej
