From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 22 Mar 2007 17:50:07 +0300
Message-ID: <4602979F.80002@ru.mvista.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com> <4600BA1C.7060300@tw.ibm.com> <4600F45C.3000303@gmail.com> <46021CDA.3070807@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12917 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933041AbXCVOtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Mar 2007 10:49:35 -0400
In-Reply-To: <46021CDA.3070807@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hello.

Albert Lee wrote:

> Thanks for the detailed log.
> It looks like the bad INQUIRY command
>   "CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00" (INQUIRY, length=254, EVPD=1)
> is coming from the user space, not the SCSI mid-layer.

> I guess two problems together caused this bug:
> 1. Ubuntu Linux issues an incorrect INQUIRY command to the drive.
>    (Other distros seem to have the INQUIRY correct.)

    But what is incorrect about sending INQUIRY with EVPD bit?

MBR, Sergei
