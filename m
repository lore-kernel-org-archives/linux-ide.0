From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: Use the fixup layer to fix the various SI3112 hangs
Date: Sat, 6 Nov 2004 00:24:13 +0100
Message-ID: <58cb370e041105152431299ff7@mail.gmail.com>
References: <1099672950.5630.59.camel@localhost.localdomain>
	 <58cb370e04110514594adcb6e2@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:9304 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261275AbUKEXYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 18:24:16 -0500
Received: by rproxy.gmail.com with SMTP id a36so134919rnf
        for <linux-ide@vger.kernel.org>; Fri, 05 Nov 2004 15:24:13 -0800 (PST)
In-Reply-To: <58cb370e04110514594adcb6e2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 5 Nov 2004 23:59:09 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> all fixup patches applied
> (after merging into 2 changesets & cleanup)

and fixed bug preventing both fixups from correct working,
fixup() must be called _before_ hwif_init() call!!!
