From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_nv: convert to new EH and add hotplug support
Date: Wed, 14 Jun 2006 06:31:03 +0900
Message-ID: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.204]:22543 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932270AbWFMVay (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:54 -0400
Received: by nz-out-0102.google.com with SMTP id r28so1712702nza
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:30:54 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset converts sata_nv to new EH and adds hotplug support.
I've tested it on ASUS A8N-E (nForce4, CK804, 10de:0054), and
everything works fine.  However, the controller doesn't have
protection against data transfer hang (IORDY hang) and the machine
completely locks up if a device is removed during active data
transfer.  I don't think it can be worked around without using the
better interface (ADMA).

This patchset contains 7 patches.

#01-03: prep sata_nv
#04   : implement irq manipulation methods
#05   : improve irq handler
#06   : implement new EH
#07   : add hotplug support

This patchset is against

     upstream (aeb2ecd6096182cc080d37679080c0f088dcd4a4)

Thanks.

--
tejun


