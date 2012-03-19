From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: DMA doesn't work since "make ata port as parent device of scsi
 host"
Date: Mon, 19 Mar 2012 16:55:19 +0800
Message-ID: <1332147319.17875.38.camel@minggr>
References: <20120315014807.GA3051@alea.gnuu.de>
	 <1331776741.3436.33.camel@minggr> <1331781968.3436.43.camel@minggr>
	 <20120315074835.GA18295@alea.gnuu.de> <1331799598.3436.46.camel@minggr>
	 <20120315155924.GA6738@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30857 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758485Ab2CSIzV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2012 04:55:21 -0400
In-Reply-To: <20120315155924.GA6738@alea.gnuu.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Thu, 2012-03-15 at 16:59 +0100, J=C3=B6rg Sommer wrote:
> Lin Ming hat am Thu 15. Mar, 16:19 (+0800) geschrieben:
> > On Thu, 2012-03-15 at 08:48 +0100, J=C3=B6rg Sommer wrote:
> > > Lin Ming hat am Thu 15. Mar, 11:26 (+0800) geschrieben:
> > > > On Thu, 2012-03-15 at 09:59 +0800, Lin Ming wrote:
> > > > > On Thu, 2012-03-15 at 02:48 +0100, J=C3=B6rg Sommer wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > I'm getting these messages in a KVM virtualized host and th=
e access to
> > > > > > the disks is very slow. Using libata.dma=3D0 suppresses the=
 warnings, but
> > > > > > the disks are still slow.
> > > > >=20
> > > > > Hi J=C3=B6rg,
> > > > >=20
> > > > > Let me try to reproduce this issue first.
> > > >=20
> > > > I tried below commands on x86_32, but can't reproduce it.
> > > >=20
> > > > qemu-system-i386 -kernel /root/vmlinuz-3.3.0-rc7 -append "root=3D=
/dev/sda1
> > > > zcache" -hda /root/debian-32.img -hdb /root/data.img
> > > >=20
> > > > Maybe because i386 uses different ata controller than ppc(ata_p=
iix vs
> > > > pata-macio).
> > > >=20
> > > > I'll try qemu-system-ppc.
> > > >=20
> > > > Did you need to run some workload to trigger these warings?
> > > > Or did you get these warnings right after booting the VM?
> > >=20
> > > These warnings come up before =C2=BBINIT started=C2=AB. I don't h=
ave to do
> > > anything, just wait and see.
> > >=20
> > > # truncate -s100M /mnt/data/new
> > > # mke2fs -Fq /mnt/data/new
> > > # mount -o loop /mnt/data/new /mnt/other
> > > # cp --parents /bin/zsh-static /mnt/other/zsh
> > > # umount /mnt/other
> > > # qemu-system-ppc -enable-kvm -M mac99 -cpu G4 -k de -kernel /boo=
t/vmlinuz-3.3.0-rc5-04520-g8d233c0 -append 'root=3D/dev/sda ro console=3D=
ttyPZ0 init=3D/zsh' -hda /mnt/data/new
> > >=20
> > > I've uploaded my config and the kernel:
> > > http://alioth.debian.org/~jo-guest/config-3.3.0-rc5-04520-g8d233c=
0
> > > http://alioth.debian.org/~jo-guest/vmlinuz-3.3.0-rc5-04520-g8d233=
c0
> > >=20
> > > You have to switch to the serial console (Ctrl-Alt-3 or with -nog=
raphic
> > > Ctrl-a c). All kernel messages arrive there.
> > >=20
> > > > Would you please try to disable ata port runtime pm?
> > > > You can disable it by, for example,
> > >=20
> > > Is this also possible with a kernel parameter? It takes very long=
 until I
> > > get a shell prompt.
> >=20
> > No, but you can try below debug patch to disable port runtime pm.
> >=20
> > diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-tr=
ansport.c
> > index 74aaee3..8def3fc 100644
> > --- a/drivers/ata/libata-transport.c
> > +++ b/drivers/ata/libata-transport.c
> > @@ -293,7 +293,6 @@ int ata_tport_add(struct device *parent,
> > =20
> >  	device_enable_async_suspend(dev);
> >  	pm_runtime_set_active(dev);
> > -	pm_runtime_enable(dev);
>=20
> This patch doesn't change anything. The kernel still hangs. If you ha=
ve
> more patches or ideas, let me know.

I have reproduced this issue with qemu-system-pcc on x86.

Now I am debugging where the problem is.

Thanks,
Lin Ming

>=20
> Bye, J=C3=B6rg.


