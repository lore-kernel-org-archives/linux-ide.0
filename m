From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: minor IDE clean up I noticed
Date: Thu, 30 Sep 2004 20:05:36 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409302005.36089.bzolnier@elka.pw.edu.pl>
References: <20040930175430.GA688@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51652 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269416AbUI3UjS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Sep 2004 16:39:18 -0400
In-Reply-To: <20040930175430.GA688@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


fixed 4 days ago in ide-dev-2.6 :)

On Thursday 30 September 2004 19:54, Alan Cox wrote:
> Nowdays a drive always has a driver
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c linux-2.6.9rc3/drivers/ide/ide-proc.c
> --- linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 15:35:48.169975152 +0100
> +++ linux-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 16:33:46.423200288 +0100
> @@ -365,20 +365,7 @@
>  	{
>  		unsigned short *val = (unsigned short *) page;
>  		
> -		/*
> -		 *	The current code can't handle a driverless
> -		 *	identify query taskfile. Now the right fix is
> -		 *	to add a 'default' driver but that is a bit
> -		 *	more work. 
> -		 *
> -		 *	FIXME: this has to be fixed for hotswap devices
> -		 */
> -		 
> -		if(DRIVER(drive))
> -			err = taskfile_lib_get_identify(drive, page);
> -		else	/* This relies on the ID changes */
> -			val = (unsigned short *)drive->id;
> -
> +		err = taskfile_lib_get_identify(drive, page);
>  		if(!err)
>  		{						
>  			char *out = ((char *)page) + (SECTOR_WORDS * 4);
