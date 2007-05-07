From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-mm1: many processes end up in D state
Date: Mon, 07 May 2007 11:52:45 +0200
Message-ID: <463EF6ED.7060404@gmail.com>
References: <200705052346.l45NksOb022632@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:27951 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbXEGJwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 05:52:51 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1490343nzf
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 02:52:50 -0700 (PDT)
In-Reply-To: <200705052346.l45NksOb022632@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Mikael Pettersson napsal(a):
> Jiri: please test the patch below instead. That is, revert to
> the original code _with_ the 'return 1;', and then add this
> patch to it. It should have pretty much the same effect as
> removing the 'return 1;', however calling ata_port_abort()
> is more in line with libata's new-style error handling.
> 
> /Mikael
> 
> --- linux-2.6.21-mm1/drivers/ata/sata_promise.c.~1~	2007-05-05 22:24:41.000000000 +0200
> +++ linux-2.6.21-mm1/drivers/ata/sata_promise.c	2007-05-05 22:25:21.000000000 +0200
> @@ -653,6 +653,8 @@ static void pdc_error_intr(struct ata_po
>  	qc->err_mask |= ac_err_mask;
>  
>  	pdc_reset_port(ap);
> +
> +	ata_port_abort(ap);
>  }
>  
>  static inline unsigned int pdc_host_intr( struct ata_port *ap,
> 

Yes, no freezing anymore.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
