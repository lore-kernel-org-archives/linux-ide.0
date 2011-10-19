From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] libata: fix for transport xfer attributes
Date: Wed, 19 Oct 2011 16:46:27 -0700
Message-ID: <CAMHSBOXBd4u9Vgtgh0D0SfGVwjgE-iNz5_v5P51WJ+x=biOdzg@mail.gmail.com>
References: <201110132203.45394.bzolnier@gmail.com>
	<4E9762DE.1060009@pobox.com>
	<201110141158.33983.bzolnier@gmail.com>
	<CANEJEGtzwQkDG1KmqVizmW8=SWuhYgjH02TgLaQzU-76TYUZZg@mail.gmail.com>
	<20111014203138.5d3460d5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1315 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1JSXqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 19:46:30 -0400
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
	by smtp-out.google.com with ESMTP id p9JNkTMS007792
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 16:46:29 -0700
Received: from qadc1 (qadc1.prod.google.com [10.224.32.129])
	by hpaq5.eem.corp.google.com with ESMTP id p9JNiiIB015707
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 16:46:28 -0700
Received: by qadc1 with SMTP id c1so4245254qad.0
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 16:46:27 -0700 (PDT)
In-Reply-To: <20111014203138.5d3460d5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Grant Grundler <grundler@google.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Changes looks good. I will post another one related to sata speed
soon. Also, I have to support slave ATA devices.

Gwendal.

On Fri, Oct 14, 2011 at 12:31 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> w=
rote:
>> =A0 =A0 "xfer_mode =A0 Current transfer mode."
>>
>> I agree with Bartomiej that current behavior is incorrect.
>
> Well we should probably fix the document and add the current transfer
> mode as its own sysfs entry - much less risky.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
