From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Mon, 07 May 2007 12:12:32 -0300
Message-ID: <463F41E0.30009@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com> <463B8B3C.9010509@gmail.com> <463CC22C.20902@gmail.com> <463CC52E.8050500@gmail.com> <463EF97D.1000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:55218 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934132AbXEGPMj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 11:12:39 -0400
Received: by an-out-0708.google.com with SMTP id d18so149557and
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 08:12:38 -0700 (PDT)
In-Reply-To: <463EF97D.1000805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

Tejun Heo escribi=F3:
> Tejun Heo wrote:
>  =20
>> Mat=ED=ADas Alejandro Torres wrote:
>>    =20
>>> May be it disables MSI for some other device/bridge/what ever:
>>>      =20
>> Right, that device gotta be PCI-e or PCI-x bridge and the disk
>> controller lives in a different bus.  Please apply the attached patc=
h.
>> This one really should fix the problem.  :-)
>>    =20
>
> Ping.
>
>  =20
Pong.

$ patch -p1 --dry-run <../patch

patching file drivers/pci/quirks.c
Hunk #1 FAILED at 1624.
1 out of 1 hunk FAILED -- saving rejects to file=20
drivers/pci/quirks.c.rej (empty file)

