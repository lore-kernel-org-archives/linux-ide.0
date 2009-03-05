From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-{cd,floppy}: do not map all cmds to an sg
Date: Thu, 5 Mar 2009 16:19:57 +0100
Message-ID: <9ea470500903050719m7952f84ct56475c6445846eeb@mail.gmail.com>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com>
	 <200903051312.29784.bzolnier@gmail.com>
	 <9ea470500903050553m6ab9dfa5hab340213388a4c67@mail.gmail.com>
	 <200903051549.22518.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:51779 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZCEPUB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 10:20:01 -0500
In-Reply-To: <200903051549.22518.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

> Unrelated to the original issue that the patch tries to fix
> (sg mapping no data commands which OOPS-es w/ DEBUG_VIRTUAL=3Dy):
> - moving ide_init_sg_cmd()+ide_map_sg() to ide_issue_pc()
> - converting the code to use blk_rq_bytes()

aah, ok, now I could get exactly what you meant :). However, (!) ide-fl=
oppy is
potentially broken in the same way for data-less cmds since we uncondit=
ionally
map an rq to an sg there _too_. That was  the reason for the other chan=
ges. And
yes, I should've been more clear in the changelog.

> [ Moreover if you actually cared to write down the proper changelog
> =A0I'm pretty sure that you would ask yourself whether these changes
> =A0really belong to a bugfix patch... ]

--=20
Regards/Gruss,
Boris
