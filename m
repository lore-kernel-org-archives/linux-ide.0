From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: support for Lindy 51130?
Date: Mon, 23 Jan 2006 19:31:29 +0100
Message-ID: <58cb370e0601231031j38dcec66sa3fcc67ea405045a@mail.gmail.com>
References: <m3r76yop4c.fsf@pixie.isrnet>
	 <58cb370e0601230919m6f78fb28h35a4470b4e92b785@mail.gmail.com>
	 <m3mzhmom7k.fsf@pixie.isrnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.197]:39612 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964868AbWAWSbc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jan 2006 13:31:32 -0500
Received: by uproxy.gmail.com with SMTP id s2so34029uge
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2006 10:31:29 -0800 (PST)
In-Reply-To: <m3mzhmom7k.fsf@pixie.isrnet>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-ide@vger.kernel.org

On 1/23/06, Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
>
> Thanks. According to the second link you gave, it seems well
> supported.

Just to clarify things:

"Summary: Full TCQ/NCQ support, with full SATA control including
hotplug and PM."

These are _hardware_ features, they are not currently supported in
the vanilla kernels (however they are under active development).

"libata driver status: beta. "
                                ^^^^

That is why I said that others should know more details, I don't.

Bartlomiej
