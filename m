From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] [libata]Issue SRST to Disks behind Sil3726
Date: Wed, 19 Oct 2011 17:37:20 -0700
Message-ID: <20111020003720.GU25124@google.com>
References: <4E959E1F.20001@teksavvy.com>
 <1319070953-24391-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab1JTAh0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 20:37:26 -0400
Received: by iaek3 with SMTP id k3so2752009iae.19
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 17:37:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1319070953-24391-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: kernel@teksavvy.com, mihrcke@gmail.com, derry@high-rely.com, linux-ide@vger.kernel.org

On Wed, Oct 19, 2011 at 05:35:53PM -0700, Gwendal Grignou wrote:
> Reenable sending SRST to devices connected behind a Sil3726 PMP.
> This allow staggered spinups and handles drives that spins up slowly.
> 
> While the drives spin up, the PMP will not accept SRST.
> Most controllers reissue the reset until the drive is ready, while
> some [Sil3124] returns an error.
> In ata_eh_error, wait for the next reset deadline before resetting the ATA
> port and trying again.
> 
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>

 Acked-by: Tejun Heo <tj@kernel.org>

I hope this can be applied to other controllers too as the failure
mode should be similar for all SIMG PMPs.

Thanks.

-- 
tejun
