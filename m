From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata:pata_atiixp: Don't use unconnected secondary port
 on SB600
Date: Mon, 8 Jan 2018 04:02:38 -0800
Message-ID: <20180108120238.GI3668920@devbig577.frc2.facebook.com>
References: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43553 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756053AbeAHMCs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2018 07:02:48 -0500
Received: by mail-qt0-f182.google.com with SMTP id w10so13244589qtb.10
        for <linux-ide@vger.kernel.org>; Mon, 08 Jan 2018 04:02:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org

On Sun, Dec 31, 2017 at 09:11:05PM +0000, Darren Stevens wrote:
>     The AMD SB600 southbridge has an PATA IDE interface, but the
>     secondary port has no physical connections, so is disabled in
>     the PCI header which makes it appear as a legacy port.
>     
>     On most systems this causes no trouble, but the Amigaone X1000 has
>     an SB600 connected to a PowerPC SoC PCI-e root port, with an
>     emulated ISA bus. On this system a kernel panic occurs at boot
>     time during device attach for the secondary port.
>     
>     Mark the port as 'dummy' to prevent this. As a bonus, disabling
>     this will slightly speed up booting on PC systems using an
>     SB600 as they will now skip 2 known empty ports.
>     
>     Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
