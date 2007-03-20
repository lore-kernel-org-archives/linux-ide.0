From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 3/4] libata: reimplement suspend/resume support using sdev->manage_start_stop
Date: Tue, 20 Mar 2007 17:15:06 +0100
Message-ID: <200703201715.08114.oliver@neukum.org>
References: <20070320150718.GF6152@htj.dyndns.org> <20070320152533.GH6152@htj.dyndns.org> <20070320163919.222ae79d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20070320163919.222ae79d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>, djwong@us.ibm.com, hmh@hmh.eng.br
List-Id: linux-ide@vger.kernel.org

Am Dienstag, 20. M=E4rz 2007 17:39 schrieb Alan Cox:
> > * sdev->manage_start_stop is set to 1 in ata_scsi_slave_config().
> > =A0 This fixes spindown on shutdown and suspend-to-disk.
>=20
> Yay!!!!

Which kernel version is this?

	Regards
		Oliver
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
