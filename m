From: Tejun Heo <tj@kernel.org>
Subject: Re: detect and warn about ahci-remapped NVMe devices
Date: Mon, 5 Dec 2016 14:33:27 -0500
Message-ID: <20161205193327.GB30331@mtj.duckdns.org>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36229 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcLETdb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2016 14:33:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so17317342pgx.3
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2016 11:33:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1480703463-17489-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

Hello,

On Fri, Dec 02, 2016 at 07:31:00PM +0100, Christoph Hellwig wrote:
> Just a small band-aid to detect the AHCI-remapped NVMe devices
> for now.  Hopefully we'll eventually get a fake PCIe root port
> driver ala VMD for them.

Applied 1-3 to libata/for-4.10.  Fixed the dup constant definition in
0002.

Thanks.

-- 
tejun
