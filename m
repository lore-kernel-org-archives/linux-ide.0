From: "Jan Beulich" <jbeulich@novell.com>
Subject: AHCI driver preferring nr_ports over port map
Date: Fri, 01 Feb 2008 15:12:15 +0000
Message-ID: <47A344DF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36333
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350AbYBAPcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 10:32:20 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

while I realize that Intel's documentation may not be consistent with
anything more generic (which I don't know where to look for), this
current behavior seems to contradict what Intel documents for ESB2:

"23.3.1.4 PI =E2=80=93 Ports Implemented Register (D31:F2)
Address Offset: ABAR + 0Ch=E2=80=930Fh Attribute: R/WO, RO
Default Value: 00000000h Size: 32 bits

This register indicates which ports are exposed to the Intel=C2=AE
631xESB/632xESB I/O Controller Hub. It is loaded by platform BIOS. It
indicates which ports that the device supports are available for
software to use. For ports that are not available, software must not
read or write to registers within that port."

Could you shed any extra light on this?

Thanks, Jan
