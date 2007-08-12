From: Frederik Himpe <fhimpe@telenet.be>
Subject: Re: pata_ali exceptions (timeout)
Date: Sun, 12 Aug 2007 15:17:47 +0200
Message-ID: <1186924667.3832.9.camel@Anastacia>
References: <200708111203.34965.fhimpe@telenet.be>
	 <200708121407.03403.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qYGv+XGE4tot3V9pGT9l"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ananke.telenet-ops.be ([195.130.137.78]:35382 "EHLO
	ananke.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571AbXHLNRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Aug 2007 09:17:49 -0400
In-Reply-To: <200708121407.03403.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


--=-qYGv+XGE4tot3V9pGT9l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sun, 2007-08-12 at 14:07 +0400, Andrey Borzenkov wrote:
> On Saturday 11 August 2007, you wrote:
> > I attach the output of dmesg and lspci -vvxx
> >
> 
> could you please use lspci -nn... it displays numerical IDs in addition to 
> textual translation, making it easier to check.

I have attached the output of lspci -nn.

-- 
Frederik Himpe

--=-qYGv+XGE4tot3V9pGT9l
Content-Disposition: attachment; filename=lspci-nn
Content-Type: text/plain; name=lspci-nn; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge [0600]: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] [1002:cab2] (rev 02)
00:01.0 PCI bridge [0604]: ATI Technologies Inc PCI Bridge [IGP 340M] [1002:7010]
00:06.0 Multimedia audio controller [0401]: ALi Corporation M5451 PCI AC-Link Controller Audio Device [10b9:5451] (rev 02)
00:07.0 ISA bridge [0601]: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+] [10b9:1533]
00:0a.0 CardBus bridge [0607]: Texas Instruments PCI4410 PC card Cardbus Controller [104c:ac41] (rev 02)
00:0a.1 FireWire (IEEE 1394) [0c00]: Texas Instruments PCI4410 FireWire Controller [104c:8017] (rev 02)
00:0b.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ [10ec:8139] (rev 20)
00:0c.0 Communication controller [0780]: Conexant HSF 56k HSFi Modem [14f1:2f00] (rev 01)
00:10.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c4)
00:11.0 Bridge [0680]: ALi Corporation M7101 Power Management Controller [PMU] [10b9:7101]
00:13.0 USB Controller [0c03]: NEC Corporation USB [1033:0035] (rev 41)
00:13.1 USB Controller [0c03]: NEC Corporation USB [1033:0035] (rev 41)
00:13.2 USB Controller [0c03]: NEC Corporation USB 2.0 [1033:00e0] (rev 02)
01:05.0 VGA compatible controller [0300]: ATI Technologies Inc Radeon IGP 330M/340M/350M [1002:4337]
02:00.0 Network controller [0280]: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller [14e4:4320] (rev 03)

--=-qYGv+XGE4tot3V9pGT9l--

