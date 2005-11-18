From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Date: Fri, 18 Nov 2005 21:39:29 +0100
Message-ID: <58cb370e0511181239n369c9a88hd9292055e4d03d92@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B16BD.7040409@gentoo.org>
	 <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
	 <58cb370e0509290027404f5224@mail.gmail.com>
	 <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
	 <434EE534.6010500@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.199]:7919 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161185AbVKRUjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Nov 2005 15:39:31 -0500
Received: by nproxy.gmail.com with SMTP id x4so7183nfb
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2005 12:39:29 -0800 (PST)
In-Reply-To: <434EE534.6010500@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On 10/13/05, Daniel Drake <dsd@gentoo.org> wrote:
> Hi,
>
> Grzegorz Kulewski wrote:
> >>> As a user of this controller, I think that if it is not then this patch
> >>> should be changed to export it or should be dropped. The data from that
> >>> file is really helpfull in debugging problems (for example related to
> >>> bad
> >>> cables or breaking disks/cdroms).
>
> Per Bart's suggestion, I've created a user-space app which shows identical
> data (and doesn't even rely on the via82cxxx IDE driver).
>
> http://www.reactivated.net/software/viaideinfo/
>
> So, I think we should be clear to drop /proc/ide/via now.

patch applied, thanks for working on this
