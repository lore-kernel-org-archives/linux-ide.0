From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 09:34:46 +0900
Message-ID: <4B96E926.90400@kernel.org>
References: <4B947393.2050002@kernel.org>	<1268031640.4389.11.camel@mulgrave.site>	<yq1vdd6bzgz.fsf@sermon.lab.mkp.net>	<yq1mxyibz7o.fsf@sermon.lab.mkp.net> <yq1iq96bz22.fsf@sermon.lab.mkp.net> <4B9546E6.6050006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B9546E6.6050006@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

Hello,

On 03/09/2010 03:50 AM, H. Peter Anvin wrote:
> Well, apparently Western Digital are looking at it for USB drives due to
> XP compatibility requirements -- those presumably are ATA internally and
> use a USB-ATA bridge.

This should work right now as long as the bridge chip doesn't screw
up, which we can't do much about anyway.  USB is used as SCSI
transport and SCSI layer has been working fine with devices with
differing sector sizes for quite some time.

> On the flipside, though, there really is very little net benefit to 4K
> as opposed to 512 byte logical sectors: the additional protocol overhead
> is relatively minimal, and as long as writes are aligned full blocks,
> there shouldn't be any additional overhead on either the OS or the drive
> side.  On the plus side, you get full compatibility with the existing
> software stack.  The equation really seems rather simple.

Yeap, for addressing, whether 9 bit is shifted or 12 doesn't really
matter.  That's only 8 times difference which may be breached in
probably under three years.  If the current 48 bit addressing limit is
reached, we would be far better off introducing 64 or 128 bit
addressing.  That was the reason why I thought that I would never see
an ATA disk w/ 4KiB logical sector and got pretty surprised that it
was being considered for XP compatibility where 3 year offset could be
pretty meaningful.

Thanks.

-- 
tejun
