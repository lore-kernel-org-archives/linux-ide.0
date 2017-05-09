From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH Resend] ahci: Acer SA5-271 SSD Not Detected Fix
Date: Tue, 9 May 2017 10:20:23 -0400
Message-ID: <20170509142023.GB8609@htj.duckdns.org>
References: <086b549a-e2ec-58c4-42af-c5b5e23f67a7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36856 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdEIOUZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 10:20:25 -0400
Received: by mail-yb0-f196.google.com with SMTP id b2so32101yba.3
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2017 07:20:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <086b549a-e2ec-58c4-42af-c5b5e23f67a7@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sui Chen <suichen6@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, Sui.

On Tue, May 09, 2017 at 07:47:22AM -0500, Sui Chen wrote:
> (Correction in this resend: fixed function name acer_sa5_271_workaround; fixed
>  the always-true condition in the function; fixed description.)
> 
> On the Acer Switch Alpha 12 (model number: SA5-271), the internal SSD may not
> get detected because the port_map and CAP.nr_ports combination causes the driver
> to skip the port that is actually connected to the SSD. More specifically,
> either all SATA ports are identified as DUMMY, or all ports get ``link down''
> and never get up again.
> 
> This problem occurs occasionally. When this problem occurs, CAP may hold a
> value of 0xC734FF00 or 0xC734FF01 and port_map may hold a value of 0x00 or 0x01.
> When this problem does not occur, CAP holds a value of 0xC734FF02 and port_map
> may hold a value of 0x07. Overriding the CAP value to 0xC734FF02 and port_map to
> 0x7 significantly reduces the occurrence of this problem.
> 
> Link: https://bugzilla.kernel.org/attachment.cgi?id=253091
> Signed-off-by: Sui Chen <suichen6@gmail.com>
> Tested-by: Damian Ivanov <damianatorrpm@gmail.com>

Applied to libata/for-4.12-fixes w/ stable cc'd and a couple trivial
changes.

> @@ -1636,6 +1669,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct
> pci_device_id *ent)

The patch was new line damaged here.  You probably wanna make sure
that your mail client isn't breaking long lines automatically.

Thanks!

-- 
tejun
