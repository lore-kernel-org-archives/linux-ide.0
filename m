From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel history of ide performance
Date: Tue, 5 Apr 2005 11:14:39 +0200
Message-ID: <58cb370e050405021470f3a851@mail.gmail.com>
References: <1112690797.4252506dd574e@kiun.homelinux.net>
	 <4252541B.3030209@gmx.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:46490 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261648AbVDEJOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 05:14:39 -0400
Received: by wproxy.gmail.com with SMTP id 68so366959wra
        for <linux-ide@vger.kernel.org>; Tue, 05 Apr 2005 02:14:39 -0700 (PDT)
In-Reply-To: <4252541B.3030209@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Oliver.Korpilla@gmx.de" <Oliver.Korpilla@gmx.de>
Cc: kiu <kiu@gmx.net>, linux-ide@vger.kernel.org

On Apr 5, 2005 11:02 AM, Oliver.Korpilla@gmx.de <Oliver.Korpilla@gmx.de> wrote:
> kiu wrote:
> > Hi ide team,
> >
> > i often heard "uh, since kernel 2.6.bla the ide perfomance is soo bad".
> > Because of that (and the joy of writing bash scripts noone else will understand
> > *g*) i wrote an automated test script to get comparable measurements.
> >
> > The script compiles 2.6.0-2.6.11.6 (yes "" | make oldconfig), boots each kernel,
> > runs hdparm/bonnie++ and create some pngs with gnuplot.
> >
> > I ran the script on a Intel 82371AB/EB/MB PIIX4/PIICeleron 333/IC35L040AVER07
> > machine and you can find the results here:
> >
> >     http://www.kiu.weite-welt.com/misc/idetest
> >
> > I am quite busy at the moment and hopefully have time next month to clean up the
> > scripts for a release (are you interested?) and do further testing...
> 
> This looks like a mixed bag: some regression, some clear improvements,
> mostly the same. Nice work!
> 
> Does this portray the IDE situation or more the situation of the PIIX
> chipset - I guess the code isn't changed as much since it should be
> rather mature?

Probably the situation of VM code...

Having scripts at hand would be useful to double check that 
testing procedure itself is OK.

Bartlomiej
