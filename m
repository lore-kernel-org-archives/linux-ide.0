From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 07:06:16 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084626376.3079.8.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.534
	 3.	26.camel@patibmrh9> <1084579362.3271.5.camel@patibmrh9><40A5669B.608010
	8@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:65254 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262388AbUEONGn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 09:06:43 -0400
In-Reply-To: <40A5669B.6080108@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > Results follow.  Much improved now, yes?
> 
> Yep, that's definitely a Silicon Image bridge all right :)
> 
> Here's a better version of the patch you generated.
> 
> ...
> +	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
> ...

Thank you.

I name this patch.6 as in a virtual thread titled:

    [PATCH] libata atapi work #6

I doubt I can use this patch as is.  I believe, because I assembled my
drive from components myself, its op xA1 Identify data has not changed,
so I will see a misleading 0 False at:

#define ata_id_use_dmadir(dev) ((dev)->id[62] & (1 << 15))

I will work to confirm/ deny that theory.

Pat LaVarre


