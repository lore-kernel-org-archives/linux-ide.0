From: Andres Meyer <andres.meyer@computer.org>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Wed, 10 Mar 2004 08:31:34 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403100831.34416.andres.meyer@computer.org>
References: <200403100006.36405.andres.meyer@computer.org> <404EC21E.4030809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:44737 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262259AbUCJHcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2004 02:32:20 -0500
In-Reply-To: <404EC21E.4030809@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 10 March 2004 08.22, Jeff Garzik wrote:
> The sata_sil driver is known to have problems at the moment.  Are you
> having problems with drives connected to the Promise controller as well?
>   That seems to be working fine on x86, but I wonder if there are
> problems on x86-64.
>
> Can you try booting a 32-bit kernel to see if that changes your results?
>
> 	Jeff

As stated previously, It's a 32bit kernel, I did not event try 64bit SATA yet.

Andres

> SW:
> Linux 2.6.4-rc2 32bit
> ReiserFs 3
>
> HW:
> 2x Opteron 240, 3GB RAM
> Tyan 2885ANRF
> AMD8111: 1x Maxtor 80GB
> Promise SATA 150: 4x Maxtor 4G160J8 160GB with Marvel IDE2SATA adapters
> SII3114: 4x Maxtor 7Y250M0 250GB SATA
