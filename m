From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement per-dev xfer masks
Date: Sun, 12 Mar 2006 16:02:35 +0900
Message-ID: <11421469551948-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:63647 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751479AbWCLHCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 02:02:41 -0500
Received: by zproxy.gmail.com with SMTP id 13so1095013nzn
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 23:02:40 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset adds per-dev pio, mwdma and udma_mask.  Because
port-wide xfer_mask is currently used, this patch does not change any
behavior.  Per-dev xfer masks will also be used by EH to slow down
devices suffering frequent transmission errors.

I marked with comment where the mode filtering for low level drivers
should be done but I'm not sure how the interface should look like.
->pre_set_mode(ap) is okay but then the LLDD should iterate over all
devices.  Maybe ->pre_set_mode(ap, dev) or ->filter_xfer_mask(ap, dev)?

The patchset is against the current #upstream[1].

Thanks.

--
tejun

[1] 418dc1f5a805822fcf1118804ddc689a4156db4a


