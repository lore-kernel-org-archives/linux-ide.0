From: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 16:46:10 +0200
Message-ID: <20070930164610.20818867@localhost>
References: <20070930160548.235be972@localhost>
	<20070930152908.1f58d39d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758182AbXI3Oq1@vger.kernel.org>
In-Reply-To: <20070930152908.1f58d39d@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 30 Sep 2007 15:29:08 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Seagate Barracuda ST380817AS has troubles with NCQ. For example,
> > unpacking a tarball on an XFS filesystem gives this:
> > 
> > ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> > ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
> >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)  
> 
> What makes you sure that is an NCQ problem ?

It goes away with:
echo 1 > /sys/block/sda/device/queue_depth

I have this problem only with XFS, and even with XFS it goes away
mounting with "nobarrier"...

-- 
	Paolo Ornati
	Linux 2.6.23-rc8-ga64314e6-dirty on x86_64
