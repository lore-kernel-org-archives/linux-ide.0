From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Fri, 24 Aug 2012 18:31:11 -0700 (PDT)
Message-ID: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm28-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.128]:42659 "HELO
	nm28-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750812Ab2HYBbN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2012 21:31:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

To add some more info - i just noticed in dmesg of the latest kernel-2.=
5.2 some suspicious lines:

	* [ =A0 44.251706] microcode: AMD CPU family 0xf not supported
	* [ =A0 44.255721] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core=
 Processor 4200+ (2 cpu cores) (version 2.20.00)
	* [ =A0 44.255736] [Firmware Bug]: powernow-k8: No compatible ACPI _PS=
S objects found.
	* [ =A0 44.255736] [Firmware Bug]: powernow-k8: Try again with latest =
BIOS.

Coult it be related to the crashes , and should i update my bios ?

Regards.
Adko.

