From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers (v2)
Date: Fri, 18 Nov 2005 21:41:14 +0100
Message-ID: <58cb370e0511181241r62d5248amb0cf4215ccdb6793@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B179A.8010600@gentoo.org> <436B3D74.3080807@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:10435 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161190AbVKRUlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Nov 2005 15:41:15 -0500
Received: by nproxy.gmail.com with SMTP id n28so6538nfc
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2005 12:41:14 -0800 (PST)
In-Reply-To: <436B3D74.3080807@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On 11/4/05, Daniel Drake <dsd@gentoo.org> wrote:
> Daniel Drake wrote:
> > Support multiple controllers in the via82cxxx IDE driver, revised patch.
> > Cable detection and ISA bridge finding have been moved into their own
> > functions.
> >
> > Unfortunately I won't have access to a via82cxxx machine until December
> > now, this patch is only compile-tested.
>
> I went home a little earlier than expected and tested this patch on my
> single-controller via machine. It works fine. Is this ok to be merged?

applied
