From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: fix recovery time calculation
Date: Sat, 10 Feb 2007 01:14:54 +0100
Message-ID: <200702100114.54843.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702100129.35929.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:39514 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423373AbXBJAJs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 19:09:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1387005nfa
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 16:09:47 -0800 (PST)
In-Reply-To: <200702100129.35929.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Friday 09 February 2007 23:29, Sergei Shtylyov wrote:
> The driver wrongly takes the address setup time into account when calculating
> the PIO recovery time -- this leads to slight overclocking of the PIO modes 0
> and 1 (so, the prayers failed to help, as usual :-).  Rework the code to be
> calculating recovery clock count as a difference between the total cycle count
> and the active count (we don't need to calculate the recovery time itself since
> it's not specified for the PIO modes 0 to 2, and for modes 3 and 4 this formula
> gives enough recovery time anyway in the chip's supported PCI frequency range).
> 
> This patch has been inspired by reading the datasheets and looking at what the
> libata driver does; it has been compile-tested only (as usual :-) but anyway,
> the new code gives the same or longer recovery times than the old one...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
