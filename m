From: Bokhan Artem <APTEM@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 00:29:50 +0700
Message-ID: <48A31A0E.4010703@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C54D1.5080901@rtr.ca>	 <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>	 <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru>	 <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <87f94c370808130957g5aa7ac0ax881de81af8e8f926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:41873 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379AbYHMR34 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 13:29:56 -0400
In-Reply-To: <87f94c370808130957g5aa7ac0ax881de81af8e8f926@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

I have particular fast, simple and cheap controller(s) (MV88SX6081 
8-port SATA II PCI-X) with a bunch of disks w/o sw/hw raid.
I need to return an error to application ASAP if media error detected.

Greg Freemyer ?????:
>
>
> Artem,
>
> I'm not sure what your goal is but you might find it interesting that
> "Enterprise" versions of some of the drives have fast fail logic built
> into them.  ie. They don't internally retry on medium errors.
>
> As I understand it, the concept is if you have a raid setup, you don't
> want to waste time retrying a read.  It is better to fail the read
> ASAP and get the data from another source.
>
> Greg
>   

