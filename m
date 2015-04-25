From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/2] libata: Ignore spurious PHY event on LPM policy
 change
Date: Sat, 25 Apr 2015 16:53:59 -0400
Message-ID: <20150425205359.GB1499@htj.duckdns.org>
References: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
 <1429984357-2223-3-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vn0-f54.google.com ([209.85.216.54]:42014 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbDYUyE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2015 16:54:04 -0400
Content-Disposition: inline
In-Reply-To: <1429984357-2223-3-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Apr 25, 2015 at 07:52:37PM +0200, Gabriele Mazzotta wrote:
> When the LPM policy is set to ATA_LPM_MAX_POWER, the device might
> generate a spurious PHY event that cuases errors on the link.
> Ignore this event if it occured within 10s after the policy change.
> 
> The timeout was chosen observing that on a Dell XPS13 9333 these
> spurious events can occur up to roughly 6s after the policy change.
> 
> Link: http://lkml.kernel.org/g/3352987.ugV1Ipy7Z5@xps13
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Applied 1-2 to libata/for-4.1-fixes w/ stable cc'd.

Thanks a lot.

-- 
tejun
