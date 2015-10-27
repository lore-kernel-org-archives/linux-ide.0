From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: enable LBA flag in taskfile for
 ata_scsi_pass_thru()
Date: Tue, 27 Oct 2015 16:49:23 +0900
Message-ID: <20151027074923.GA8783@mtj.duckdns.org>
References: <1445931706-9436-1-git-send-email-vinayak.kale@seagate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35808 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbbJ0Hta (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 03:49:30 -0400
Content-Disposition: inline
In-Reply-To: <1445931706-9436-1-git-send-email-vinayak.kale@seagate.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinayak.kale@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Tue, Oct 27, 2015 at 01:11:46PM +0530, vinayak.kale@gmail.com wrote:
> From: Vinayak Kale <vinayak.kale@seagate.com>
> 
> Enable LBA in taskfile flags for ata_scsi_pass_thru()
> 
> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
