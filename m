From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] ata: add CONFIG_SATA_HOST config option
Date: Mon, 14 Feb 2011 09:36:49 +0100
Message-ID: <AANLkTin60En3+5saCeVuGht8w0k1b074WqKLdmo1WE5T@mail.gmail.com>
References: <201102111433.41507.bzolnier@gmail.com>
	<4D57ED29.2030801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57908 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1BNIgu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2011 03:36:50 -0500
In-Reply-To: <4D57ED29.2030801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On Sun, Feb 13, 2011 at 3:39 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 11-02-2011 16:33, Bartlomiej Zolnierkiewicz wrote:
>
>> Add CONFIG_SATA_HOST config option (for selecting SATA Host
>> support) to make setup easier on PATA-only systems.
>
>> Additionally move SATA-specific code to libata-sata.c which
>> allows us to save ~11.5k of the output code size (x86-64) on
>> PATA-only systems for CONFIG_SATA_HOST=3Dn:
>
>> CONFIG_SATA_HOST=3Dy:
>> =A0 =A0text =A0 =A0data =A0 =A0 bss =A0 =A0 dec =A0 =A0 hex filename
>> =A0 44283 =A0 =A06576 =A0 =A0 =A057 =A0 50916 =A0 =A0c6e4 drivers/at=
a/libata-core.o
>> =A0 29054 =A0 =A0 =A016 =A0 =A0 =A0 2 =A0 29072 =A0 =A07190 drivers/=
ata/libata-eh.o
>> =A0 20085 =A0 =A0 =A0 0 =A0 =A0 =A019 =A0 20104 =A0 =A04e88 drivers/=
ata/libata-sff.o
>> =A0 =A08699 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A08699 =A0 =A021fb driv=
ers/ata/libata-sata.o
>
>> CONFIG_SATA_HOST=3Dn:
>> =A0 =A0text =A0 =A0data =A0 =A0 bss =A0 =A0 dec =A0 =A0 hex filename
>> =A0 43754 =A0 =A06576 =A0 =A0 =A057 =A0 50387 =A0 =A0c4d3 drivers/at=
a/libata-core.o
>> =A0 26775 =A0 =A0 =A016 =A0 =A0 =A0 2 =A0 26793 =A0 =A068a9 drivers/=
ata/libata-eh.o
>> =A0 20144 =A0 =A0 =A0 0 =A0 =A0 =A019 =A0 20163 =A0 =A04ec3 drivers/=
ata/libata-sff.o
>
>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>
> [...]
>
>> Index: b/drivers/ata/libata-core.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>
> [...]
>>
>> @@ -573,34 +494,26 @@ void ata_tf_to_fis(const struct ata_task
>> =A0 =A0 =A0 =A0fis[19] =3D 0;
>> =A0}
>
> =A0 Hm, what about ata_tf_to_fis()? It shouldn't be needed by non-SAT=
A stuff,
> moreover it'should be only needed by non-SFF controllers...

in theory yes but it is actually used by libata-scsi.c

>> +#ifndef CONFIG_SATA_HOST
>> +int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy po=
licy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool spm_wakeup)
>> =A0{
>> - =A0 =A0 =A0 tf->command =A0 =A0 =3D fis[2]; =A0 =A0 =A0 /* status =
*/
>> - =A0 =A0 =A0 tf->feature =A0 =A0 =3D fis[3]; =A0 =A0 =A0 /* error *=
/
>> -
>> - =A0 =A0 =A0 tf->lbal =A0 =A0 =A0 =A0=3D fis[4];
>> - =A0 =A0 =A0 tf->lbam =A0 =A0 =A0 =A0=3D fis[5];
>> - =A0 =A0 =A0 tf->lbah =A0 =A0 =A0 =A0=3D fis[6];
>> - =A0 =A0 =A0 tf->device =A0 =A0 =A0=3D fis[7];
>> -
>> - =A0 =A0 =A0 tf->hob_lbal =A0 =A0=3D fis[8];
>> - =A0 =A0 =A0 tf->hob_lbam =A0 =A0=3D fis[9];
>> - =A0 =A0 =A0 tf->hob_lbah =A0 =A0=3D fis[10];
>> -
>> - =A0 =A0 =A0 tf->nsect =A0 =A0 =A0 =3D fis[12];
>> - =A0 =A0 =A0 tf->hob_nsect =A0 =3D fis[13];
>> + =A0 =A0 =A0 return -EOPNOTSUPP;
>> +}
>> +EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
>
> =A0 Shouldn't there be empty line here?

ata_piix needs it

>> +int sata_std_hardreset(struct ata_link *link, unsigned int *class,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long deadline)
>> +{
>> + =A0 =A0 =A0 return -EOPNOTSUPP;
>> +}
>> +EXPORT_SYMBOL_GPL(sata_std_hardreset);
>
> =A0 ... and here?

ditto, and it is quite useful to have possibility of building ata_piix
w/ CONFIG_SATA_HOST=3Dn

>> Index: b/drivers/ata/libata-sata.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- /dev/null
>> +++ b/drivers/ata/libata-sata.c
>> @@ -0,0 +1,1242 @@
>
> [...]
>>
>> +int sata_set_spd(struct ata_link *link)
>> +{
>> + =A0 =A0 =A0 u32 scontrol;
>> + =A0 =A0 =A0 int rc;
>> +
>> + =A0 =A0 =A0 if ((rc =3D sata_scr_read(link, SCR_CONTROL, &scontrol=
)))
>
> =A0 I guess checkpatch.pl protests here...

it does ;)

[...]

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 scontrol =3D (scontrol& =A00x0f0) | 0x301;
>> +
>> + =A0 =A0 =A0 if ((rc =3D sata_scr_write_flush(link, SCR_CONTROL, sc=
ontrol)))
>
> =A0 And here...
> =A0 I understand that you're only moving the code. Perhaps it's worth=
 fixing
> checkpatch.pl's complaints beforehand -- I was going to look at it...

Because code is moved I preferred to leave CodingStyle changes alone
but I also think that it would be useful to fix them one day (though I
deferred the work for later due to pragmatic reasons)..

Thanks,
Bartlomiej
