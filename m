From: John Yau <jyau.linux@gmail.com>
Subject: Silicon Image Bios Detection
Date: Thu, 17 Mar 2005 00:24:35 -0500
Message-ID: <111a57ba05031621245bb44626@mail.gmail.com>
Reply-To: John Yau <jyau.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.207]:40237 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261834AbVCQFYg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2005 00:24:36 -0500
Received: by wproxy.gmail.com with SMTP id 37so144050wra
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2005 21:24:35 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

Recently via a RAID bios upgrade to 4.3.53 I got my Seagate drive to
play nicely with my Silicon Image 3512 chip with the black list in
sata_sil.c disabled.  I was looking into producing a patch for
sata_sil.c that detected the bios version number and applied the MOD15
write work around selectively.  Anyone have any leads on how I can get
the version number of the Silicon Image RAID bios?


John Yau
