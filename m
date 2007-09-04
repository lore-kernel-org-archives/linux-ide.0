From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: ICH Intel PATA short cable override...
Date: Tue, 4 Sep 2007 13:37:22 +0100
Message-ID: <6278d2220709040537n4c96ffcagd9c25c94ddd29ca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753963AbXIDMhg@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

We see that in ata_piix.c, there is a whitelist for (laptop) Intel ICH
controllers with short cables, tied to specific vendor subsystem IDs.
Since my mini-ITX Ibase MI910F has the subsystem IDs specified as
Intel [1], this is unusable.

I can't find another existing mechanism to add short cable
information, to allow UDMA/66 for my on-board CF socket.

Do you suggest I cook a patch to pass a kernel argument eg 'ich=short'
or 'pata=short', or can you think of a better mechanism?

Thanks,
  Daniel

--- [1]

# lspci -vs 00:1f.2
00:1f.2 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)
SATA IDE Controller (rev 03) (prog-if 80 [Master])
        Subsystem: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA
IDE Controller

# lspci -vns 00:1f.2
00:1f.2 0101: 8086:2828 (rev 03) (prog-if 80 [Master])
        Subsystem: 8086:2828
-- 
Daniel J Blueman
