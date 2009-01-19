From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 17:37:01 +0000
Message-ID: <20090119173701.13fd24c6@lxorguk.ukuu.org.uk>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
	<20090119130322.24745.76137.sendpatchset@localhost.localdomain>
	<49748B95.9080105@ru.mvista.com>
	<200901191523.15240.bzolnier@gmail.com>
	<49748E43.4030009@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41624 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752210AbZASRgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 12:36:53 -0500
In-Reply-To: <49748E43.4030009@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > [ I'm also not happy with the naming but couldn't think of a better one. ]
> 
>     Legacy perhaps?

Legacy to most people means either ISA/VLB or the PCI legacy
compatibility mode so that would be confusing.

BTW if you moved to ioreadX you could get rid of almost all the readb/inb
special casing.
