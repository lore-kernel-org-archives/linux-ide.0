From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sun, 25 Feb 2007 18:22:47 +0100
Message-ID: <200702251822.47387.bzolnier@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com> <200702241911.21030.bzolnier@gmail.com> <8d158e1f0702250546lddf9748r3c210504f3e94304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:19316 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964981AbXBYRQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 12:16:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so635645uga
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 09:16:30 -0800 (PST)
In-Reply-To: <8d158e1f0702250546lddf9748r3c210504f3e94304@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


On Sunday 25 February 2007, Patrick Ale wrote:
> On 2/24/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> Hoi and good afternoon :)

Hey!

> Okay so... this is my dmesg with the legacy IDE drivers loaded.
> Please note that I still use libata for my boot drive but that the
> current vs native capacity errors disapeared *sniff*, no petabytes
> after all!

Could you verify that loading pata_pdc2027xx module first,
then unloading it and loading pdc2027xx_new driver also works?

If it does then we can probably blame the bad capacity problem on
some hardware problem fixed by replacing cables...

Thanks,
Bart
