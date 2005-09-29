From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/ide/via entry
Date: Thu, 29 Sep 2005 09:26:17 +0200
Message-ID: <58cb370e0509290026655a7bb1@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B16BD.7040409@gentoo.org> <20050928223718.GB7992@ftp.linux.org.uk>
	 <433B2081.9050607@gentoo.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:4325 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932145AbVI2H0V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Sep 2005 03:26:21 -0400
Received: by nproxy.gmail.com with SMTP id x37so584509nfc
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2005 00:26:17 -0700 (PDT)
In-Reply-To: <433B2081.9050607@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

Hi,

On 9/29/05, Daniel Drake <dsd@gentoo.org> wrote:
> Hi Al,
>
> (btw, original subject was wrong, I actually meant /proc/ide/via)
>
> Al Viro wrote:
> > Care to explain
> >       * where to get equivalent information?
>
> I don't think there is anywhere else that provides the whole range, but I do
> question the usefulness of most of it :)

Exactly, all the important information is available through other sources
(dmesg, lspci and of course /proc/ide/hd?/*) and configuration of timing
registers etc. shouldn't be of user concern (and it is available from PCI
configuration space so code to parse it can be easily moved to user-space).

Bartlomiej
