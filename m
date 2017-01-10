From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: switch to dynamic allocation insted of
 ata_scsi_rbuf
Date: Tue, 10 Jan 2017 11:06:23 -0500
Message-ID: <20170110160623.GC6666@htj.duckdns.org>
References: <1484064272-24129-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36174 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965989AbdAJQG0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 11:06:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id b22so13200033pfd.3
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2017 08:06:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484064272-24129-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

On Tue, Jan 10, 2017 at 05:04:32PM +0100, Christoph Hellwig wrote:
> Note of the emulated commands in the pageout/pagein path, so just do
> a GFP_NOIO dynamic allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
