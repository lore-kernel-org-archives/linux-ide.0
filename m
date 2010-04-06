From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-sff: don't whine on spurious IRQ
Date: Tue, 06 Apr 2010 10:57:18 -0400
Message-ID: <4BBB4BCE.6050601@garzik.org>
References: <4BB2FC9E.3050301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:39073 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0DFPD1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 11:03:27 -0400
Received: by iwn35 with SMTP id 35so2268849iwn.21
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 08:03:26 -0700 (PDT)
In-Reply-To: <4BB2FC9E.3050301@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 03/31/2010 03:41 AM, Tejun Heo wrote:
> On configurations where IRQ line is shared with a different
> controller, spurious IRQs may happen continuously.  The message was
> put there primarily for debugging anyway.  Kill it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c |    4 ----
>   1 file changed, 4 deletions(-)

applied


