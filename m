From: "Daniela Engert" <dani@ngrt.de>
Subject: Re: sata_sil problem / oops
Date: Thu, 02 Jun 2005 19:24:57 +0200 (CDT)
Message-ID: <200506021847.j52IlYi28562@epz01.nefonline.de>
References: <20050602100358.GA28855@suse.de>
Reply-To: "Daniela Engert" <dani@ngrt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from epz01.nefonline.de ([212.204.66.1]:40119 "EHLO
	epz01.nefonline.de") by vger.kernel.org with ESMTP id S261231AbVFBSrg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Jun 2005 14:47:36 -0400
Received: from localhost (DSL01.212.114.230.14.NEFkom.net [212.114.230.14])
	by epz01.nefonline.de (NEFkom Mailservice) with SMTP id j52IlYi28562
	for <linux-ide@vger.kernel.org>; Thu, 2 Jun 2005 20:47:34 +0200
In-Reply-To: <20050602100358.GA28855@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 2 Jun 2005 12:03:58 +0200, Marcus Meissner wrote:

>We see a problem in the sata_sil driver. The code looks like this:
>
>	 cls=sil_get_device_cache_line(pdev);
>	 cls >>= 3;
>	 cls++;  /* cls = (line_size/8)+1 */
>	 writeb(cls, mmio_base + SIL_FIFO_R0);
>	 writeb(cls, mmio_base + SIL_FIFO_W0);
>	 writeb(cls, mmio_base + SIL_FIFO_R1);
>	 writeb(cls, mmio_base + SIL_FIFO_W2);
>
>We have a device where mmio_base is only 0x200 byte long, so
>the access to SIL_FIFO_W2 (offset 0x241) causes an Oops.
>
>- Should it perhaps be W1 instead of W2?
>- If not, does it need a range check?

My OS/2 driver and the Windows driver write to the following locations:

SiI3112: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45
SiI3114: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45,
	 BAR5+0x240, BAR5+0x241, BAR5+0x244, BAR5+0x245

Ciao,
  Dani


