From: Dan Porat <dan.porat@gmail.com>
Subject: Re: 520 Bytes sector size
Date: Sun, 7 Feb 2010 09:57:56 +0200
Message-ID: <93b143da1002062357o4503d1aajeff1595684211c5@mail.gmail.com>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>
	 <yq1aavrqlxw.fsf@sermon.lab.mkp.net>
	 <20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
	 <4B69B032.4010600@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f211.google.com ([209.85.220.211]:57152 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0BGH55 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Feb 2010 02:57:57 -0500
Received: by fxm3 with SMTP id 3so6057765fxm.39
        for <linux-ide@vger.kernel.org>; Sat, 06 Feb 2010 23:57:56 -0800 (PST)
In-Reply-To: <4B69B032.4010600@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

I see , but aren't all the commands (including FPDMA) , shoudl work in
520 mode , when the disk is formatted to 520 ?

Thanks


On Wed, Feb 3, 2010 at 7:19 PM, Mark Lord <kernel@teksavvy.com> wrote:
> Alan Cox wrote:
>>
>> On Tue, 02 Feb 2010 18:04:11 -0500
>> "Martin K. Petersen" <martin.petersen@oracle.com> wrote:
>>
>>>>>>>> "Dan" =3D=3D Dan Porat <dan.porat@gmail.com> writes:
>>>
>>> Dan> I would like to run 520 Bytes disk in native mode. =A0What cha=
nges I
>>> Dan> have to run in sg driver ? =A0Is there any kernel already adap=
ted for
>>> Dan> 520 bytes sector size ?
>>>
>>> Linux does not support 520-byte sectors unless the drive is formatt=
ed
>>> with DIF and hanging off a DIF-capable HBA.
>
> ..
>
> The ATA READ_LONG and WRITE_LONG commands both use 520 byte sectors,
> and both work with libata.
>
> -ml
>
