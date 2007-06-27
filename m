From: "Thomas Tsai" <bthomas.tsai@gmail.com>
Subject: Failed to IDENTIFY SATA harddrive on sata_sil24
Date: Wed, 27 Jun 2007 23:14:14 +0800
Message-ID: <6a3d41200706270814o7675909dtbdafe4a4fa68943c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:1812 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbXF0POP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 11:14:15 -0400
Received: by wr-out-0506.google.com with SMTP id 76so154771wra
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 08:14:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Does anyone familiar with SiliconImage 3132 SATA controller?
I'm running siliconimage 3132 as e-Sata controller on my ARM-based board.
My kernel version is 2.6.18.6. I built libata and sata_sil24 as kernel module.
After I insert libata and sata_sil24 module, and plug external
harddrive via e-Sata.
sata_sil24.c can detect phy changed, and found a ATA device.
And then it will issue IDENTIFY(0xec) command but time out to get
command completion.
And Sil3132 seems dead or enter into an unknown state.Since it will
not issue any interrupts even I remove and replug the e-Sata cable.
Does anyone have experienced this situation, or any suggestion.
Thanks.

bthomastsai
