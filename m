From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: IDENTIFY DEVICE not working any more?
Date: Mon, 15 Aug 2005 11:07:25 +0200
Message-ID: <43005B4D.1090801@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vvv.conterra.de ([212.124.44.162]:64671 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S932317AbVHOJHe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2005 05:07:34 -0400
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id 170461C88E6
	for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2005 11:07:29 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>

I used smartmontools for sata devices quite successfully awhile.
Since 2.6.12.2 however, I get an ioerror on "DENTIFY DEVICE"
errno=3D25 [Inappropriate ioctl for device] and smartctl gives up.

So, is the prelimnary SMART support over ATA commands broken again
and I have to wait patiently until smart over SCSI commands will
work some day.

I feel like flying blind with my 3.5TB SATA data without SMART....

Dieter.
--=20
Dieter St=FCken, con terra GmbH, M=FCnster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
