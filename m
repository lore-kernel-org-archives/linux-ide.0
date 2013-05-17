From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Fri, 17 May 2013 11:47:32 -0700
Message-ID: <20130517184732.GD12632@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305121213.47294.plr.vincent@gmail.com>
 <20130514190616.GU6795@mtj.dyndns.org>
 <201305171920.11127.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36980 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab3EQSxw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 May 2013 14:53:52 -0400
Received: by mail-qc0-f182.google.com with SMTP id n1so490785qcw.13
        for <linux-ide@vger.kernel.org>; Fri, 17 May 2013 11:53:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305171920.11127.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello, Vincent.

On Fri, May 17, 2013 at 07:20:10PM +0200, Vincent Pelletier wrote:
> From my (very limited) understanding, the bridge just passes the driv=
e's "id"=20
> (as in "atapi_id_dmadir(dev->id)") through. Is there another way to d=
etect=20
> such bridge ? Other things atapi_id_dmadir() should look for in "id" =
?

I don't think there's any way to detect bridges in a reliable way.

> If not, would it be possible to have a rw sysfs pseudofile per-device=
 (...per=20
> port ?) to enable DMADIR ?

Yeap, that sounds like the best we can do at this point.  Care to
write up a patch?

> From beca064485e3c86e4abe08b9ce5c89b33ed8c780 Mon Sep 17 00:00:00 200=
1
> Message-Id: <beca064485e3c86e4abe08b9ce5c89b33ed8c780.1368810901.git.=
plr.vincent@gmail.com>
> From: Vincent Pelletier <plr.vincent@gmail.com>
> Date: Fri, 17 May 2013 19:09:05 +0200
> Subject: libata: make ata_exec_internal_sg honor DMADIR
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Fixes SATA-to-PATA bridge "Abit Serillel 2" when used on an ATAPI dev=
ice,
> which otherwise fails several tries with a timeout until it gets disa=
bled:
>=20
>   kernel: ata5.00: qc timeout (cmd 0xa0)
>   kernel: ata5.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
>   kernel: ata5.00: disabled
>=20
> Based on a patch by Csaba Hal=E1sz <csaba.halasz@gmail.com> on linux-=
ide:
> http://marc.info/?l=3Dlinux-ide&m=3D136121147832295&w=3D2

While better, please go into more details.  The problem here is that
the bridge requires DMADIR and while libata makes use of DMADIR for
regular commands, it doesn't do that for internal commands which are
used during EH, right?  Please go into full details of what's going on
and be verbose.

Thanks!

--=20
tejun
