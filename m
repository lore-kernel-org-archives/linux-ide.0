From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Wed, 24 Oct 2007 11:31:40 -0200
Message-ID: <471F493C.8050804@mandic.com.br>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com> <471DD288.7010902@mandic.com.br> <471DE866.7040908@gmail.com> <20071023234732.GA23598@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:52277 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbXJXNb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 09:31:58 -0400
In-Reply-To: <20071023234732.GA23598@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Tejun Heo <htejun@gmail.com>, "Renato S. Yamane" <renatoyamane@mandic.com.br>, Jeff Garzik <jeff@garzik.org>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

Jim Paris escreveu:
> Tejun Heo wrote:
>> Ehh... I meant something along the line of...
>>
>> "Info for Debian VERSION users : if you see this warning there are
>> several solutions... blah blah".
>=20
> For Debian, I don't think there are any complete solutions yet.
> The related bug is=20
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224

I think that we can fix this if someone can answer this:

$ man halt
"-h flag: This is important for IDE drives, since the kernel doesn=92t=20
flush the write cache itself before power-off.."

How can I know if kernel write cache itself? :-)

Regards,
Renato

