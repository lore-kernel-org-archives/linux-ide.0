From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Recommended SATA controller?
Date: Mon, 08 Mar 2004 10:11:06 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opr4jc4svwq1sf88@mail.broadpark.no>
References: <opr4idafayq1sf88@mail.broadpark.no> <404BAF1D.9070103@superbug.demon.co.uk> <200403080118.52688.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:54713 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262297AbUCHJHI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2004 04:07:08 -0500
In-Reply-To: <200403080118.52688.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-ide@vger.kernel.org

On Mon, 8 Mar 2004 01:18:52 +0100, Bartlomiej Zolnierkiewicz 
<B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

>
> Hi.
>
> On Monday 08 of March 2004 00:24, James Courtier-Dutton wrote:
>> Arve Knudsen wrote:
>> > Hi
>> >
>> > As it seems the Silicon Image driver won't be radically improved 
>> anytime
>> > soon(?), I'm thinking of purchasing a dedicated SATA controller. Can
>
> Which driver are you refferring to (siimage.c or sil_sata.c?).
> They can't be improved because of lack of chipset errata info from SiI
> (available under NDA only).
I'm using siimage.c; I'm not blaiming developers, I've simply come to 
terms with the situation not improving in the foreseeable future.

>> > anyone recommend me a fairly cheap 2-port controller that's known to
>> > work well with Linux (2.6-series)? Stability is imperative, I just 
>> had a
>> > solid freeze and I'm afraid it might have to do with disk activity
>> > (playing MP3s while compiling). Might Promise (Ultra 150) or Adaptect
>> > (1210 SA) be worth considering?
>
> Adaptec 1210SA is using Silicon Image chipset.
> I haven't heard about problems with Promise chipsets.
The Promise alternative seems like the best alternative right now, 
googling indicates people are having success with it on Linux. Its not 
very expensive either, I think I will hold off on a motherboard purchase 
untill I (probably) upgrade to A64 this summer.

>> > Thanks
>> >
>> > Arve Knudsen
>>
>> The SATA controller on the ICH5 chips seems to work fine here. I have an
>> ABIT IC7-G motherboard with SATA controller on the ICH5 chip, all built
>> into the motherboard.
>
> Unfortunately Athlon motherboards with ICH5 are very hard to find. ;-)
> [ Silicon Image commonly is used on nForce2 motherboards ]
I have an nForce2 board, yes.

> Regards,
> Bartlomiej
>

Again thanks

Arve Knudsen


