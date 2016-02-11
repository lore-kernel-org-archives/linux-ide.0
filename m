From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: compat_hdio_ioctl() question
Date: Thu, 11 Feb 2016 11:31:02 +0100
Message-ID: <3003814.ujQ3HzEqZk@wuerfel>
References: <9d00833b817045b3b1ddf103711b36f7@seaexchmbx01.olympus.F5Net.com> <6448885.q0MBzedQ1Q@wuerfel> <1455170952599.95756@f5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56352 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcBKKbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Feb 2016 05:31:20 -0500
In-Reply-To: <1455170952599.95756@f5.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soohoon Lee <Soohoon.Lee@f5.com>
Cc: Mark Lord <mlord@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 11 February 2016 06:09:13 Soohoon Lee wrote:
> 
> thanks for your reply.
> It works as expected.
> is it going to be submitted?

Yes, I can submit that as a proper patch, thanks for testing!

	Arnd

> On Tuesday 09 February 2016 17:38:56 Soohoon Lee wrote:
> >
> > Hi,
> > I found that you are the author of this code.
> 
> I don't think I am, but that's fine. I think I just moved the code
> from one place to another.
> 
> > So please let me ask a question.
> 
> I hope it's ok for you to Cc this to a linux-ide and linux-kernel.
> 
> > +static int compat_hdio_ioctl(struct inode *inode, struct file *file,
> > +                      struct gendisk *disk, unsigned int cmd, unsigned long arg)
> > +{
> > +          mm_segment_t old_fs = get_fs();
> > +          unsigned long kval;
> > +          unsigned int __user *uvp;
> > +          int error;
> > +
> > +          set_fs(KERNEL_DS);
> > +          error = blkdev_driver_ioctl(inode, file, disk,
> > +                                              cmd, (unsigned long)(&kval));
> > +          set_fs(old_fs);
> > +
> > +          if (error == 0) {
> > +                      uvp = compat_ptr(arg);
> > +                      if (put_user(kval, uvp))
> > +                                  error = -EFAULT;
> > +          }
> > +          return error;
> > +}
> >
> >
> > kval is local so it has random values.
> > But one of syscall like HDIO_GET_32BIT/ATA_IOC_GET_IO32 only updates one byte so if kval has 0xaaaaaaaa and ioctl() updated one byte then it becomes 0xaaaaaa01.
> > And put_user() writes 4bytes.
> 
> This actually looks like a security bug, as we are not supposed to leak
> kernel stack data.
> 
> > And I'm having problem with hdparm.
> >
> > void process_dev (char *devname)
> > {
> >         static long parm, multcount;   <-- parm is static so it's zero
> > .....
> >         if (do_defaults || get_io32bit) {
> >                 if (0 == ioctl(fd, HDIO_GET_32BIT, &parm)) {
> >
> >
> > so parm becomes 0xaaaaaa01 and reports wrong mode.
> >
> > If hdparm is 64bit then 64bit syscall will update 1byte of parm so it becomes 0x1.
> >
> > What would be a good fix?
> >
> > -       Modify hdparm to look at only 1byte
> >
> > -       Initialize kval to zero
> >
> > -       Copy parm to kval to simulate 64bit syscall more accurately.
> >
> 
> Out of these, the last one is the best. My preferred solution however would
> be to move the handling of the ioctls in question (and maybe some others
> while we're at it) into the driver that provides the call in the first place.
> 
> There is another problem: I don't think the code ever worked on big-endian
> machines:
> 
>         case ATA_IOC_GET_IO32:
>                 spin_lock_irqsave(ap->lock, flags);
>                 val = ata_ioc32(ap);
>                 spin_unlock_irqrestore(ap->lock, flags);
>                 if (copy_to_user(arg, &val, 1))
>                         return -EFAULT;
>                 return 0;
> 
> 
> On little-endian machines, this copies the low byte of the 'int val'
> variable, while on big-endian machines, it copies the high byte that
> is always zero. In the hdparm source code, this gets copied into a
> 'static long parm' variable, which in turn means that when we first read
> one 32-bit setting and then call ATA_IOC_GET_IO32 as part of the same
> hdparm command line, the upper 24 or 56 bits (out of 32 or 64 respectively)
> still contain the previous result.
> 
> From what I can tell, the behavior of hdparm matches the behavior of
> the old drivers/ide/ subsystem, and the compat ioctl handling works with
> that, but the ioctls in drivers/ata/ suffer from both the compat_ioctl
> problem and the problem on big-endian systems.
> 
> Both problems date back to the original commit that added ioctl support
> in libata back in 2004 (linux-2.6.8).
> Can you try out the patch below to see if that makes it work? If it
> does, we probably want something like this backported to all stable
> kernels, but I think we probably also want to clean this up a bit
> more to avoid the 'get_fs()/set_fs()' hack in block/compat_ioctl.c.
> 
>         Arnd
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7e959f90c020..e417e1a1d02c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -675,19 +675,18 @@ static int ata_ioc32(struct ata_port *ap)
>  int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
>                      int cmd, void __user *arg)
>  {
> -       int val = -EINVAL, rc = -EINVAL;
> +       unsigned long val;
> +       int rc = -EINVAL;
>         unsigned long flags;
> 
>         switch (cmd) {
> -       case ATA_IOC_GET_IO32:
> +       case HDIO_GET_32BIT:
>                 spin_lock_irqsave(ap->lock, flags);
>                 val = ata_ioc32(ap);
>                 spin_unlock_irqrestore(ap->lock, flags);
> -               if (copy_to_user(arg, &val, 1))
> -                       return -EFAULT;
> -               return 0;
> +               return put_user(val, (unsigned long __user *)arg);
> 
> -       case ATA_IOC_SET_IO32:
> +       case HDIO_SET_32BIT:
>                 val = (unsigned long) arg;
>                 rc = 0;
>                 spin_lock_irqsave(ap->lock, flags);
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index d2992bfa1706..c1a2f345cbe6 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -487,8 +487,8 @@ enum ata_tf_protocols {
>  };
> 
>  enum ata_ioctls {
> -       ATA_IOC_GET_IO32        = 0x309,
> -       ATA_IOC_SET_IO32        = 0x324,
> +       ATA_IOC_GET_IO32        = 0x309, /* HDIO_GET_32BIT */
> +       ATA_IOC_SET_IO32        = 0x324, /* HDIO_SET_32BIT */
>  };
> 
>  /* core structures */
> 
> 

