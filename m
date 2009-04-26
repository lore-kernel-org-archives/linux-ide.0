From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] mg_disk: fix dependency on libata
Date: Sun, 26 Apr 2009 11:39:33 +0200
Message-ID: <200904261139.33492.bzolnier@gmail.com>
References: <200904251509.11912.bzolnier@gmail.com> <49F3D994.7020304@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754614AbZDZJtY@vger.kernel.org>
In-Reply-To: <49F3D994.7020304@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: unsik Kim <donari75@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

On Sunday 26 April 2009 05:48:36 Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Add local copies of ata_id_string() and ata_id_c_string() to mg_disk
> > so there is no need for the driver to depend on ATA and SCSI.
> > 
> > Cc: unsik Kim <donari75@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Ah.. right, that's a rather large dependency to pull in just for the
> string functions.  Yeah, I think it would be better to keep local
> copy at elast for now.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> (Continuing from the previous message :-) or do you want me to fold
> these patches into my series and push them through Jens with other
> patches?

Please include them in your series if possible.  Thanks!
