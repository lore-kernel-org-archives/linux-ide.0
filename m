From: Velu Erwan <erwan@seanodes.com>
Subject: Re: ATIIXP and libata
Date: Fri, 02 Dec 2005 11:54:38 +0100
Message-ID: <439027EE.6010202@seanodes.com>
References: <436AA2EA.2040508@yahoo.co.uk> <58cb370e0511040217y778fab7cj47d198b53126f9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:21149 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1751776AbVLBKym (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 05:54:42 -0500
In-Reply-To: <58cb370e0511040217y778fab7cj47d198b53126f9d7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz a =E9crit :

> =20
>
>>(I don't know much about the subject, but I presume that workarounds =
to
>>get ata_id_is_sata "to work somehow" from atiixp.c would not be the
>>right thing to do, even if feasible.)
>>   =20
>>
>
><linux/ata.h> include is used by both IDE and libata
>driver, however ata_id_is_sata() shouldn't be used
>directly in atiixp.c but similar check should be added
>to eighty_ninty_three() from ide-iops.c.
> =20
>
Is there any chance to have a fix for this troubles in some recent kern=
el ?
I don't know how to help to make this fixed upstream. I would like not=20
to have a personnal patch for making my system running.

Erwan,
