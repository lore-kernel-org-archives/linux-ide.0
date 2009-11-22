From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: add parameter to disable ahci driver on Promise
	PDC42819
Date: Sun, 22 Nov 2009 11:16:15 +1100
Message-ID: <65a6ef750911211616o4d29a232na60757e87ec329c3@mail.gmail.com>
References: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
	 <4B021465.2030500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:13067 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbZKVAQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Nov 2009 19:16:12 -0500
Received: by ey-out-2122.google.com with SMTP id 4so730258eyf.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Nov 2009 16:16:16 -0800 (PST)
In-Reply-To: <4B021465.2030500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, Nov 17, 2009 at 2:11 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 11/11/2009 04:54 AM, Mark Nelson wrote:
>>
>> ahci can drive the Promise PDC42819, but obviously it can only use S=
ATA
>> disks connected to this controller. The controller can actually supp=
ort
>> SAS disks as well, but at the moment only with Promise's own binary
>> t3sas driver.
>>
>> To allow users to use both the ahci and the t3sas drivers in the sam=
e
>> system (with t3sas controlling the PDC42819) we add a parameter,
>> promise_enable that can be used to disable ahci on the Promise chip =
(by
>> setting it to 0). This way even if the ahci driver is loaded first t=
he
>> t3sas driver can grab the Promise chip and the user's SAS disks will=
 be
>> operational.
>>
>> By default the parameter is 1 so ahci drives the controller.
>>
>> While we're at it, add a message letting users know that with ahci
>> driving their Promise chip they won't be able to use their SAS disks=
=2E
>>
>> Signed-off-by: Mark Nelson<mdnelson8@gmail.com>
>> ---
>> =A0drivers/ata/ahci.c | =A0 23 +++++++++++++++++++++++
>> =A01 file changed, 23 insertions(+)
>>
>> Index: linux-2.6/drivers/ata/ahci.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/drivers/ata/ahci.c
>> +++ linux-2.6/drivers/ata/ahci.c
>> @@ -700,6 +700,9 @@ static int marvell_enable =3D 1;
>> =A0module_param(marvell_enable, int, 0644);
>> =A0MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 =3D en=
abled)");
>>
>> +static int promise_enable =3D 1;
>> +module_param(promise_enable, int, 0644);
>> +MODULE_PARM_DESC(promise_enable, "Promise PDC42819 via AHCI (1 =3D
>> enabled)");
>>
>> =A0static inline int ahci_nr_ports(u32 cap)
>> =A0{
>> @@ -2988,6 +2991,26 @@ static int ahci_init_one(struct pci_dev
>> =A0 =A0 =A0 =A0if (pdev->vendor =3D=3D PCI_VENDOR_ID_MARVELL&& =A0!m=
arvell_enable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>
>> + =A0 =A0 =A0 /* Promise's PDC42819 is a SAS/SATA controller that ha=
s an AHCI
>> mode.
>> + =A0 =A0 =A0 =A0* At the moment, Promise's t3sas driver is required=
 for SAS
>> + =A0 =A0 =A0 =A0* functionality. Disable ahci on this device if the=
 user asked
>> for
>> + =A0 =A0 =A0 =A0* it.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (pdev->vendor =3D=3D PCI_VENDOR_ID_PROMISE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (promise_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_INFO,&=
pdev->dev, "Promise PDC42819
>> "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "support
>> enabled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_INFO,&=
pdev->dev, "Only SATA
>> devices "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "will function
>> with"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " this
>> driver\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_INFO,&=
pdev->dev, "Promise PDC42819
>> "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "support
>> disabled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> I don't mind adding a warning "only SATA devices will function with t=
his
> driver."

That works for me - with a warning at least users won't be left guessin=
g.

>
> The promise_enable is not something we do with closed-source drivers,
> though, so that code logic is NAK'd

That's completely understandable.

I'll cut the patch down to just add the warning and resend.

Thanks Jeff!

Mark.
