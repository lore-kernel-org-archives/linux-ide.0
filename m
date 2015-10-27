From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: add support for NCQ commands for SG interface
Date: Tue, 27 Oct 2015 15:16:57 +0900
Message-ID: <20151027061657.GB2888@mtj.duckdns.org>
References: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35640 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbJ0GRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 02:17:03 -0400
Content-Disposition: inline
In-Reply-To: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinayak.kale@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Tue, Oct 27, 2015 at 11:19:15AM +0530, vinayak.kale@gmail.com wrote:
> From: Vinayak Kale <vinayak.kale@seagate.com>
> 
> This patch is needed to make NCQ commands with FPDMA protocol value
> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
> 
> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
