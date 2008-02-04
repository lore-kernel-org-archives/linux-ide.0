From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-tape: dump gcw fields on error in
	idetape_identify_device()
Date: Mon, 4 Feb 2008 12:36:35 +0100
Message-ID: <20080204113635.GC5268@gollum.tnic>
References: <200802021922.56703.bzolnier@gmail.com> <47A5F6FA.3000107@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:2249 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYBDLhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 06:37:40 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1445863wra.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 03:37:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47A5F6FA.3000107@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 03, 2008 at 08:16:42PM +0300, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>> Index: b/drivers/ide/ide-tape.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/ide/ide-tape.c
>> +++ b/drivers/ide/ide-tape.c
>> @@ -3852,16 +3852,17 @@ static int idetape_identify_device (ide_
>>   	/* Check that we can support this device */
>>  -	if (gcw.protocol !=3D2 )
>> -		printk(KERN_ERR "ide-tape: Protocol is not ATAPI\n");
>> +	if (gcw.protocol !=3D 2)
>> +		printk(KERN_ERR "ide-tape: Protocol (0x%02x) is not ATAPI\n",
>> +				gcw.protocol);
>>  	else if (gcw.device_type !=3D 1)
>> -		printk(KERN_ERR "ide-tape: Device type is not set to tape\n");
>> +		printk(KERN_ERR "ide-tape: Device type (0x%02x) is not set "
>> +				"to tape\n", gcw.device_type);
>>  	else if (!gcw.removable)
>>  		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
>>  	else if (gcw.packet_size !=3D 0) {
>> -		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes long\n");
>> -		if (gcw.packet_size =3D=3D 1)
>> -			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes is still n=
ot supported\n");
>> +		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12 "
>> +				"bytes long\n", gcw.packet_size);
>
>    Shouldn't it be either "packet size is not 12 byted" or "packet is=
 not=20
> 12 bytes long"?

I like the last one better. Will send a correction later on to Bart. Th=
anks.

--=20
Regards/Gru=DF,
    Boris.
