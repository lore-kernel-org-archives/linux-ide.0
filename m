From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Date: Wed, 16 Jun 2004 20:29:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040616182910.GC15365@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org> <20040616094737.GA2548@wohnheim.fh-wedel.de> <40D01928.1080309@tuxbox.org> <20040616100008.GB2548@wohnheim.fh-wedel.de> <20040616103741.042f8029.rddunlap@osdl.org> <20040616175730.GA15365@wohnheim.fh-wedel.de> <20040616111621.4d1fdfff.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.fh-wedel.de ([213.39.232.194]:17571 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264371AbUFPS3Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 14:29:16 -0400
Content-Disposition: inline
In-Reply-To: <20040616111621.4d1fdfff.rddunlap@osdl.org>
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 June 2004 11:16:21 -0700, Randy.Dunlap wrote:
> On Wed, 16 Jun 2004 19:57:30 +0200 J=F6rn Engel wrote:
>=20
> | On Wed, 16 June 2004 10:37:41 -0700, Randy.Dunlap wrote:
> | >=20
> | > Thanks for the helpful comments.  Here's a corrected patch.
> |=20
> | Looks, as if it still leaks memory:
>=20
> duh.  fudge.  Thanks.  How's this one?

Just four more lines?

>      link->dev =3D &info->node;
>      printk(KERN_INFO "ide-cs: %s: Vcc =3D %d.%d, Vpp =3D %d.%d\n",
> -	   info->node.dev_name, link->conf.Vcc/10, link->conf.Vcc%10,
> -	   link->conf.Vpp1/10, link->conf.Vpp1%10);
> +	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
> +	   link->conf.Vpp1 / 10, link->conf.Vpp1 % 10);
> =20
>      link->state &=3D ~DEV_CONFIG_PENDING;
+    kfree(cisparse);
+    kfree(cfginfo);
+    kfree(def_cte);
+    kfree(tbuf);
>      return;
> -   =20
> +
> +err_mem:
> +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\=
n");
> +    goto failed;
> +
>  cs_failed:
>      cs_error(link->handle, last_fn, last_ret);
>  failed:
> +    kfree(cisparse);
> +    kfree(cfginfo);
> +    kfree(def_cte);
> +    kfree(tbuf);
> +
>      ide_release(link);
>      link->state &=3D ~DEV_CONFIG_PENDING;
> -
>  } /* ide_config */
> =20
>  /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

J=F6rn

--=20
=46ancy algorithms are slow when n is small, and n is usually small.
=46ancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
