From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ATA driver support for ICH9
Date: Sat, 29 Sep 2007 16:52:33 +0400
Message-ID: <46FE4A91.8030002@ru.mvista.com>
References: <432010.67065.qm@web43143.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:54503 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755974AbXI2Mwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 08:52:51 -0400
In-Reply-To: <432010.67065.qm@web43143.mail.sp1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: May Cheung <ladycheung@yahoo.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, harvey_hao@yahoo.com

Hello.

May Cheung wrote:

> We're currently using 2.6.10 and tries to bring up an HP box which has ICH9.
> The earliest libata patch available for ICH9 support seems to be 2.6.19.

> The libata directory and file structures between 2.6.10 and 2.6.19 are quite
> different.

    Right, there was no drivers/ata/ before 2.6.19-rc1...

> Is there anyway we can add/port the ICH9 support to 2.6.10? 

    Why not just modify drivers/ide/pci/piix.c?

> Please advise!

MBR, Sergei
