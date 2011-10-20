From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] [libata]Issue SRST to Sil3726 PMP
Date: Wed, 19 Oct 2011 17:07:00 -0700
Message-ID: <20111020000700.GT25124@google.com>
References: <4E959E1F.20001@teksavvy.com>
 <1319068962-18983-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1JTAHF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 20:07:05 -0400
Received: by iaek3 with SMTP id k3so2729202iae.19
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 17:07:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1319068962-18983-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: kernel@teksavvy.com, mihrcke@gmail.com, derry@high-rely.com, linux-ide@vger.kernel.org

Hello,

On Wed, Oct 19, 2011 at 05:02:42PM -0700, Gwendal Grignou wrote:
> Reenable sending SRST to devices connected behind a Sil3726 PMP.
> This allow staggered spinups and handles drives that spins up slowly.
> 
> While the drives spin up, the PMP will not accept SRST.
> Most controller reissues the reset until the drive is ready, while
> some [Sil3124] returns an error.
> In ata_eh_error, wait 10s before reset the ATA port and try again.

While I agree with the change, the description doesn't seem too
accurate.

* The behavior change applies to all PMPs.

* I hope 3726 change is in a separate patch.

* It waits for reset deadline which currently happens to be 10s.

Thanks.

-- 
tejun
