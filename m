From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Sat, 27 Sep 2008 19:04:37 +0200
Message-ID: <200809271904.38023.bzolnier@gmail.com>
References: <20080921185138.GA16310@localhost> <20080924071055.GB16949@gollum.tnic> <48DA0A39.3070308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:26434 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYI0R3B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:29:01 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1168367muf.1
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:29:00 -0700 (PDT)
In-Reply-To: <48DA0A39.3070308@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: petkovbb@gmail.com, Mark de Wever <koraq@xs4all.nl>, Gadi Oxman <gadio@netvision.net.il>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 24 September 2008, Sergei Shtylyov wrote:

[...]

> > Subject: ide-tape: fix vendor strings
> >
> > Remove superfluous two bytes from each string buffer and add proper length
> > format specifiers.
> >
> > There should be no functional change resulting from this patch.
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > Tested-by: Mark de Wever <koraq@xs4all.nl>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
