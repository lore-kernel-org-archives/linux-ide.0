From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 13:30:56 -0800
Message-ID: <20041221133056.6a5a3259.akpm@osdl.org>
References: <20041221202407.GD2725@artsapartment.org>
	<41C88F73.2090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:18054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbULUV04 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 16:26:56 -0500
In-Reply-To: <41C88F73.2090606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Art Haas wrote:
> > Hi.
> > 
> > This patch adds C99 initializers to the file. It can clearly wait until
> > after 2.6.10 is released if you want to send it to Linus.
> 
> The unpatched version is far more readable and maintainable.
> 

I was thinking the exact opposite ;)
