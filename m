From: Tejun Heo <htejun@gmail.com>
Subject: Re: question about SATA vs (SATA via USB)
Date: Wed, 26 Dec 2007 17:40:03 +0900
Message-ID: <47721363.9050601@gmail.com>
References: <fkamek$gqs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:30779 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbXLZL2b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 06:28:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2212768rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 26 Dec 2007 03:28:30 -0800 (PST)
In-Reply-To: <fkamek$gqs$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org

Harri wrote:
> Next I mounted (rw, shame on me) the old SATA disk via USB
> to the PC, and tried to copy the data. But during the copy
> there were some syslog messages about file system corruptions
> on the old disk. I stopped rsync, unmounted the disk,
> and ran fsck, but it was damaged beyond repair. No chance
> to recover any data.

Hmmm... interesting.  That isn't supposed to happen.  Do you have kernel
logs saved?

-- 
tejun

