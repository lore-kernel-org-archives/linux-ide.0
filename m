From: James Cloos <cloos@jhcloos.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Mon, 15 Nov 2010 14:40:24 -0500
Message-ID: <m3aalajry7.fsf@jhcloos.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com>
	<1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com>
	<m339r2lf9b.fsf@jhcloos.com>
	<1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com>
	<m3r5emjyv1.fsf@jhcloos.com> <4CE179B4.4090404@hardwarefreak.com>
	<m3fwv2ju9y.fsf@jhcloos.com> <4CE18B20.3050209@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:37194 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449Ab0KOT5K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2010 14:57:10 -0500
In-Reply-To: <4CE18B20.3050209@hardwarefreak.com> (Stan Hoeppner's message of
	"Mon, 15 Nov 2010 13:33:52 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

>>>>> "SH" == Stan Hoeppner <stan@hardwarefreak.com> writes:

>> *    Gen3 signaling speed (6.0Gb/s)

SH> That's what I was looking for--confirms it's def a 6Gb drive.

Yes.

And thanks for the reminder that hdparm -I is no longer a raw (and
wrong-endian) dump of the -i info.  I'd forgotten that.  It even
works on my usb-storage backup drive, where hdparm -i fails.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
