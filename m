From: Eric Mudama <edmudama@gmail.com>
Subject: Re: Driver retries disk errors.
Date: Thu, 2 Sep 2004 10:23:39 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <311601c904090209235759c7a2@mail.gmail.com>
References: <20040830163931.GA4295@bitwizard.nl>
	 <20040830174632.GA21419@thunk.org>  <41337153.60505@superbug.demon.co.uk> <1093952325.32684.7.camel@localhost.localdomain>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.206]:35490 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268657AbUIBQXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2004 12:23:40 -0400
Received: by mproxy.gmail.com with SMTP id 76so300315rnl
        for <linux-ide@vger.kernel.org>; Thu, 02 Sep 2004 09:23:39 -0700 (PDT)
In-Reply-To: <1093952325.32684.7.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Courtier-Dutton <james@superbug.demon.co.uk>, Theodore Ts'o <tytso@mit.edu>, Rogier Wolff <r.e.wolff@harddisk-recovery.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, 31 Aug 2004 12:38:45 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Not really as far as I can tell. It isn't a disk any more, its a storage
> appliance on a funny connector. It already knows a lot about retries
> internally as well as rewriting blocks with high ECC error
> count. In fact you actually have to issue a different command to do
> read/write without retry.

True, but in the later versions of the ATA specification, the retry
option was depreciated.  I think you'll find virtually every ATA drive
built today ignores that "suggestion" from the host.

--eric
