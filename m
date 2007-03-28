From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 27 Mar 2007 22:21:30 -0700 (PDT)
Message-ID: <20070328052130.94467.qmail@web809.biz.mail.mud.yahoo.com>
References: <20070328012012.72879.qmail@web802.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web809.biz.mail.mud.yahoo.com ([209.191.90.82]:34805 "HELO
	web809.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753942AbXC1FVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 01:21:31 -0400
In-Reply-To: <20070328012012.72879.qmail@web802.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Bob Stewart <bob@evoria.net> wrote:
> Tejun,
> 
> I did some more testing.  I limited the driver to PIO4 with the changes
> shown below.  I copied a 2.2GB gzipped file from a local disk and a 7.9GB
> iso file over my network onto the drive and then ran md5sum on both.  
> The sums were fine under PIO4.  It's slow as hell, but at least it worked.  
> If you have any suggestions for me to mess with in the driver, I'm up for it.

Just one more bit of info.  I ran an md5sum against the 2.2G file in WMDMA2
mode and actually got the right result once.  Doesn't this, along with the
PIO4 working fine, and the driver working fine under light load, imply that
there's a race being lost somewhere?

Bob
