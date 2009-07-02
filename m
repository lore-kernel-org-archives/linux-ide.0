From: Marc Bowes <marcbowes@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Thu, 2 Jul 2009 11:22:17 +0200
Message-ID: <cfa4e840907020222ueef735bpcf220fe7f81097ae@mail.gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>
	 <4A3B0D49.8070802@gmail.com>
	 <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>
	 <4A3CD738.1080105@gmail.com>
	 <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>
	 <4A489562.8080404@gmail.com>
	 <cfa4e840907010107s4d47c877n990594e660759cc@mail.gmail.com>
	 <4A4BF1C1.3040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:65422 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZGBJWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 05:22:15 -0400
Received: by ewy6 with SMTP id 6so1914992ewy.37
        for <linux-ide@vger.kernel.org>; Thu, 02 Jul 2009 02:22:17 -0700 (PDT)
In-Reply-To: <4A4BF1C1.3040103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

# CONFIG_SCSI_SCAN_ASYNC is not set

Is that what you are referring to?

On Thu, Jul 2, 2009 at 1:31 AM, Tejun Heo<htejun@gmail.com> wrote:
> Marc Bowes wrote:
>> Hi Tejun,
>>
>> The patch works as you intended it. There is still some timeout, but
>> it is not more than 2-3 seconds which is a vast improvement. Attache=
d
>> is the new dmesg.
>
> Thanks for verifying. =A0It still takes twenty seconds. =A0Do you hav=
e
> async probing turned on?
>
> --
> tejun
>
