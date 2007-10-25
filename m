From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Thu, 25 Oct 2007 09:43:00 -0200
Message-ID: <47208144.9080602@mandic.com.br>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com> <471DD288.7010902@mandic.com.br> <471DE866.7040908@gmail.com> <20071023234732.GA23598@jim.sh> <471F493C.8050804@mandic.com.br> <471F4B11.9030206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:37221 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbXJYLnM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 07:43:12 -0400
In-Reply-To: <471F4B11.9030206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim Paris <jim@jtan.com>, Jeff Garzik <jeff@garzik.org>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

Tejun Heo wrote:
> Renato S. Yamane wrote:
>> Jim Paris wrote:
>>> For Debian, I don't think there are any complete solutions yet.
>>> The related bug is  =20
>>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224
>>
>> I think that we can fix this if someone can answer this:
>>
>> $ man halt
>> "-h flag: This is important for IDE drives, since the kernel doesn=92=
t=20
>> flush the write cache itself before power-off.."
>>
>> How can I know if kernel write cache itself? :-)
>=20
> Kernel has been flushing write cache for many many years now.  Man pa=
ge=20
> needs update.  Also, flushing cache from halt is okay.  What's hurtin=
g=20
> is spinning down the drive from halt.

So, I think that halt script need know:

- How many and who is IDE drives and SCSI/SATA drives.
- Devices with manage_start_stop as "0" or without manage_start_stop=20
need "halt -h".
- Devices with manage_start_stop as "1" need only "halt".

This is correct?

Regards,
Renato

