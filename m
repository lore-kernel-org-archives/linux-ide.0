From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Updated SiI h/w docs (was Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA
 masks)
Date: Fri, 26 Jan 2007 16:14:51 +0300
Message-ID: <45B9FECB.2020806@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	<20070119003226.14846.87052.sendpatchset@localhost.localdomain>	<45B4FFBD.40507@ru.mvista.com>	<20070122184620.1c8b87ac@localhost.localdomain>	<45B51E83.1010904@ru.mvista.com> <20070122213109.21e4e805@localhost.localdomain> <45B53D05.1010807@garzik.org> <45B6071C.90703@ru.mvista.com> <45B761F8.1060505@ru.mvista.com> <45B92D2B.4070302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7868 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965668AbXAZNOy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 08:14:54 -0500
In-Reply-To: <45B92D2B.4070302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello.

Jeff Garzik wrote:

>>    Now, the site seems to have 2 versions of the PCI-648/9 specs. :-)
>> I looked into those in specs/sii and noted that PCI-648 spec was newer 
>> than mine, but PCI-649 was older.
>>    It's probably a good idea to put all the CMD/SiI files in the 
>> single directory, so there's no dupes.

>>> PS: I certainly used to have a newer spec for PCI0646U2 but it's not 
>>> at hand for some reason...

>>    Oops, this chip is named differently, without 0 -- that's why I 
>> didn't notice the file locally. Sending rev 1.3 now...

> (added linux-ide to CC and SiI folks to BCC)

> All the docs are now at

>     http://gkernel.sourceforge.net/specs/sii/

> including the one you just sent.

    Well, the purpose of avoiding dupes still not achieved. :-)
    Though maybe having several revisions of one spec is worth it...

     Jeff

MBR, Sergei
