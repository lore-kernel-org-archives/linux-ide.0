From: Ken Moffat <ken@kenmoffat.uklinux.net>
Subject: Stupid question about DMA on strange hardware
Date: Tue, 21 Dec 2004 22:59:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.58.0412212239480.6937@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:3978
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261603AbULUW72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 17:59:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: ken@kenmoffat.uklinux.net

Hi,

 please cc me on any replies, I'm not subscribed here.

Those with an intolerance of broken hardware should look away now.  I'm
trying to use an AmigaOne / MAI Teron mobo from Eyetech, this has a
number of "issues".  The one I'm concerned with here is cache coherency=
=2E
This board uses the 'Articia S' chipset which apparently has a floating
DMA buffer. ( I don't have any documentation, and neither MAI nor
Eyetech respond to my mail.)  When Bill Mueller was at MAI he produced
the following hack (edited) with a similar hack for ide_dma_write


int __ide_dma_read (ide_drive_t *drive /*, struct request *rq */)
{
 [snip]
	unsigned int count	=3D 0;
 [snip]
	if (!(count =3D ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE)))
		/* try PIO instead of DMA */
		return 1;
#ifdef CONFIG_AMIGAONE   /* MAI: make sure RAM's copy of dma table is u=
p to date */
	flush_dcache_range (hwif->dmatable_cpu, hwif->dmatable_cpu + (count <<=
 3));
#endif


 Clearly this isn't suitable for mainline, but my first priority is to
get 2.6 kernels running reliably before I ask for the code to be
reviewed.  I got 2.6.9 running [1] and thought at first that an add-on
sii controller had solved the problem, but I've now accepted the
problems are still there.  Copy a tree to another partition using tar |
tar and maybe 1 or 2 files out of 10000 are corrupt.  Use scp to copy
_big_ files (> 512MB) and sometimes the md5sum is wrong, but rerunning
md5sum will then produce the correct result.

 Looking at Bill's hack, the length of the cache being flushed is alway=
s
(0 << 3) bytes, because ide_build_dmatable returns 0 or 1 ?  Or have I
added 2 + 2 and got 5, again ?  Can anyone give me some pointers to
determine the length of the buffers used in __ide_dma_read and
__ide_dma_write, please ?

TIA,

Ken

1. patches at http://homepage.ntlworld.com/zarniwhoop/kernel/kernel.htm=
l
--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce

