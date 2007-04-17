From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Tue, 17 Apr 2007 09:37:51 +0200
Message-ID: <b637ec0b0704170037r10b27116mb605eeda6b1e145b@mail.gmail.com>
References: <461D4E2C.6000704@redhat.com> <20070414105255.GB9157@ucw.cz>
	 <20070415155343.GA12069@khazad-dum.debian.net>
	 <Pine.LNX.4.61.0704152050150.27018@yvahk01.tjqt.qr>
	 <4623F804.3020405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:24812 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXDQHhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 03:37:52 -0400
Received: by an-out-0708.google.com with SMTP id b33so2107134ana
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 00:37:51 -0700 (PDT)
In-Reply-To: <4623F804.3020405@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi.

On 4/17/07, Chuck Ebbert <cebbert@redhat.com> wrote:
<snip>

> (2) Linux (alone) gives a very muted pop on shutdown. This could
>     be from bad interaction with the shutdown command, or some
>     other reason (drive not given enough time to shut down?)
>     The noise is not very loud, maybe the head did not have to
>     move very far?
>

I'm facing this with my HP Pavilion DV4378EA with a PATA disk (Toshiba
I think, but I'm not too sure, will check in the afternoon if needed).
"The Other OS" does not  cause the "pop" at shutdown. Linux does (last
checked: yesterday with 2.6.21-rc7).

I'm happy to test patches.
Regards,
Fabio
