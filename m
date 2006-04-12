From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: libata-pata works on ICH4-M
Date: Wed, 12 Apr 2006 17:19:30 +0200
Message-ID: <20060412151930.GH4919@boogie.lpds.sztaki.hu>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750703AbWDLPTl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1144852703.1952.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Apr 12, 2006 at 03:38:22PM +0100, Alan Cox wrote:

> Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
> which are generic

# hdparm -M 128 /dev/sda

/dev/sda:
 setting acoustic management to 128
HDIO_GET_ACOUSTIC failed: Inappropriate ioctl for device
# blktool /dev/sda acoustic-mgmt 128
HDIO_SET_ACOUSTIC: Inappropriate ioctl for device

The world is still not perfect :-) Btw. it's kernel 2.6.16, ata_piix,
and a PATA drive. The new ata_piix now uses UDMA/100 while the old IDE
ICH driver always limited the first disk to UDMA/33 for no obvious
reason. So I'm quite happy with libata and can wait a little longer for
acoustic management to be implemented :-)

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
