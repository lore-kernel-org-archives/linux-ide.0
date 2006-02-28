From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
Date: Tue, 28 Feb 2006 13:08:43 +0100
Message-ID: <20060228120843.GC3695@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com> <20060228115715.GE4081@elf.ucw.cz> <44043C7D.5090207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932503AbWB1MJF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44043C7D.5090207@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org
List-Id: linux-ide@vger.kernel.org

On =DAt 28-02-06 07:05:17, Jeff Garzik wrote:
> Pavel Machek wrote:
> >On St 22-02-06 14:01:40, Randy Dunlap wrote:
> >
> >>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>
> >>Do drive/taskfile-specific commands before setting the drive mode.
> >>This allows the taskfile to unlock the drive before trying to
> >>set the drive mode.
> >>
> >>Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>---
> >>drivers/scsi/libata-core.c |   13 ++++++++++---
> >>1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >>--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
> >>+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
> >>@@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
> >> */
> >>int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
> >>{
> >>+	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);
> >
> >
> >Yep, one more helpful printk. Not. Actually this is four more of the=
m
> >in this patch alone. Please remove your debugging code prior to merg=
e.
>=20
> Agreed, with the modification s/remove/limit by ata_msg_xxx/

Please, just remove them. Driver model core already has debugging that
can be enabled and prints what is called.

I do not think we want printk() at begining of every *_resume
function.
								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
