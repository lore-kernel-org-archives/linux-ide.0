From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: More IDE hackery
Date: Wed, 3 Nov 2004 21:17:27 +0100
Message-ID: <58cb370e041103121750aab62b@mail.gmail.com>
References: <1099487809.29560.28.camel@localhost.localdomain>
	 <58cb370e04110309146ad102fc@mail.gmail.com>
	 <1099501714.29846.71.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.201]:24593 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261835AbUKCUR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 15:17:28 -0500
Received: by rproxy.gmail.com with SMTP id i8so151706rne
        for <linux-ide@vger.kernel.org>; Wed, 03 Nov 2004 12:17:28 -0800 (PST)
In-Reply-To: <1099501714.29846.71.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Wed, 03 Nov 2004 17:08:35 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > It won't work unless you modify ide_register_hw().
> > See ide_register_hw() vs "initializing == 1".
> 
> I changed that to allow a fixup to be passed as well. That causes most
> of the noise changes but I could make that ide_register_hw_with_fixup()
> to avoid changes elsewhere adding NULL to ide_register_hw calls.  Which
> would you prefer and I'll go make full patches

Sounds good, please make ide_register_hw_with_fixup().
