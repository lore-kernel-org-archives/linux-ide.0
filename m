From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 14:51:16 -0300
Message-ID: <20080529175116.GE3375@khazad-dum.debian.net>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de> <20080529143541.GA24013@srcf.ucam.org> <483EBFC5.7020406@gmail.com> <20080529144934.GA24382@srcf.ucam.org> <20080529163201.GA4520@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757483AbYE2Rvb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080529163201.GA4520@homac>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 29 May 2008, Holger Macht wrote:
> On Thu 29. May - 15:49:34, Matthew Garrett wrote:
> > Got it. It works if I lose the ata_port_freeze() from=20
> > ata_acpi_detach_device.=20
>=20
> Tejun, any idea? This is in for quite some time now. Maybe there's so=
me
> involved...

<naiv=EB question> Do we handle the possible fact that _EJ0 might want =
the
port (and maybe the device) to be active when it is called AND that _EJ=
0
might attempt to shutdown the port or the device itself?  </naiv=EB
question>

Please ignore if it is something not even worth answering.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
