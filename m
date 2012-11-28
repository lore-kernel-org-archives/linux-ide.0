From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: Is FBS (FIS) working on Silicon Image 3726 port multiplier?
Date: Thu, 29 Nov 2012 07:41:03 +0900 (JST)
Message-ID: <592315.2060.qm@web100007.mail.kks.yahoo.co.jp>
References: <50B5637A.8050106@gmail.com>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100007.mail.kks.yahoo.co.jp ([114.111.98.181]:47766 "HELO
	web100007.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756250Ab2K1WlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2012 17:41:05 -0500
In-Reply-To: <50B5637A.8050106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>

On Wed, 2012/11/28, Robert Hancock wrote:
> On 11/23/2012 07:01 PM, Norman Diamond wrote:
>> I wrot on October 17, 2012 2:25 PM
>>
>>> I'm trying to use an SIL3726 with 5 SATA drives and an SIL3132.
>>> FBS should work, right?=A0 But performance looks like CBS.
>>> Is there some way to check if FBS is actually enabled?
>>
>> I added some ata_dev_printk calls in file libahci.c,
>> static void ahci_enable_fbs(struct ata_port *ap)
>> and a few other places, but none of them were logged.
>> In file libata-pmp.c, the following continues to be logged:
>> if (print_info) {
>> ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
>>=A0 =A0 =A0 =A0 "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
>>=A0 =A0 =A0 =A0 sata_pmp_spec_rev_str(gscr), vendor, devid,
>>=A0 =A0 =A0 =A0 sata_pmp_gscr_rev(gscr),
>>=A0 =A0 =A0 =A0 nr_ports, gscr[SATA_PMP_GSCR_FEAT_EN],
>>=A0 =A0 =A0 =A0 gscr[SATA_PMP_GSCR_FEAT]);
>> ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0=
x9
>>
>> Finally I figured out that the sil24 driver uses its own port multip=
lier
>> code and never calls the libahci code.
>>
>> So the reason why it performs like CBS instead of FBS is due to
>> something in the sil24 driver, or the SIL3132 HBA firmware, or the
>> SIL3726 port multiplier firmware.=A0 I still can't figure out which.
>=20
> sata_sil24 doesn't support FBS. The datasheet seems to have some ment=
ion=20
> of FBS support in the chip, but I don't know if that's actually the c=
ase.

OK.  Although we can't figure out the underlying reason, it is clear th=
at the combination of SIL3132 (or SIL3124) HBA and Linux will not suppo=
rt FBS regardless of SIL3726's capability.  Everywhere I looked, there =
were statements that SIL3132, SIL3124, and SIL3726 support FBS, but if =
the vendor doesn't release details of the HBAs then obviously it's hard=
 to get FBS working.  Sometimes it's amazing that Linux volunteers can =
make a chip work at all.

Thank you for the information.  At least now I know not to waste more d=
ays trying to figure out where to add more printk's and still not accom=
plishing anything.

After posting the question, I tried a Marvell SAS HBA but having troubl=
e that might be due to a SAS-to-eSATA cable maybe being the wrong varie=
ty.  It sure is frustrating trying to find a way to get FBS to work.
