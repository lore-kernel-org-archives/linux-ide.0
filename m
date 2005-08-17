From: linux@horizon.com
Subject: Which controllers can support port multipliers?
Date: 17 Aug 2005 13:47:18 -0400
Message-ID: <20050817174718.18095.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:23867 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751184AbVHQRrc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 13:47:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

I realize the software support isn't there now, but I'm having trouble
getting a lot of SATA drives into a cheap AMD64 computer.

Most everything has 4 ports on the motherboard, but all the cheap SATA
controllers are PCI-X, and all of the Socket 939 or 940 PCI-X motherboards
are expensive.  Yes, I can plug a PCI-X controller into an ordinary PCI
slot, but that's a big bandwidth hit.

So I'm thinking of starting my RAID system with 4x400 GB drives, but
getting a case that can hold more, and hoping that port multipliers will
appear by the time I need to expand.

But that means that I need to pick a motherboard that is hardware-capable
of port multiplier support, even if it isn't supported yet.

Does anyone know which controllers are capable of driving a port multiplier,
and which are definitely not?

Thanks!

(P.S. If anyone is searching, a cheap peripheral company named Addonics
makes Sil3124 PCI-X 4-port SATA cards.)
