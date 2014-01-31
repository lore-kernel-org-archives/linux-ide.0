From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ata: enable quirk from jmicron JMB350 for JMB394
Date: Fri, 31 Jan 2014 07:06:29 -0500
Message-ID: <20140131120629.GF26148@htj.dyndns.org>
References: <1391080830-2802-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:37308 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbaAaMGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Jan 2014 07:06:35 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so6123345qae.35
        for <linux-ide@vger.kernel.org>; Fri, 31 Jan 2014 04:06:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391080830-2802-1-git-send-email-den@openvz.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: den@parallels.com, linux-ide@vger.kernel.org

On Thu, Jan 30, 2014 at 03:20:30PM +0400, Denis V. Lunev wrote:
> From: "Denis V. Lunev" <den@openvz.org>
> 
> Without the patch the kernel blames about
>  ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>  ata11.15: Port Multiplier vendor mismatch '0x197b' != '0x123'
>  ata11.15: PMP revalidation failed (errno=-19)
>  ata11.15: failed to recover PMP after 5 tries, giving up
> This patch helps to bypass this error and the device becomes
> functional.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Tejun Heo <tj@kernel.org>
> CC: <linux-ide@vger.kernel.org>

Aplied to libata/for-3.14-fixes w/ minor description and comment
updates.

Thanks.

-- 
tejun
