From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add borked Tecra M4 to broken
 suspend list
Date: Mon, 01 Dec 2008 14:24:44 -0500
Message-ID: <493439FC.6080806@garzik.org>
References: <49314591.7060404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59003 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbYLATYr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Dec 2008 14:24:47 -0500
In-Reply-To: <49314591.7060404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, a_romanescu@yahoo.co.uk

Tejun Heo wrote:
> Tecra M4 sometimes forget what it is and reports bogus data via DMI
> which makes the machine evade broken suspend matching and thus fail
> suspend/resume.  This patch updates piix_broken_suspend() such that it
> can match such case.  As the borked DMI data is a bit generic,
> matching many entries to make the match more specific is necessary.
> As the usual DMI matching is limited to four entries, this patch uses
> hard coded manual matching.
> 
> This is reported by Alexandru Romanescu.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alexandru Romanescu <a_romanescu@yahoo.co.uk>
> ---
>  drivers/ata/ata_piix.c |   15 +++++++++++++++

applied


