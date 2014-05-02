From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv2] ata: SATL compliance for Inquiry Product Revision
Date: Fri, 2 May 2014 10:58:53 -0400
Message-ID: <20140502145853.GA10204@htj.dyndns.org>
References: <1398964323-26014-1-git-send-email-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:51319 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaEBO65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2014 10:58:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2343183qcx.13
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2014 07:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398964323-26014-1-git-send-email-keith.busch@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-ide@vger.kernel.org

On Thu, May 01, 2014 at 11:12:03AM -0600, Keith Busch wrote:
> The SCSI-to-ATA Translation standard says to use data words 25 and 26
> unless they are spaces. For devices that use these words in the firmware
> field, they are generally more useful anyway.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
