From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata equivalent for hdX=remap63
Date: Thu, 6 Sep 2007 01:44:44 +0100
Message-ID: <20070906014444.4604e163@the-village.bc.nu>
References: <46DA73B5.5010107@ums.usu.ru>
	<20070902104645.0c6b291c@the-village.bc.nu>
	<46DC25D2.6090705@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mobileweb01.london.02.net ([193.113.235.167]:57066 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932250AbXIFAjD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 20:39:03 -0400
In-Reply-To: <46DC25D2.6090705@ums.usu.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-ide@vger.kernel.org, Mauelshagen@RedHat.com

> The first 64 KB of this hard disk can be found at 
> http://ums.usu.ru/~patrakov/first-64-kb.dsk (please tell me when I can 
> remove this file).

Thanks - it'll probably be after the kernel summit before anything
happens but the general question of using device mapper for this has been
raised there and looks a promising approach.

