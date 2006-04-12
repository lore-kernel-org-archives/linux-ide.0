From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE CDROM tail read errors
Date: Wed, 12 Apr 2006 09:57:39 +0100
Message-ID: <1144832260.1952.13.camel@localhost.localdomain>
References: <m3wtedrrpf.fsf@defiant.localdomain>
	 <1143717489.29388.32.camel@localhost.localdomain>
	 <4432C460.3080606@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5612 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932114AbWDLIsh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 04:48:37 -0400
In-Reply-To: <4432C460.3080606@tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Maw, 2006-04-04 at 15:09 -0400, Bill Davidsen wrote:
> Any hope in hell of getting this fixed? It's been broken for too long to 
> remember. IIRC the problem is that on a read which hits EOF, instead of 

The libata layer doesn't have the problem. So it will get fixed as the
libata PATA stuff gets upstream and merged

