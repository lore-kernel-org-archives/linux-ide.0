From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: libata no-dma pata driver
Date: Mon, 21 Aug 2006 16:38:21 +0100
Message-ID: <7ac1e90c0608210838l324e7f45lce3125c0cf4e9933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:13898 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751826AbWHUPiW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Aug 2006 11:38:22 -0400
Received: by wr-out-0506.google.com with SMTP id i21so273069wra
        for <linux-ide@vger.kernel.org>; Mon, 21 Aug 2006 08:38:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am writing a libata-based ide driver for a compact flash interface
based on the ata_generic.c using 2.6.18-rc4-mm1.

The device doesn't support dma, so I need to implement a pio-only
driver. However ata_device_add() makes various calls to dma-related
functions such as ata_bmdma_*, ata_port_start(),
generic_error_handler() etc.

Could you give a bit of advice on what sort of ata_port_info fields
and ata_port_operations to use for no-dma operation? Is it readily
possible in the current implementation, i.e. are there any example
pio-only drivers?

Many thanks,
Bahadir
