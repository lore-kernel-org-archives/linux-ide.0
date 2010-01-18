From: Prashant Bhole <prashantsmailcenter@gmail.com>
Subject: sata_mv: wrong EDMA error cause when disk unplugged
Date: Mon, 18 Jan 2010 15:17:39 +0530
Message-ID: <9ff69a5d1001180147h643572e5m2e9db0361caeb334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:11523 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0ARJrm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 04:47:42 -0500
Received: by qw-out-2122.google.com with SMTP id 3so676938qwe.37
        for <linux-ide@vger.kernel.org>; Mon, 18 Jan 2010 01:47:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I am using latest marvell sata driver version 1.28 for marvell chip
88SX6081, I noticed following behavior:
1) When I plug a disk, EDMA error cause value is: 0x00000010. This is correct.
2) But when I unplug a disk, EDMA error cause value is: 0x00000020
(EDMA_ERR_SERR).
    which is wrong. It should be 0x00000008 (EDMA_ERR_DEV_DCON).

Please let me know if anybody experiencing the same problem.
-- 
~p~r~a~s~h~a~n~t~
