From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: convert some IDE semaphores to mutexes
Date: Wed, 11 Jan 2006 12:15:43 +0100
Message-ID: <58cb370e0601110315y7623e019t33d0569b0d8b5fc6@mail.gmail.com>
References: <1136973401.2929.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:35304 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbWAKLPv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jan 2006 06:15:51 -0500
Received: by nproxy.gmail.com with SMTP id o25so80830nfa
        for <linux-ide@vger.kernel.org>; Wed, 11 Jan 2006 03:15:44 -0800 (PST)
In-Reply-To: <1136973401.2929.27.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, mingo@elte.hu

On 1/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
> IDE uses some semaphores only in a mutex way; use the new
> mutexes for this
>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Could you also convert drivers/scsi/ide-scsi.c and add it to the patch?

Bartlomiej
