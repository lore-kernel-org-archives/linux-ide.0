From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: SATA Drive Information (vs hdparm -i)?
Date: Thu, 22 Sep 2005 18:20:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221819350.6613@shark.he.net>
References: <7744a2840509221206254d2109@mail.gmail.com>  <43334AFF.8010901@torque.net>
  <Pine.LNX.4.58.0509221729480.6613@shark.he.net> <7744a28405092218012aa90cd0@mail.gmail.com>
 <43335755.501@emc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <43335755.501@emc.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Richard Bollinger <rabollinger@gmail.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 22 Sep 2005, Ric Wheeler wrote:

> Richard Bollinger wrote:
>
> >I'm specifically looking for something that will reveal the serial
> >number of each SATA drive.
> >-
> >
> hdparm (modified to run against libata SCSI drives) does show the serial
> number:
>
> [root@c001n01 root]# hdparm -I /dev/sda
>
> /dev/sda:
>
> ATA device, with non-removable media
>         Model Number:       Maxtor 6B300S0
>         Serial Number:      B60J1DTH
>         Firmware Revision:  BANC1B70

and where is that patch?...

-- 
~Randy
