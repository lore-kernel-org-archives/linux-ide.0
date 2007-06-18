From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Tue, 19 Jun 2007 09:01:24 +1000
Message-ID: <46770edc.101d640a.4fdf.4eae@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:62065 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbXFRXBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 19:01:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so367033and
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 16:01:48 -0700 (PDT)
In-Reply-To: <20070618125742.28a0bc57@the-village.bc.nu>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

> >
> > For some reason, mwdma doesn't work in libata now.  I'm not sure why
> > tho.  Alan, can you enlighten us?
> 
> No idea at all. All my hardware is still happy. 2.6.20 is an "old"
> kernel
> however so it does predate the fixes you did for ata_piix mode setup ?

Old - yes, but more stable in all other respects it seems to the .21 series.
Are these patches available for me to try on .20 or are there dependencies
on 21? 

