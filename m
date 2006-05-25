From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Thu, 25 May 2006 23:29:45 +0300
Message-ID: <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com>
	 <89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>
	 <44753B78.4090802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:17864 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030403AbWEYU3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 May 2006 16:29:45 -0400
Received: by wr-out-0506.google.com with SMTP id i7so240604wra
        for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 13:29:45 -0700 (PDT)
In-Reply-To: <44753B78.4090802@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?ISO-8859-1?Q?J=E9r=F4me_VUARAND?= <jerome.vuarand@gmail.com>, linux-ide@vger.kernel.org

Hi,
       I think the 6th port is for the SEMB(Sata Enclosure Management
Bridge) device, this device reportssignature with lbam=3D0x3c and lbah
0xc3, but the linux classifies it as a disk:

  if (((tf->lbam =3D=3D 0) && (tf->lbah =3D=3D 0)) ||
  ((tf->lbam =3D=3D 0x3c) && (tf->lbah =3D=3D 0xc3))) {
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
DPRINTK("found ATA device by sig\n");
 return ATA_DEV_ATA;

Can you print the signature of the device on that port?
Anyway, the 0x3C, 0xC3 signature should be classifies as a SEMB device
and not a disk according to the SATA standard.

saeed

On 5/25/06, Tejun Heo <htejun@gmail.com> wrote:
> J=E9r=F4me VUARAND wrote:
> > I just realised after the mail that the driver was really thinking
> > there are 6 ports on the pm, since it's testing ata3.05 and ata4.05=
=2E
> > These don't exist and generate errors. There's a bug somewhere and
> > here is a workaround I made quickly to have correct enumeration
> > behaviour (I hope no automatic process parse mails on this mailing
> > list for patches, coz this one is not really clean) :
>
> Can you try the attached patch?
>
> --
> tejun
>
>
> diff --git a/drivers/scsi/libata-pm.c b/drivers/scsi/libata-pm.c
> index 002d8b2..7a56ab7 100644
> --- a/drivers/scsi/libata-pm.c
> +++ b/drivers/scsi/libata-pm.c
> @@ -327,6 +327,14 @@ static void ata_pm_quirks(u32 *gscr, int
>                 *nr_ports -=3D 2;
>                 *link_flags |=3D ATA_LFLAG_HRST_TO_RESUME;
>         }
> +
> +       /* Sil3726 reports one extra port and needs hardreset to
> +        * resume PM link.
> +        */
> +       if (vendor =3D=3D 0x1095 && devid =3D=3D 0x3726) {
> +               *nr_ports -=3D 1;
> +               *link_flags |=3D ATA_LFLAG_HRST_TO_RESUME;
> +       }
>  }
>
>  static int ata_pm_configure(struct ata_device *dev, int *r_nr_ports,
>
>
>
