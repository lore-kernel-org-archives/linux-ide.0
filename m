From: Yuan-Hsin Chen <yuanlmm@gmail.com>
Subject: Re: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Mon, 20 Jun 2011 16:47:09 +0800
Message-ID: <BANLkTikyryXaAyf8tRB8uzUHV=eQCRT=Zg@mail.gmail.com>
References: <20110617120704.GH2611@htj.dyndns.org>
	<1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
	<4DFF019B.8030605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53160 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1FTIrK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 04:47:10 -0400
In-Reply-To: <4DFF019B.8030605@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello.
I'm really sorry for ignoring your previous e-mail.
I'll fix it in the next patch. Thanks for reviewing my patch.

Yuan-Hsin

On Mon, Jun 20, 2011 at 4:15 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 20-06-2011 12:06, Yuan-Hsin Chen wrote:
>
>> From: Yuan-Hsin Chen<yhchen@faraday-tech.com>
>
>> ahci_sb600_softreset was in ahci.c. This function is used
>> to fix soft reset failure and renames as ahci_pmp_retry_srst_softres=
et
>> in libahci.c.
>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 71afe03..2de36b6 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -79,8 +79,6 @@ enum board_ids {
>> =A0};
>>
>> =A0static int ahci_init_one(struct pci_dev *pdev, const struct pci_d=
evice_id
>> *ent);
>> -static int ahci_sb600_softreset(struct ata_link *link, unsigned int
>> *class,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long dead=
line);
>> =A0static int ahci_vt8251_hardreset(struct ata_link *link, unsigned =
int
>> *class,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsi=
gned long deadline);
>> =A0static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned i=
nt
>> *class,
>> @@ -106,8 +104,7 @@ static struct ata_port_operations ahci_p5wdh_ops=
 =3D {
>>
>> =A0static struct ata_port_operations ahci_sb600_ops =3D {
>> =A0 =A0 =A0 =A0.inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D&ahci_ops,
>> - =A0 =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_sb600_s=
oftreset,
>> - =A0 =A0 =A0 .pmp_softreset =A0 =A0 =A0 =A0 =A0=3D ahci_sb600_softr=
eset,
>> + =A0 =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_pmp_ret=
ry_srst_softreset,
>
> =A0 I have to ask you again: have you tried to compile this?
>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index d38c40f..0fd5a30 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -82,6 +82,8 @@ static void ahci_pmp_attach(struct ata_port *ap);
>> =A0static void ahci_pmp_detach(struct ata_port *ap);
>> =A0static int ahci_softreset(struct ata_link *link, unsigned int *cl=
ass,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long dea=
dline);
>> +static int ahci_pmp_retry_srst_softreset(struct ata_link *link, uns=
igned
>> int *class,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long dead=
line);
>
> =A0 How come this is static if you reference it outside this module?
>
> WBR, Sergei
>
