From: "Oliver.Korpilla@gmx.de" <Oliver.Korpilla@gmx.de>
Subject: Re: kernel history of ide performance
Date: Tue, 05 Apr 2005 11:02:19 +0200
Message-ID: <4252541B.3030209@gmx.de>
References: <1112690797.4252506dd574e@kiun.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:61888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261631AbVDEJCb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 05:02:31 -0400
In-Reply-To: <1112690797.4252506dd574e@kiun.homelinux.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kiu <kiu@gmx.net>
Cc: linux-ide@vger.kernel.org

kiu wrote:
> Hi ide team,
> 
> i often heard "uh, since kernel 2.6.bla the ide perfomance is soo bad".
> Because of that (and the joy of writing bash scripts noone else will understand
> *g*) i wrote an automated test script to get comparable measurements.
> 
> The script compiles 2.6.0-2.6.11.6 (yes "" | make oldconfig), boots each kernel,
> runs hdparm/bonnie++ and create some pngs with gnuplot.
> 
> I ran the script on a Intel 82371AB/EB/MB PIIX4/PIICeleron 333/IC35L040AVER07
> machine and you can find the results here:
> 
>     http://www.kiu.weite-welt.com/misc/idetest
> 
> I am quite busy at the moment and hopefully have time next month to clean up the
> scripts for a release (are you interested?) and do further testing...

This looks like a mixed bag: some regression, some clear improvements, 
mostly the same. Nice work!

Does this portray the IDE situation or more the situation of the PIIX 
chipset - I guess the code isn't changed as much since it should be 
rather mature?

With kind regards,
Oliver Korpilla
