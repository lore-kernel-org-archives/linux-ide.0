From: Willy Gardiol <gardiol@libero.it>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Tue, 31 Dec 2002 12:14:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200212311214.20170.gardiol@libero.it>
References: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I am having this same OOPS with 2.4.20!

i will try your patch...

Alle 10:47, gioved=EC 13 marzo 2003, Herbert Xu ha scritto:
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>
> > 00000000 <_EIP>:
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=3D=3D=3D=3D=3D
> >   0:   ff 42 18                  incl   0x18(%edx)   <=3D=3D=3D=3D=3D
> > Code;  c0213ab6 <idescsi_pc_intr+66/360>
> >   3:   89 3c 24                  mov    %edi,(%esp,1)
> > Code;  c0213ab9 <idescsi_pc_intr+69/360>
> >   6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
> > Code;  c0213ac0 <idescsi_pc_intr+70/360>
> >   d:   00
> > Code;  c0213ac1 <idescsi_pc_intr+71/360>
> >   e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1>
> > c0213774 <idescsi_do_end_request+a4/e0> Code;  c0213ac6
> > <idescsi_pc_intr+76/360>
> >  13:   31 00                     xor    %eax,(%eax)
>
> Does this patch fix the problem?

- --=20

!=20
 Willy Gardiol - gardiol@libero.it
 goemon.polito.it/~gardiol
 Use linux for your freedom.

   "La guerra non far=E0 mai finire=20
    alcuna guerra, nel migliore dei
    casi sar=E0 stata una guerra in pi=F9."

      Gino Strada, Buskash=EC

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+EXwLQ9qolN/zUk4RAuBXAKCZMpMDJ4O/NUGMSEkg8/gjKIsyEACgsZ0+
ps7JTUlVNud4O8F00jDp4b8=3D
=3DpImM
-----END PGP SIGNATURE-----

