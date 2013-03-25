From: Ronald <ronald645@gmail.com>
Subject: RE: ata: HDIO_DRIVE_* ioctl() Linux 3.9 regression
Date: Mon, 25 Mar 2013 18:26:50 +0100
Message-ID: <CAF1_xX3Ox6=fKomLpvrDxMZ9edB0=2SrVDDPrU0nivD_Yj6KHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:36550 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735Ab3CYR0v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Mar 2013 13:26:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: krzysiek@podlesie.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

In reply to [1]: I have the same issue. Git bisect took 50+ rebuilds xD

Smartd does not work anymore since 84a9a8cd9 ([libata] Set proper SK
when CK_COND is set.).

I hope I'm not stepping on anyone's toe's by chosing the same title.
I'm not subscribed to this list.

Just wanted to add a 'me2'

[1] http://www.spinics.net/lists/linux-ide/msg45268.html
