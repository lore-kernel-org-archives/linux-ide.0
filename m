From: "davor emard" <davoremard@gmail.com>
Subject: Re: AHCI SATA DVD writing issue
Date: Wed, 16 Apr 2008 17:58:59 +0200
Message-ID: <beee72200804160858g35347525q3d75b90a0817ee5d@mail.gmail.com>
References: <beee72200803200416j2c744450v8b21cf6fe029ff1a@mail.gmail.com>
	 <47EE3A1A.6080406@gmail.com>
	 <beee72200804011526u271d8951m126afd2913748187@mail.gmail.com>
	 <47F2D1DB.5060207@gmail.com>
	 <beee72200804020551i2217d87cycc0a5dcd8e25f2f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:54976 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbYDPP7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 11:59:00 -0400
Received: by py-out-1112.google.com with SMTP id u52so3430588pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 08:59:00 -0700 (PDT)
In-Reply-To: <beee72200804020551i2217d87cycc0a5dcd8e25f2f9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>

HI

Regarding the mv6145 dvd writing issue, is there something I can
try myself, some interesting places to modify or tune the driver in
order to fix the bug? Gimme some clue I can try them

Best regards, Davor


On 4/2/08, davor emard <davoremard@gmail.com> wrote:
> Hello Tejun and all
>
> Here are results of the ata ahci test on 2.6.25-rc8
>
> Basically not much improvement,,
>
> wodim --devices creates similar errors and hangs
> the controller
>
> mounting with pioneer now creates I/O errors (which haven't
> appeared on 2.6.24.4)
>
> if I ignore errors the mounted CD seems to
> work and at least directory is listed. I havent tried
> to verify contents of the files
>
> On optiarc, similar as before - the hid daemon prints
> correct CD name after insertion but the mounting on
> optiarc causes similar ata errors and hangs the sata controller
>
> attached are the syslogs
>
> Best regards, Davor
>
