From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 27 Mar 2007 18:20:12 -0700 (PDT)
Message-ID: <20070328012012.72879.qmail@web802.biz.mail.mud.yahoo.com>
References: <4604D564.9010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web802.biz.mail.mud.yahoo.com ([209.191.90.75]:28249 "HELO
	web802.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965574AbXC1BUO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 21:20:14 -0400
In-Reply-To: <4604D564.9010806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> 
> My bet is on broken driver.  sunix driver doesn't seem like it was 
> written carefully.  Anyways, thanks for testing.  It seems we'll either 
> have to implement adma mode.  I'll mark the driver broken for 2.6.21. 
> Thanks.

Tejun,

I did some more testing.  I limited the driver to PIO4 with the changes
shown below.  I copied a 2.2GB gzipped file from a local disk and a 7.9GB
iso file over my network onto the drive and then ran md5sum on both.  
The sums were fine under PIO4.  It's slow as hell, but at least it worked.  
If you have any suggestions for me to mess with in the driver, I'm up for it.

By the way, I'm now running 2.6.20.3 for my testing.  I had to wait to
upgrade till madwifi was ready.

        .pio_mask                  = 0x1f, /* pio0-4 */
        .mwdma_mask           = 0x00, /* mwdma0-2 */
        .udma_mask              = 0x00, /* udma0-6 */

Bob
