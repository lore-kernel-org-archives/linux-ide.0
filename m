From: Tejun Heo <tj@kernel.org>
Subject: Re: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Tue, 7 Jun 2016 09:11:42 -0500
Message-ID: <20160607141142.GV31708@htj.duckdns.org>
References: <87vb1mwz73.fsf@fsfe.org>
 <CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
 <20160606135422.GU31708@htj.duckdns.org>
 <87porue7n6.fsf@mm.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33904 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbcFGOLo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2016 10:11:44 -0400
Received: by mail-oi0-f52.google.com with SMTP id e72so278262356oib.1
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2016 07:11:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87porue7n6.fsf@mm.st>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Brubeck Unhammer <unhammer@fsfe.org>
Cc: "Navin P.S" <navinp1912@gmail.com>, linux-ide@vger.kernel.org

On Mon, Jun 06, 2016 at 04:03:57PM +0200, Kevin Brubeck Unhammer wrote:
> dmesg from 4.2 is attached; from 4.6 I'm not sure how to get it =E2=80=
=A6
>=20
> perhaps I could mount a USB-stick through a
> /etc/initramfs-tools/scripts/init-premount/ script, I'll try this lat=
er
> (I'm travelling this week, so might be a bit delayed).

You can also use serial or netconsole.

Thanks.

--=20
tejun
