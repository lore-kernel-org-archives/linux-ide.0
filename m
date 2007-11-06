From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/15] ide: remove atapi_ireason_t
Date: Tue, 06 Nov 2007 21:01:58 +0300
Message-ID: <4730AC16.2040401@ru.mvista.com>
References: <200710310028.27935.bzolnier@gmail.com> <200711022121.24688.bzolnier@gmail.com> <472DDDD6.8030806@ru.mvista.com> <200711052124.57782.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33493 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754704AbXKFSBr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 13:01:47 -0500
In-Reply-To: <200711052124.57782.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Thanks!

> [ Heh, after "take 2" I had a feeling that something still may be not right
>   so I deferred committing of this patch series to the official tree... :) ]

> [PATCH] ide: remove atapi_ireason_t (take 3)

> Remove atapi_ireason_t.

> While at it:
> * replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

> v2:
> * v1 had CD and IO bits reversed in many places.

> * Use CD and IO defines from <linux/hdreg.h>.

> v3:
> * Fix incorrect "(ireason & IO) == test_bit()". (Noticed by Sergei)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
