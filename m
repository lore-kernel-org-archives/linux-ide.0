From: "Rupjyoti Sarmah" <rsarmah@amcc.com>
Subject: RE: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission : 01>
Date: Tue, 16 Mar 2010 22:55:51 -0700
Message-ID: <AC311A8E81420D4EBC1F26E6479848FE065B7F54@SDCEXCHANGE01.ad.amcc.com>
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com><AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com> <20100317155959.208eea21.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100317155959.208eea21.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Stephen,

Thanks for your suggestions. 
I used git-send-email earlier and emails never appeared in the archive.
This time I sent through outlook & the message appeared in the archive.
Looks like outlook did that word wrap.

I am not sure why the emails from the git-send-email did not get
delivered. At the time of sending I got message delivered  logs.

Regards,
Rupjyoti Sarmah




-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au] 
Sent: Wednesday, March 17, 2010 10:30 AM
To: Rupjyoti Sarmah
Cc: linux-ide@vger.kernel.org; Jeff Garzik; Rupjyoti Sarmah;
linuxppc-dev@ozlabs.org; Rupjyoti Sarmah; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> <
resubmission : 01>

Hi,

Just a couple of quick points ...

On Tue, 16 Mar 2010 21:23:16 -0700 "Rupjyoti Sarmah" <rsarmah@amcc.com>
wrote:
>
> This patch enables the on-chip DWC SATA controller of the AppliedMicro

> processor 460EX.
> 
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> ,Mark 
> Miesfeld <mmiesfeld@appliedmicro.com>, Prodyut Hazarika 
> <phazarika@appliedmicro.com>

Please put one Signed-off-by line per person.

> ---
>  arch/powerpc/boot/dts/canyonlands.dts |    8 +
>  drivers/ata/Kconfig                   |    9 +
>  drivers/ata/Makefile                  |    1 +
>  drivers/ata/sata_dwc.c                | 1965
> +++++++++++++++++++++++++++++++++
>  4 files changed, 1983 insertions(+), 0 deletions(-)  create mode 
> 100644 drivers/ata/sata_dwc.c

This patch has been word wrapped by your mailer (or something along the
way).
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
