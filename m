From: "sam song" <sam_song@usish.com>
Subject: =?utf-8?Q?=E7=AD=94=E5=A4=8D=3A_Disk_spin_down_issue_on_s?=
	=?utf-8?Q?hut_down=2Fsuspend_to_disk?=
Date: Tue, 7 Aug 2007 17:51:52 +0800
Message-ID: <000601c7d8d8$959c9130$5f39a8c0@usish.com.cn>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>	 
	<1186411815.4355.7.camel@nx6310>	 
	<20070806150159.GC31615@khazad-dum.debian.net>	 
	<200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com>	 
	<1186424492.4355.1.camel@nx6310>  <46B76BBC.9010107@gmail.com>	 
	<1186438698.4402.6.camel@nx6310>  <46B817AB.30105@gmail.com>
	<1186478319.3705.3.camel@nx6310> <46B83C0B.8050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46B83C0B.8050902@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Michael Sedkowski' <sedmich@gmail.com>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Henrique de Moraes Holschuh' <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Michael Sedkowski wrote:
> > Dnia 07-08-2007, Wt o godzinie 15:56 +0900, Tejun Heo napisa=C5=82(=
a):
> >> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
> >> Always       -       388
[snip]
> On power off, the r/w heads in a disk should be unloaded (parked).  T=
his
> is usually achieved by either putting the disk into standby/sleep mod=
e
> during shutdown.  However, all modern disks can automatically unload
> their heads when the power is removed abruptly.  This is called
> emergency unload.  Emergency unload does shorten the lifespan of the
> disk but you don't have to worry too much about it.  Disks are design=
ed
> to withstand certain number of emergency unloads.

Out of interest, does Power-Off_Retract_Count attribute only record eme=
rgency unloads
rather than normal power off by Linux shutdown command?

Thanks in advance,

Sam

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
