From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: sata_mv: module reloading doesn't work
Date: Sun, 2 Apr 2006 11:59:45 -0600
Message-ID: <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com>
References: <20060402155647.GB20270@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932402AbWDBR7r@vger.kernel.org>
In-Reply-To: <20060402155647.GB20270@localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 4/2/06, Dan Aloni <da-x@monatomic.org> wrote:
> Hello,
>
> I'm testing the sata_mv driver to see whether reloading (rmmod
> - insmod) works, and it seems something is broken there. The
> first insmod goes okay - however all the insmods that follow
> emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady
> SeekComplete } from all the drives.

More to Jeff/Mark etc... wouldn't this be expected?  0x50/0x01 is the
contents of a reset signature FIS.  If the module was removed, and
upon insmod the bus came back up, the drive would complete ASR or
COMRESET processing and post a signature FIS.  Is the phy disabled
when sata_mv is removed?
