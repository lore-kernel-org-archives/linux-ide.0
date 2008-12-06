From: Dan =?UTF-8?B?Tm/DqQ==?= <dpn@isomerica.net>
Subject: Re: MCP55 disk activity LEDs don't flash
Date: Sat, 6 Dec 2008 12:05:33 -0500
Message-ID: <20081206120533.48025219@tuna>
References: <493A8767.5030200@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colobus.isomerica.net ([216.93.242.10]:42610 "EHLO
	colobus.isomerica.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbYLFRFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Dec 2008 12:05:35 -0500
In-Reply-To: <493A8767.5030200@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

On Sat, 06 Dec 2008 06:08:39 -0800
Yan Seiner <yan@seiner.com> wrote:

> I have a 6 slot server case with a backplane.  AFAICT the backplane
> is passive and there are SATA cables that lead from the backplane to
> the mobo.
>=20
> The problem is that the disk activity LEDs for the slots don't flash
> at all.  The mobo is an ASUS M2N SLI Deluxe, which has the MCP55
> controller.
>=20
> The drive activity LED which plugs into the mobo works just fine; the=
=20
> individual LEDs for each of the drives don't flash - they just stay
> on. Is there something I can enable to make them work?  Or is the
> backplane broken?

I have a Tyan Transport GT20 and the individual drive bay LEDs don't
work at all.  Annoying, but I'm not physically near the system that
much.  If I recall correctly, on the GT20 the backplane didn't have the
capability to light the LEDs (although then I don't understand wtf
there are LEDs there... perhaps Windows has some way of lighting them).

Cheers,
Dan

--=20
                    /--------------- - -  -  -   -   -
                   |  Dan No=C3=A9
                   |  http://isomerica.net/~dpn/
