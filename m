From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-acpi: missing _SDD is not an error
Date: Fri, 20 Nov 2009 03:48:22 -0500
Message-ID: <4B0657D6.3000004@garzik.org>
References: <4B03F585.3090000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35101 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZKTIsW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Nov 2009 03:48:22 -0500
In-Reply-To: <4B03F585.3090000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

On 11/18/2009 08:24 AM, Tejun Heo wrote:
> Missing _SDD is not an error.  Don't treat it as one.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Takashi Iwai<tiwai@suse.de>
> ---
>   drivers/ata/libata-acpi.c |   15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)


hmmmm, do you have a link to the bug report?

How critical is this?  Is it a regression fix?

We are very late into 2.6.32-rc, where we try to minimize the patches 
applied as much as possible.

	Jeff


