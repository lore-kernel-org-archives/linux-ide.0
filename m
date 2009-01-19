From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Sun, 18 Jan 2009 16:29:48 -0800
Message-ID: <200901181629.48348.david-b@pacbell.net>
References: <200901180833.53969.david-b@pacbell.net> <4973635A.2050302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:36949 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754084AbZASA3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 19:29:50 -0500
In-Reply-To: <4973635A.2050302@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Sunday 18 January 2009, Sergei Shtylyov wrote:
> > Someone should fix hw_regs_t to neither be a typedef, nor
> > use "unsigned long" where it should use "void __iomem *".
>=20
> =A0 =A0 It cannot use pointers of course -- as the addresses can be I=
/O ports.

It could use the ioread*() calls, which take pointers
and handle both types of I/O in a type-safe manner.

- Dave



