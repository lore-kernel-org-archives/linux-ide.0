From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Thu, 15 Jan 2009 19:06:07 +0600
Message-ID: <496F34BF.5010701@ngs.ru>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com> <496EA53F.7000605@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:48968 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901AbZAONKN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 08:10:13 -0500
In-Reply-To: <496EA53F.7000605@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Harri Olin <harri.olin@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Sounds great! Sorry, but I can't check the patch in the near future, I=20
don't have necessary hardware at the moment :(

Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Harri Olin wrote:
>> ..
>> After first 55 minutes of testing, no timeouts yet, so I'm quite sur=
e=20
>> it works ok now (yay!). Without this patch, timeouts happened every=20
>> couple minutes on similar load. I think I'll let it run for a day an=
d=20
>> report back tomorrow how things are by then.
> ..
>
> Okay, we have a winner!
> I just need to get the "okay" from Marvell,
> and then I'll feed this patch for 2.6.29 and earlier -stable streams.
>
>> Note that I didn't apply the previous patch as they don't apply on=20
>> each other. If needed, I can test it separately after running this=20
>> for a while.
> ..
>
> No need. The earlier patch has no effect, other than speeding up your=
=20
> system
> by a slight amount. I'll submit that for upstream separately, along=20
> with a
> fix for another "duh!" I noticed in the code.
>
> In the meanwhile, you should keep the working patch (obviously)
> in your kernels -- the same/similar patch will apply to earlier
> kernels if needed.
>
> Thanks to you and Brian for the legwork!
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

