From: Lars =?ISO-8859-15?Q?T=E4uber?= <taeuber@bbaw.de>
Subject: siimage / 2.4.26-pre1
Date: Tue, 2 Mar 2004 17:01:24 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040302170124.266a6dd6.taeuber@bbaw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hippo.bbaw.de ([194.95.188.1]:25769 "EHLO hippo.bbaw.de")
	by vger.kernel.org with ESMTP id S261696AbUCBQB5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Mar 2004 11:01:57 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

i have a nforce3 mainboard with onboard sii3512 sata controller and ath=
lon64 processor. (shuttle sn85)

i'm not subscribed to a list but i frequently read the lkml archives

after changing the pci id from 3112 to 3512 for the SII3112 in pci_id.h=
 the kernel works as expected, but
if i enable io-apic support on uniprocessor i get 'lost interupts' and =
then dma timeouts.

in the documentation is told that it would not matter if i enable io-ap=
ic on UP when not present.

what exactly is the difference between 'local apic' and 'io-apic on up'=
 and how do i determine if my computer has such an 'io apic'?

thank you very much

sorry for my poor english

Lars T=E4uber
