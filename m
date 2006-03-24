From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement per-dev xfer masks, take#2
Date: Fri, 24 Mar 2006 14:07:49 +0900
Message-ID: <11431768691564-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:4767 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932401AbWCXFHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 00:07:55 -0500
Received: by wproxy.gmail.com with SMTP id 58so842709wri
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 21:07:54 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of add-per-dev-pio-mwdma-udma_mask patchset.
Changes from the last take[1] are...

* %02 implement-ata_dev_init patch is removed and %03 is updated
  accordingly.

The patchset is against the current #upstream[2].

I tried to think of a simple way to use single xfer_mask for all
masks, but couldn't.  The problem is that the masks are used in
several different ways affecting specific parts of the mask.  When
composing transfer xfer_mask, it's best if they can be simply bit-wise
or'ed, but we can't use the same mask values when trying to limit
trasnfer mode because bits for other transfer modes will be turned
off.  We're gonna have to use different masks for different purposes
or use mask manipulating wrappers.

So, for the time being, LLDD's are left with three separate masks.  If
anyone can think of a pretty way to convert them, please, go ahead.
We also need to sort out transfer mask constants, the naming is
somewhat inconsistent.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8705
[2] 2cc432eed0491df66e14b578139bba2c75fb3f9a


