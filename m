From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in cdrom_read_capacity
Date: Wed, 30 Jul 2008 10:52:50 +0200
Message-ID: <9ea470500807300152p5d5414aaq2d0d0053c12ef3f5@mail.gmail.com>
References: <1217405406.11834.11.camel@elijah.suse.cz>
	 <20080730011832.0ee55d47.akpm@linux-foundation.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759898AbYG3IxO@vger.kernel.org>
In-Reply-To: <20080730011832.0ee55d47.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jan Kara <jack@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 30, 2008 at 10:18 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 30 Jul 2008 10:10:06 +0200 Petr Tesarik <ptesarik@suse.cz> wr=
ote:
>
>> Resent because of a typo in the LKML address. :(
>
> Thanks.
>
>>
>> Aesthetic regards aside, commit e8e7b9eb11c34ee18bde8b7011af41938d1a=
d667
>> still leaves a bug in the error message, because it uses the unconve=
rted
>> big-endian value for printk.
>>
>> Fix this by using a local variable in machine byte order. The result=
 is
>> correct, more readable, and also produces slightly shorter code on i=
386.
>>
>> Cc: Jens Axboe <jens.axboe@oracle.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

I definitely like this one better, thanks.

Acked-by: Borislav Petkov <petkovbb@gmail.com>


>
> Bart owns this patch now.  It got lost for a month and it has already
> been fixed twice and it is also on the route to 2.6.25.x and 2.6.26.x=
,
> so it'll get complicated.  Not a happy little patch.

Greg, can you please apply this one on top of -stable.

>
>>
>>  ide-cd.c |   18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>> --- a/drivers/ide/ide-cd.c
>> +++ b/drivers/ide/ide-cd.c
>> @@ -1305,6 +1305,7 @@ static int cdrom_read_capacity(ide_drive_t *dr=
ive, unsigned long *capacity,
>>       int stat;
>>       unsigned char cmd[BLK_MAX_CDB];
>>       unsigned len =3D sizeof(capbuf);
>> +     __u32 blocklen;
>>
>>       memset(cmd, 0, BLK_MAX_CDB);
>>       cmd[0] =3D GPCMD_READ_CDVD_CAPACITY;
>> @@ -1317,23 +1318,24 @@ static int cdrom_read_capacity(ide_drive_t *=
drive, unsigned long *capacity,
>>       /*
>>        * Sanity check the given block size
>>        */
>> -     switch (capbuf.blocklen) {
>> -     case __constant_cpu_to_be32(512):
>> -     case __constant_cpu_to_be32(1024):
>> -     case __constant_cpu_to_be32(2048):
>> -     case __constant_cpu_to_be32(4096):
>> +     blocklen =3D be32_to_cpu(capbuf.blocklen);
>> +     switch (blocklen) {
>> +     case 512:
>> +     case 1024:
>> +     case 2048:
>> +     case 4096:
>>               break;
>>       default:
>>               printk(KERN_ERR "%s: weird block size %u\n",
>> -                     drive->name, capbuf.blocklen);
>> +                     drive->name, blocklen);
>>               printk(KERN_ERR "%s: default to 2kb block size\n",
>>                       drive->name);
>> -             capbuf.blocklen =3D __constant_cpu_to_be32(2048);
>> +             blocklen =3D 2048;
>>               break;
>>       }
>>
>>       *capacity =3D 1 + be32_to_cpu(capbuf.lba);
>> -     *sectors_per_frame =3D be32_to_cpu(capbuf.blocklen) >> SECTOR_=
BITS;
>> +     *sectors_per_frame =3D blocklen >> SECTOR_BITS;
>>       return 0;
>>  }
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--=20
Regards/Gru=DF,
Boris
