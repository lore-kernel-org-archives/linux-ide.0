From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: reset IOCTLs
Date: Tue, 04 Dec 2007 14:51:23 +0300
Message-ID: <47553F3B.1090805@ru.mvista.com>
References: <43830.89479.qm@web35411.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:49019 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752620AbXLDLvH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 06:51:07 -0500
In-Reply-To: <43830.89479.qm@web35411.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kantor Zsolt <kantorzsolt@yahoo.com>
Cc: linux-ide@vger.kernel.org

Hello.

Kantor Zsolt wrote:

> Can somebody tell me what is the difference between these reset commands (I'm developing an open
> source application and I would like to know this): one is in the cdrom.h (CDROMRESET - 0x5312),

    This one seems to be handled only by discrete (non-IDE) CD-ROM drivers.

> and the second with the third are in the hdreg.h (HDIO_DRIVE_RESET - 0x031c,

    This gets handled as the usual IDE reset, i.e. wia SRST bit of the device 
control register.

> WIN_DEVICE_RESET - 0x08)

    This is not an ioctl() at all but ATAPI Device Reset command which can be 
use dto reset ATAPI device insted of the usual IDE reset.

> Thanks
>   Kantor

MBR, Sergei
