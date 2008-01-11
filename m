From: Marc Howard Zuckman <marc@fallon.classyad.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Thu, 10 Jan 2008 22:00:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801102143150.11200@classyad.com>
References: <200801051734.18088.marc@fallon.classyad.com> <478434C4.5000209@gmail.com>
 <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60037
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYAKC7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 21:59:34 -0500
In-Reply-To: <47861B05.2010201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 10 Jan 2008, Tejun Heo wrote:

>
> Oh... I thought you were using libata drivers because you mentioned
> pata_it821x on the subject.  The IDE driver supports 'hdparm -d 1' fine.
> I wonder why that's not working.  Also, the driver is configuring your
> disk to PIO0.
>
> Cc'ing Alan and Bartlomiej.  Guys, is this the smart mode problem?  Do
> ide and libata have this fixed in 2.6.24-rc?
>
And I thought I was using pata_it821x because pata_it821x.o is compiled
as an object file in my source tree.  On the other hand, it821x.o  is also compiled.
Looking back at the .config file, CONFIG_ATA is not set, so I'm not
quite sure why pata_821x.o does exist.

Is it possible that both drivers are present in the kernel and conflict
with one another in some fashion?

Marc H. Zuckman
