From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ide-scsi lock
Date: Thu, 19 Feb 2004 10:21:15 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4034D46B.4020204@pobox.com>
References: <20040219135311.95851.qmail@web12603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267305AbUBSPVa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 10:21:30 -0500
In-Reply-To: <20040219135311.95851.qmail@web12603.mail.yahoo.com>
List-Id: linux-ide@vger.kernel.org
To: Joilnen Leite <pidhash@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Joilnen Leite wrote:
> drivers/scsi/ide-scsi.c:897
> 
> spin_lock_irqsave(&ide_lock, flags);
> while (HWGROUP(drive)->handler) {
>        HWGROUP(drive)->handler = NULL;
>        schedule_timeout(1);
> }


Yep, that's definitely a bug.  Good spotting.

	Jeff



