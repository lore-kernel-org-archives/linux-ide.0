From: Marc D Ronell <mronell@alumni.upenn.edu>
Subject: Re: Kernel config question on Hitachi HTS541080G9SA00, Intel 945pm
 Express, SATA drive on Dell e1505 Inspiron
Date: Sat, 18 Nov 2006 21:47:51 -0500
Message-ID: <87bqn4cfu0.fsf@corps.glidepath.invalid>
References: <873b8mrcmm.fsf@corps.glidepath.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46531 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1755538AbWKSCvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Nov 2006 21:51:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Glck4-0005uI-Mn
	for linux-ide@vger.kernel.org; Sun, 19 Nov 2006 03:49:17 +0100
Received: from pool-71-162-110-87.bstnma.east.verizon.net ([71.162.110.87])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 19 Nov 2006 03:49:12 +0100
Received: from mronell by pool-71-162-110-87.bstnma.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 19 Nov 2006 03:49:12 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Marc D Ronell <mronell@alumni.upenn.edu> writes:

> Hi,
>
> Is  it currently  possible  to configure  a linux  kernel to  directly
> (without an  initrd image) boot  from a Hitachi  HTS541080G9SA00 drive
> which I believe is a SATA-I serial ATA drive.  I believe my machine is
> using an Intel 945pm chipset to drive the hard drive.  
>
> I think  the setup should  use the AHCI  driver in libata, but  I have
> tried  a  variety  of  permutations  with no  success  so  far.  (like
> 2.6.19-rcx)
>
> The  box currently boots  a Debian  Sarge distribution  (kernel 2.6.8)
> using an hda ide disk configuration (as opposed to an sda), but I need
> a more recent kernel version to get drivers for other devices working.
>
> Thanks for any help and suggestions,
>
> Marc

In  case  anyone else  is  looking for  this  info,  the Debian  Sarge
distribution sets up the disk as and ide (hda) drive and I am not sure
of a good  upgrade path from there.  Instead, do  a network install of
Debian Etch, the Testing distribution at this time, which then sets up
the  drive as  SCSI (sda)  and does  (hopefully) use  libata.  Further
kernel updates should be easier from that point.

This concern will  no longer be an issue when  Etch becomes the stable
distribution which is expected to occur relatively soon.

Marc

-- 


