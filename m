From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 4/2] ide-{floppy,tape}: remove request stack
Date: Wed, 6 Aug 2008 20:33:24 +0200
Message-ID: <58cb370e0808061133l724dc70do834ddcbc128af442@mail.gmail.com>
References: <200808061914.06361.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:51897 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbYHFSd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 14:33:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so26371fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 11:33:24 -0700 (PDT)
In-Reply-To: <200808061914.06361.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Wed, Aug 6, 2008 at 7:14 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

[...]

> ---
> pc stack can also be removed with a bit of care, we just need sth like:
>
> - add request_sense_pc (request_sense_rq alike)
>
> - dynamically allocate pc-s for blk_{fs,pc}_request() in ide-floppy.c
>  and for REQ_IDETAPE_{READ,WRITE} in ide-tape.c
>
> - add PC_FLAG_DYN for dynamically allocated pc-s
>
> - (the difficult part) figure out where to put freeing of dynamic pc-s
>
> Borislav, AFAIR you had some patches doing dynamic pc/rq-s?
> Maybe it would be possible to dust off just their rq-parts?

Please disregard above comments -- I found a better way to deal with rq stack.
