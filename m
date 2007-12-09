From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: WDC WD1600BEVS-2 on NCQ blacklist
Date: Sun, 09 Dec 2007 18:17:26 +0300
Message-ID: <475C0706.7090709@msgid.tls.msk.ru>
References: <475BC8D7.5070407@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:20117 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXLIPR2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Dec 2007 10:17:28 -0500
In-Reply-To: <475BC8D7.5070407@harddisk.is-a-geek.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Marco Schuster wrote:
> Hi all,
> 
> I use a WDC WD1600BEVS-2 SATA drive (160GB).
> The controller is a standard Intel ICH8 chipset.
> During high disk load (fsck, large file copies) the system or the
> process (mostly both) lock up and resume some secs later. In dmesg for
> every of those breaks this appears:
> 
> ata3.00: exception Emask 0x2 SAct 0x8001 SErr 0x0 action 0x2 frozen
> ata3.00: spurious completions during NCQ issue=0x0 SAct=0x8001 FIS=004040a1:00004000
[]
> Someone other than me also has this problem with this disk, see
> http://marc.info/?l=linux-kernel&m=118789093418142&w=2 for details.
> xingu on freenode/#debian suggested me to do echo 1 >
> /sys/block/sdX/device/queue_depth, which solved these problems for one
> session and to email you to put this drive/controller combo on the NCQ
> blacklist.

Marco, please see

  http://marc.info/?l=linux-ide&m=119707355016060&w=2

before adding more entries to the blacklist...

/mjt
