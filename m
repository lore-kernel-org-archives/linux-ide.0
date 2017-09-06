From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: don't use MSI for devices with the braindead Intel
 NVMe remapping scheme
Date: Wed, 6 Sep 2017 07:40:09 -0700
Message-ID: <20170906144009.GL1774378@devbig577.frc2.facebook.com>
References: <20170905164647.24101-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37006 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbdIFOkM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2017 10:40:12 -0400
Content-Disposition: inline
In-Reply-To: <20170905164647.24101-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: dan.j.williams@intel.com, john.robert.loy@gmail.com, linux-ide@vger.kernel.org, stable@vger.kernel.org

Hello,

On Tue, Sep 05, 2017 at 06:46:47PM +0200, Christoph Hellwig wrote:
> Intel AHCI controllers that also hide NVMe devices in their bar
> can't use MSI interrupts, so disable them.
> 
> Reported-by: John Loy <john.robert.loy@gmail.com>
> Testd-by: John Loy <john.robert.loy@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org

Applied to libata/for-4.14 w/ Fixes tag added and minor edits as
suggested by Dan - I changed braindead to silly, hope everyone is fine
with that.

Thanks.

-- 
tejun
