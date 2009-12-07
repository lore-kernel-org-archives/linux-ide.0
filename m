From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Mon, 7 Dec 2009 19:36:13 +0100
Message-ID: <200912071936.13575.bzolnier@gmail.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <200912071734.40916.bzolnier@gmail.com> <20091207175314.2ef480e2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:62755 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601AbZLGShL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 13:37:11 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1200685eyd.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 10:37:16 -0800 (PST)
In-Reply-To: <20091207175314.2ef480e2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

On Monday 07 December 2009 06:53:14 pm Alan Cox wrote:
> > Hmm.. why cannot ->qc_issue be used here (like in all other host drivers with
> > shared PIO/MWDMA timings) instead of some new 'clipping'?
> 
> Agreed it would probably work providing the 8bit timings are not affected
> by any of this.

If 8bit timings are a problem ->bmdma_{start,stop} approach can be used
instead (as done for similar reason in it821x IIRC).

> > ->qc_issue is the standard way to do it, takes care of more corner cases
> > and would also allow for faster MWDMA0 timings. 
> 
> All yours.. just revert the buggy patch and fix it. I won't have time to
> look at it until next year and I freecycled all my SiS hardware some time
> ago.

Thank you but this is quite a bit of work and I'm not interested personally.

--
Bartlomiej Zolnierkiewicz
