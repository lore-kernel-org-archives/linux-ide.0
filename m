From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: complain on spurious completion notifiers
Date: Thu, 22 Feb 2007 16:09:07 +0900
Message-ID: <45DD4193.6020802@gmail.com>
References: <45DD2FBF.1040808@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:19109 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbXBVHJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 02:09:15 -0500
Received: by py-out-1112.google.com with SMTP id a29so44032pyi
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 23:09:14 -0800 (PST)
In-Reply-To: <45DD2FBF.1040808@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> Recently Tejun wrote a patch to ahci.c to make it raise a HSM violation
> if the drive attempted to complete a tag that wasn't outstanding. We could
> run into the same problem with sata_nv ADMA. This adds code to raise a HSM
> violation error if the controller gives us a notifier tag that isn't
> outstanding, since the drive may be issuing spurious completions.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
