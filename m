From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] mg_disk: fix dependency on libata
Date: Sun, 26 Apr 2009 11:53:47 +0200
Message-ID: <200904261153.48230.bzolnier@gmail.com>
References: <200904251509.11912.bzolnier@gmail.com> <49F3DD4F.6080804@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752577AbZDZJtj@vger.kernel.org>
In-Reply-To: <49F3DD4F.6080804@garzik.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: unsik Kim <donari75@gmail.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sunday 26 April 2009 06:04:31 Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Add local copies of ata_id_string() and ata_id_c_string() to mg_disk
> > so there is no need for the driver to depend on ATA and SCSI.
> > 
> > Cc: unsik Kim <donari75@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/block/Kconfig   |    2 +-
> >  drivers/block/mg_disk.c |   44 ++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 41 insertions(+), 5 deletions(-)
> 
> Please CC these types of patches to linux-ide also, as it is of interest 
> to Linux ATA folks...  thanks.

Aye, aye.  I usually do... ;)
