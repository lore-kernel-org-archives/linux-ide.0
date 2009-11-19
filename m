From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-acpi: missing _SDD is not an error
Date: Thu, 19 Nov 2009 18:36:46 -0500
Message-ID: <4B05D68E.6040508@garzik.org>
References: <4B03F585.3090000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34346 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757659AbZKSXgm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 18:36:42 -0500
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

applied


