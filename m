From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/9] ide-atapi: remove ide_atapi_pc from the irq handler
Date: Wed, 17 Dec 2008 20:29:56 +0100
Message-ID: <20081217192956.GA6316@gollum.tnic>
References: <1229412969-3552-1-git-send-email-petkovbb@gmail.com> <200812162135.27902.bzolnier@gmail.com> <20081217072543.GA828@gollum.tnic> <200812171745.41830.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36289 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYLQT34 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Dec 2008 14:29:56 -0500
Received: by bwz14 with SMTP id 14so204167bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 11:29:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200812171745.41830.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

> [ Yes, I'm a bit disappointed that 2.6.29 is going to be the next release
>   that we will miss on ide-cd -> ide-atapi conversion (I was initially
>   hoping for .28) and the fact that in few weeks this will become a limiting
>   factor to the further progress on core IDE changes (despite few issues
>   to still take care of things are starting to look really well there)... ]

ok, I get the idea, and I'm sorry for mis-prioritizing the things we
have to work on but it's not like I've been idling - as you're well
aware, we had a couple of nasty bugs in the past months which had to be
taken care of.

Anyways, I don't think it is too late yet for .29 since the merge window
is not open yet and I might whip up some patches in the next couple of
days...

-- 
Regards/Gruss,
    Boris.
