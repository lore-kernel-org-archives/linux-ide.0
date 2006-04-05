From: "Lukasz Kosewski" <lkosewsk@gmail.com>
Subject: Re: register/unregister SATA drive
Date: Wed, 5 Apr 2006 12:04:12 -0400
Message-ID: <355e5e5e0604050904r1e14cfe5vf17a50ed52c57410@mail.gmail.com>
References: <4433E038.3040607@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:58748 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751137AbWDEQEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Apr 2006 12:04:13 -0400
Received: by pproxy.gmail.com with SMTP id i49so1117899pye
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 09:04:12 -0700 (PDT)
In-Reply-To: <4433E038.3040607@conterra.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: linux-ide@vger.kernel.org

Hey Dieter,

On 4/5/06, Dieter St=FCken <stueken@conterra.de> wrote:
> is it possible to unregister a single SATA port and to detach the dis=
k?
> how do I inform the kernel to rescan for a newly attached drive on th=
at
> port?

To actually do this, I direct you to
http://lkml.org/lkml/2005/12/29/216
http://lkml.org/lkml/2005/12/29/215

This is the last submitted version of my hotswap patches for libata,
which, assuming that you have a Promise controller, will go and
register unplugged and plugged devices for you.

Now of course, caveats:  those patches aren't updated for 2.6.16
because I haven't had time to do so and test them.  And, of course,
they work with some Promise controllers only.

Until they're a) revised to work with new libata EH, b) accepted and
c) more hardware support is layered on them, they might not help you
much.

You can use the patches to figure out how to write a system which does
what you want though, provided you add a way to hook the sata_hot_plug
and sata_hot_unplug methods from the command line, for instance.

Hope this alleviates the problem a bit,

Luke Kosewski
