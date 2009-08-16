From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: ata_tf_read_block() question
Date: Sun, 16 Aug 2009 18:33:55 +0900 (JST)
Message-ID: <20090816.183355.89035427.anemo@mba.ocn.ne.jp>
References: <20090815.224843.240484147.anemo@mba.ocn.ne.jp>
	<4A876BC3.3020407@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.28.14.163]:54917 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbZHPJdz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Aug 2009 05:33:55 -0400
In-Reply-To: <4A876BC3.3020407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 16 Aug 2009 11:15:31 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > It seems inconsistent.  The correct calculation is:
> > 	block = (cyl * dev->heads + head) * dev->sectors + sect - 1;
> > isn't it?
> 
> Yes, indeed.
> 
> > I don't have any real problem.  Just noticed by code reading.
> 
> ata_tf_read_block() currently is used only when reporting failed block
> address to upper layer so off-by-one bug there wouldn't be too
> visible, especially for the venerable CHS addressing.

Thank you for checking.

> Care to submit a patch w/ warning message and capping for sect == 0
> case?

Well, I expect fix by you (or other libata hackers) since I think you
can write better warning message and changelog than me ;)

---
Atsushi Nemoto
