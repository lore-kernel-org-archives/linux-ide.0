From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: ahci: find eSATA ports and flag them as removable
Date: Wed, 30 Sep 2015 17:39:10 -0400
Message-ID: <20150930213910.GG2627@mtj.duckdns.org>
References: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36547 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbbI3VjO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Sep 2015 17:39:14 -0400
Received: by ykdt18 with SMTP id t18so59720693ykd.3
        for <linux-ide@vger.kernel.org>; Wed, 30 Sep 2015 14:39:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Sep 30, 2015 at 09:10:25PM +0200, Manuel Lauss wrote:
> If the AHCI ports' HPCP or ESP bits are set, the port
> should be considered external (e.g. eSATA) and is marked
> as removable.  Userspace tools like udisks then treat it
> like an usb drive.
> 
> With this patch applied, when I plug a drive into the esata port,
> KDE pops up a window asking what to do with the drives(s), just
> like it does for any random USB stick.
> 
> Removability is indicated to the upper layers by way of the
> SCSI RMB bit, as I haven't found another way to signal
> userspace to treat a sata disk like any usb stick.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to libata/for-4.4.  Let's see what happens.

Thanks.

-- 
tejun
