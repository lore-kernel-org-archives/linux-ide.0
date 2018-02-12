From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add check for device presence (PCIe hot unplug) in
 ahci_stop_engine()
Date: Mon, 12 Feb 2018 09:17:58 -0800
Message-ID: <20180212171758.GZ695913@devbig577.frc2.facebook.com>
References: <20180130100255.24965-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43733 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbeBLRSB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2018 12:18:01 -0500
Received: by mail-qt0-f181.google.com with SMTP id d26so409285qtk.10
        for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2018 09:18:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180130100255.24965-1-sr@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-ide@vger.kernel.org

On Tue, Jan 30, 2018 at 11:02:55AM +0100, Stefan Roese wrote:
> Exit directly with ENODEV, if the AHCI controller is not available
> anymore. Otherwise a delay of 500ms for each port is added to the remove
> function while trying to issue a command on the non-existent controller.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Tejun Heo <tj@kernel.org>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
