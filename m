From: =?GB2312?B?0+HB1Q==?= <yulin@starsoftcomm.com>
Subject: Re: YuLin: Where can I get the newest source of sata_sis?
Date: Wed, 06 Jun 2007 10:11:30 +0800
Message-ID: <466617D2.4000102@starsoftcomm.com>
References: <465E92EA.2050608@starsoftcomm.com> <465F206B.1080908@gmx.net> <465F9FEE.7030409@starsoftcomm.com> <46633E34.4060708@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.starsoftcomm.com ([211.100.62.25]:42170 "EHLO
	mail.starsoftcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbXFFCLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 22:11:40 -0400
In-Reply-To: <46633E34.4060708@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

Uwe Koziolek =D0=B4=B5=C0:
>>>> When we used 2.6.18 and 2.6.20 on ASUS sis-671 motherboard, We hav=
e some
>>>> problem: cannot find the harddisk controller.
>>>> In BIOS, the SATA mode is 2P+2IDE.
>>>>
>>>> The official kernel 2.6.18, 2.6.20 and new 2.6.21 does not work, i=
 get
>>>> some information about sata_sis 0.7.1 from you, may I get it ?
>>>>
>>>> We are so urgent, please help me.
>>>>
>>>> Thank you very much!!!!
>>>>    =20
>>>>      =20
>>>>        =20
>>> Asus is selling a P5X-MX SE motherboard with a SiS968
>>> southbridge. The SiS671 Northbridge is not intresting for the SATA-=
support.
>>> Currently it is only planned to support this chipset in
>>> AHCI-mode. You should select the AHCI mode for the SATA-ports in th=
e
>>> BIOS. The ahci driver should support your board.
>>> kernel 2.6.20 should be sufficient.
>>> If this does not work, please provide the output of
>>> lspci -vvxxx and the selected mode for the SATA-port.
>>>
>>>
>>>    =20
>>>      =20
>>   new message:
>> SATA harddisk mode: IDE in BIOS
>> Port on SATA2 on motherboard failed. Dmesg said "ata2: SATA link dow=
n
>> (SStatus 0 SControl 0)".
>> Port on SATA1 on motherboard successed, found the harddisk and parti=
tions.
>>
>> What is the difference between SATA1 port and SATA2 port on motherbo=
ard,
>> is it a number of SATA port or different SATA version?
>>
>>  =20
>>    =20
> The 966/968 has a primary and a secondary controller. Both controller=
s
> are connected with 2 SATA-ports,a master and a slave port. That is
> different to other SATA controllers.
>
> The secondary controller on your board is not connected with SATA-por=
ts.
>
> The problem:
> Slave only configurations may not work.If you are only connecting the
> SATA-port 2, you have a slave only configuration.
> The ata2 in your dmesg is the unused secondary controller.
>
>
> I have retested the driver with SiS966 and kernel 2.6.22-rc3. It work=
s
> correctly on my board on all ports.
>
> If you want to be sure that the disks are working
> Please use the master device (port 1 on your board)
> You can also try to use the kernel version i have tested.
>
> Uwe Koziolek
>
>  =20
Hi, Uwe Koziolek

Thank you for your help.
Accroding to your advice, I thought there was some problem in enabling
the SATA2 port.
And then I get the infomation from sis in china, the port2_start=3D0x10=
,
so I added it into sata_sis in 2.6.18 and 2.6.20.

if(pci_get_device(PCI_VENDOR_ID_SI, 0x0966, NULL)) {
pci_read_config_dword(pdev, 0x64, &val);
if (val & 0x10000000) {
dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966L SATA
controller\n");
} else {
dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966 SATA
controller\n");
pi.flags |=3D ATA_FLAG_SLAVE_POSS;
}
} else
{
dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1183/968+ chipset\n");
port2_start =3D 0x10;
}


I dont know whether it is needed to make patch for official source code=
=2E
You Please.

=46inally, thank you very much. Keep in touch.

yulin
