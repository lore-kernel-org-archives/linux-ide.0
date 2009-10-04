From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Mon, 5 Oct 2009 00:37:05 +0200
Message-ID: <20091004223705.GB5030@dis.manty.net>
References: <20090930110529.GA3676@dis.manty.net>
 <20091001.114755.132624639.davem@davemloft.net>
 <20091001.115310.100974682.davem@davemloft.net>
 <20091003033942.GA8129@dis.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757494AbZJDWiK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091003033942.GA8129@dis.manty.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Applied it to 2.6.31.1, I'll wait and see what the weekend tells us.

up 2 days,  8:27 and still nothing, maybe I shouldn't have applied it t=
o .1
as some of the fixes there could be masking the problem and I should be
testing it on 2.6.31 :-?

What do you think about, that, should I compile a plain 2.6.31? or shou=
ld I
give 2.6.31.1 some more time?

On the other hand when I tried to compile a kernel for a non IDE machin=
e out
of the same 2.6.31.1 patched sources I found this error:

ERROR: "ide_kill_rq" [drivers/ide/ide-gd_mod.ko] undefined!
make[2]: *** [__modpost] Erro 1
make[1]: *** [modules] Erro 2
make[1]: Sa=EDndo do directorio `/usr/src/linux-2.6.31'

After reverting the patch it compiled ok, of course, I was wondering if=
 this
only affects the modules build and for the test we are having I have ID=
E in
the kernel, so no problem with that, or if that can affect the IDE kern=
el as
well and it may break because of the patch or something.

Regards...
--=20
Manty/BestiaTester -> http://manty.net
