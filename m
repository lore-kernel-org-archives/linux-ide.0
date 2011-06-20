From: Yuan-Hsin Chen <yuanlmm@gmail.com>
Subject: Re: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Mon, 20 Jun 2011 18:06:52 +0800
Message-ID: <BANLkTi=dgTNUESCstJNFUg6_YLbfwpNF5g@mail.gmail.com>
References: <20110617120704.GH2611@htj.dyndns.org>
	<1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
	<20110620081937.GN2611@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41290 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1FTKGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 06:06:54 -0400
In-Reply-To: <20110620081937.GN2611@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello.

On Mon, Jun 20, 2011 at 4:19 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Yuan.
>
> Yeap, almost there, just few very minor things. :)
>
> On Mon, Jun 20, 2011 at 04:06:41PM +0800, Yuan-Hsin Chen wrote:
>> =A0static struct ata_port_operations ahci_sb600_ops =3D {
>> =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ahci_ops,
>> - =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_sb600_softr=
eset,
>> - =A0 =A0 .pmp_softreset =A0 =A0 =A0 =A0 =A0=3D ahci_sb600_softreset=
,
>> + =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_pmp_retry_s=
rst_softreset,
>> =A0};
>
> Why doesn't sb600 just use ahci_pmp_retry_srst_ops?
>
>> @@ -312,6 +312,7 @@ extern struct device_attribute *ahci_sdev_attrs[=
];
>> =A0 =A0 =A0 .sdev_attrs =A0 =A0 =A0 =A0 =A0 =A0 =3D ahci_sdev_attrs
>>
>> =A0extern struct ata_port_operations ahci_ops;
>> +extern struct ata_port_operations ahci_pmp_retry_srst_ops;
>
> Heh, I know I suggested that name but that is one ugly name. =A0If
> anyone has any better idea, please come forward.

How about ahci_pmp_workaround_softreset or ahci_pmp_ipms_set_softreset?
Also applys to ops, ahci_pmp_workaround_ops or ahci_pmp_ipms_set_ops.

>
>> @@ -82,6 +82,8 @@ static void ahci_pmp_attach(struct ata_port *ap);
>> =A0static void ahci_pmp_detach(struct ata_port *ap);
>> =A0static int ahci_softreset(struct ata_link *link, unsigned int *cl=
ass,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long deadli=
ne);
>> +static int ahci_pmp_retry_srst_softreset(struct ata_link *link, uns=
igned int *class,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long deadline=
);
>
> srst equals softreset, so ahci_pmp_retry_softreset() should do.
>
>> +struct ata_port_operations ahci_pmp_retry_srst_ops =3D {
>> + =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ahci_ops,
>> + =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_pmp_retry_s=
rst_softreset,
>> +};
>> +EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
>> +
>> =A0struct ata_port_operations ahci_ops =3D {
>> =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &sata_pmp_port=
_ops,
>
> Maybe it's better to place ahci_pmp_retry_srst_ops after ahci_ops?
>
>> +static int ahci_pmp_check_ready(struct ata_link *link)
>
> It would be better if the name reflects that it's not for specific
> workaround.
>
> Thank you.
>
> --
> tejun
>
