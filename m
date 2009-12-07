From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Mon, 7 Dec 2009 16:11:09 +0100
Message-ID: <200912071611.09074.bzolnier@gmail.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <4B1D0268.4090508@ru.mvista.com> <200912071605.28364.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:5680 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935225AbZLGPL6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 10:11:58 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1313595fgg.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 07:12:03 -0800 (PST)
In-Reply-To: <200912071605.28364.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

On Monday 07 December 2009 04:05:28 pm Bartlomiej Zolnierkiewicz wrote:

> array access for the common-case of dev->pio_mode == 4).

s/4/XFER_PIO_4/

[ Looking at the buggy code is bad for your health. ]
