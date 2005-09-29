From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Date: Thu, 29 Sep 2005 09:27:37 +0200
Message-ID: <58cb370e0509290027404f5224@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B16BD.7040409@gentoo.org>
	 <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:3827 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932154AbVI2H1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Sep 2005 03:27:38 -0400
Received: by nproxy.gmail.com with SMTP id x37so584615nfc
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2005 00:27:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Daniel Drake <dsd@gentoo.org>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On 9/29/05, Grzegorz Kulewski <kangur@polcom.net> wrote:
> On Wed, 28 Sep 2005, Daniel Drake wrote:
>
> > This entry adds needless complication to the driver as it requires the use of
> > global variables to be passed into via_get_info(), making things quite ugly
> > when we try and make this driver support multiple controllers simultaneously.
> >
> > This patch removes /proc/via for simplicity.
>
> Is similar data available from sysfs?
>
> As a user of this controller, I think that if it is not then this patch
> should be changed to export it or should be dropped. The data from that
> file is really helpfull in debugging problems (for example related to bad
> cables or breaking disks/cdroms).

Could you please give some details (which data is useful)?

Bartlomiej
