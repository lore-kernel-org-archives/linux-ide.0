From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Tue, 5 Aug 2008 16:41:54 +0200
Message-ID: <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com>
References: <20080715053356.GA18628@gollum.tnic>
	 <20080802183253.GA2239@gollum.tnic>
	 <200808022046.16990.bzolnier@gmail.com>
	 <20080803073756.GA8762@gollum.tnic>
	 <20080803125907.67676948@lxorguk.ukuu.org.uk>
	 <20080803143837.GA26672@gollum.tnic>
	 <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
	 <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com>
	 <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:14525 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbYHEOl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 10:41:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1300495fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 07:41:54 -0700 (PDT)
In-Reply-To: <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 5, 2008 at 4:32 PM, Boris Petkov <petkovbb@googlemail.com> wrote:

[...]

> Will look into it later and redo the patch, thanks for reviewing. I
> still haven't heard from
> Bart, though, whether he's OK with the code duplication...?

Given Alan & Jeff concerns about moving it to <linux/ata.h>, just
copying the function to ide_generic seems like a best solution for now.
