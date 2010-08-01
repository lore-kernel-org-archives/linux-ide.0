From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: fix locking around SIDPR access
Date: Sun, 01 Aug 2010 19:48:36 -0400
Message-ID: <4C5607D4.20302@garzik.org>
References: <4C45B091.2000002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57322 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0HAXsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Aug 2010 19:48:39 -0400
Received: by gxk23 with SMTP id 23so1099738gxk.19
        for <linux-ide@vger.kernel.org>; Sun, 01 Aug 2010 16:48:39 -0700 (PDT)
In-Reply-To: <4C45B091.2000002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Mark Knecht <markknecht@gmail.com>, Paul Check <paul@thechecks.ca>

On 07/20/2010 10:20 AM, Tejun Heo wrote:
> SIDPR window registers are shared across ports and as each access is
> done in two steps, accesses to different ports under EH may race.
> This primarily is caused by incorrect host locking in EH context and
> should be fixed by defining locking requirements for each EH operation
> which can be used during EH and enforcing them but for now work around
> the problem by adding a dedicated SIDPR lock and grabbing it for each
> SIDPR access.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Mark Knecht<markknecht@gmail.com>
> Reported-by: Paul Check<paul@thechecks.ca>
> Cc: stable@kernel.org
> ---
>   drivers/ata/ata_piix.c |    8 ++++++++
>   1 file changed, 8 insertions(+)

applied

