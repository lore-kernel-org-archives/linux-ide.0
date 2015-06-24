From: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED, suspiciously on two
 different disks
Date: Wed, 24 Jun 2015 18:12:37 +0300
Message-ID: <20150624151237.pln3gsxeecqof3oj@m.safari.iki.fi>
References: <20150623190018.5wer6qdh467f5mud@m.safari.iki.fi>
 <558A8A61.7000302@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33527 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbbFXPMl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2015 11:12:41 -0400
Received: by wgck11 with SMTP id k11so39148132wgc.0
        for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2015 08:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558A8A61.7000302@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux ide Mailing List <linux-ide@vger.kernel.org>
Cc: Device-Mapper <dm-devel@redhat.com>

On Wed, Jun 24, 2015 at 11:45:53 +0100, Tim Small wrote:
> On 23/06/15 20:00, Sami Farin wrote:
> > SMART does not show problems and disks are working OK, but I have not
> > ran tests recently..
> 
> Are you running smartd, or using other monitoring tools to periodically
> run smartctl against these drives?  I've had problems with this sort of
> vintage of WD drives aborting other commands and resetting when making
> simultaneous SMART enquiries.
> 
> BTW, looks to me like the drives are on the Intel controller, is that
> correct?
> 
> Tim.
> 
> -- 

Not executing smartctl.  Maybe they are on Intel controller..

But, to reproduce:

dmsetup info backup596g-1 || cryptsetup --key-file ~/important/backup596g-1-key.bin open \
  /dev/disk/by-partlabel/backup596g-1 backup596g-1 && mount -t xfs -o noatime,nosuid,nodev \
  /dev/mapper/backup596g-1 /mnt/backup596g-1

dmsetup info backup596g-2 || cryptsetup --key-file ~/important/backup596g-2-key.bin open \
  /dev/disk/by-partlabel/backup596g-2 backup596g-2 && mount -t xfs -o noatime,nosuid,nodev \
  /dev/mapper/backup596g-2 /mnt/backup596g-2

(then I umount them as root and mount again as normal luser)

[safari@safari ~]$ mount /mnt/backup596g-1
[safari@safari ~]$ mount /mnt/backup596g-2
mount: /dev/mapper/backup596g-2: can't read superblock

here I run xfs_repair

[safari@safari ~]$ mount /mnt/backup596g-2
mount: /dev/mapper/backup596g-2: can't read superblock

here I run xfs_repair again

[safari@safari ~]$ umount /mnt/backup596g-2
umount: /mnt/backup596g-2: not mounted
[safari@safari ~]$ umount /mnt/backup596g-1

but if I umount backup596g-1 first, I can mount backup596g-2 without causing corruption?!?

[safari@safari ~]$ mount /mnt/backup596g-2
[safari@safari ~]$ mount /mnt/backup596g-1

Note: added Cc: dm-devel@redhat.com

-- 
