From: Marc Bowes <marcbowes@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Sat, 20 Jun 2009 15:13:31 +0200
Message-ID: <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <1244746872.3998.88.camel@mulgrave.site>
	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>
	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>
	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>
	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>
	 <4A3B0D49.8070802@gmail.com>
	 <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>
	 <4A3CD738.1080105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:62244 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZFTNNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 09:13:31 -0400
Received: by ewy6 with SMTP id 6so3364614ewy.37
        for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2009 06:13:32 -0700 (PDT)
In-Reply-To: <4A3CD738.1080105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

Ok. Just keep me informed :)

On Sat, Jun 20, 2009 at 2:34 PM, Tejun Heo<htejun@gmail.com> wrote:
> Marc Bowes wrote:
>> Hi,
>>
>> Tejun, the motherboard is a Gigabyte EP45-DQ6. Attached are dmidecod=
e
>> and a new dmesg.txt, as I have enabled AHCI mode.
>
> Yeah, you have 2 sil5723's hanging off the jmicron controller. =A0If =
you
> have harddisks connected to those ports it will be okay. =A0If not,
> they'll keep the link online but timeout on SRST. =A0Hmmm... not real=
ly
> sure what to do yet. =A0Maybe we can do some sort of blacklisting. =A0=
I
> wonder how windows copes with this. =A0Hmmm...
>
> --
> tejun
>
