From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Tue, 11 Mar 2008 11:11:33 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803111058090.5503@axis700.grange>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
 <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange>
 <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange>
 <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange>
 <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange>
 <47D485EC.1060103@gmail.com> <Pine.LNX.4.64.0803100821440.3948@axis700.grange>
 <47D53231.30107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755902AbYCKKLi@vger.kernel.org>
In-Reply-To: <47D53231.30107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 10 Mar 2008, Tejun Heo wrote:

> Guennadi Liakhovetski wrote:
> > On Mon, 10 Mar 2008, Tejun Heo wrote:
> > 
> >>> Yctually it was 2.6.24 before, rebuilt 2.6.25-rc4, booted as above, it did 
> >>> say:
> >>>
> >>> ata4: FORCE: PHY spd limit set to 1.5Gbps
> >>>
> >>> but hot-plugging the drive still took 50 seconds to recover.
> >> How about cold plugging?
> > 
> > Same.
> 
> Does the attached patch help?

Well, I am not sure, whether it helps, tried booting with both 1.5Gbps and 
this patch, it recovers now within 30 sec in both cold- and hot-plug 
cases. To really state, that it has improved from about 55 sec down to 30 
sec one would need more testing. Is this the kind of improvement you 
expected? Can it be, that with this hardware it just cannot get better? 
Remember, the disk is an external eSATA enclosure with a (relatively new) 
PATA disk inside.

Well, at least the hotplug case did recover faster this time. Not sure 
about coldplug, because in the logs all kernel messages come with the 
same time and I don't have printk timestamp on.

Thanks
Guennadi
---
Guennadi Liakhovetski
