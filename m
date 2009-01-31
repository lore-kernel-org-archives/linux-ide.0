From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 17:15:37 +0300
Message-ID: <49845D09.9010608@ru.mvista.com>
References: <20090131122500.f6817013.cjsthompson@gmail.com> <yq1pri31vsu.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35003 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751896AbZAaOPo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 09:15:44 -0500
In-Reply-To: <yq1pri31vsu.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Christoph .J Thompson" <cjsthompson@gmail.com>, linux-ide@vger.kernel.org

Hello.

Martin K. Petersen wrote:

>>>>>> "Christoph" == Christoph J Thompson <cjsthompson@gmail.com> writes:
>>>>>>             
>
> Christoph> I'm having problems booting a kernel with pata_cs5536 on this
> Christoph> box:
>
> Christoph> [ 2.322395] VFS: Cannot open root device "LABEL=root"
>
> Your initrd isn't set up correctly.  Probably missing the pata_cs5536
> driver (or not there at all).

   If you'd have read all the log and not that one line, you'd have seen 
that pata_cs5536 was present. ;-)

MBR, Sergei


