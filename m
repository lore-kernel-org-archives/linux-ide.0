From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Thu, 14 Feb 2008 14:56:55 +0200
Message-ID: <c70ff3ad0802140456v50e0b0faj2c2b1f7d11c60fc5@mail.gmail.com>
References: <12029369502995-git-send-email-saeed@marvell.com>
	 <12029369532977-git-send-email-saeed@marvell.com>
	 <47B345A6.9000605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:30746 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbYBNM4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 07:56:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so573633wah.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 04:56:55 -0800 (PST)
In-Reply-To: <47B345A6.9000605@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, nico@cam.org, byron.bbradley@gmail.com

>  > this will fix crash bug when doing rmmod to the driver, this is because the
>  > port_stop function get called later and it could access the device's registers.
>  >
>
>  Where does the iounmap() now get done instead of that place?
>
nowhere, the /proc/iomem still shows that sata_mv uses io mempry after
the rrmod, but when I re-load the driver, I can see it reuses the same
io address range. so it doesn't waste io mem  resources.

saeed
