From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: reset IOCTLs
Date: Tue, 04 Dec 2007 21:31:09 +0300
Message-ID: <47559CED.5010104@ru.mvista.com>
References: <719908.73262.qm@web35414.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53020 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbXLDSaw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 13:30:52 -0500
In-Reply-To: <719908.73262.qm@web35414.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kantor Zsolt <kantorzsolt@yahoo.com>
Cc: linux-ide@vger.kernel.org

Kantor Zsolt wrote:

> Thanks a lot ! I have one more question: I see that the HDIO_DRIVE_RESET - 0x031c is a soft reset,
> but the WIN_DEVICE_RESET - 0x08 for ATAPI devices is a soft reset too ?

    Yes.

> and the first one for
> non-IDE CD-ROMs is a hard reset ?

    Don't know.

> because in the cdrom.h file states this: CDROMRESET 0x5312 /*
> hard-reset the drive */

> Cheers
>   Kantor

MBR, Sergei
