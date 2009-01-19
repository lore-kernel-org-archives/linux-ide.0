From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 19 Jan 2009 12:51:25 +0100
Message-ID: <200901191251.25880.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901161603.03699.stf_xl@wp.pl> <4970A8FF.4080404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:18182 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552AbZASLo6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 06:44:58 -0500
In-Reply-To: <4970A8FF.4080404@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

On Friday 16 January 2009 16:34, Sergei Shtylyov wrote:
> > I use t9 for calculating memory controller settings, but maybe it is
> > unneeded, pata_at91 don't use this value.
>
>     You mean pata_at32? It might have been that this detail was missed...
Yes at32 of course. Now I'm trying to figure out difference between settings
in at32 and my code. They differ, so one driver (I suspect my) is probably 
wrong.

Stanislaw Gruszka
