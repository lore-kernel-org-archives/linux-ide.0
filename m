From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Wed, 23 Aug 2006 13:12:25 -0600
Message-ID: <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
	 <44EC8128.2040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:5804 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965117AbWHWTM0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 15:12:26 -0400
Received: by py-out-1112.google.com with SMTP id n25so348719pyg
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2006 12:12:25 -0700 (PDT)
In-Reply-To: <44EC8128.2040204@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com

On 8/23/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Hi Folks,
> >
> > I used Linux 2.6.18-rc2 with Jeff Garzik's git libata patch for new EH,
> > hotplug,
> > and pata support. Hardware is ARM IOP80321 with PCI-X. Host adapters
> > is pata Sil680.  The sequence of actions are "power off drive ->
> > remove drive -> power on drive -> add drive" and there's kernel errors
> > while adding the drive.  Complete dmesg traces attached. Has anyone
> > seen this problem before?
>
> Can you please try the latest -mm?
We have had issues with -mm to get it to run on our ARM IOP80321
board.  Do you have any patches which can be applied to 2.6.18 rc2?

>
> --
> tejun
>
