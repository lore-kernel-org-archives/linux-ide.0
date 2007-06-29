From: Alan Cox <alan@redhat.com>
Subject: Re: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 06:17:33 -0400
Message-ID: <20070629101733.GB25064@devserv.devel.redhat.com>
References: <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca> <46846b72.15588c0a.4c19.ffffeeb9@mx.google.com> <46846E3E.3010606@rtr.ca> <4684b61f.05358c0a.4c8f.30a5@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXF2KRh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 06:17:37 -0400
Content-Disposition: inline
In-Reply-To: <4684b61f.05358c0a.4c8f.30a5@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: 'Mark Lord' <liml@rtr.ca>, linux-ide@vger.kernel.org, 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@redhat.com>

On Fri, Jun 29, 2007 at 05:34:36PM +1000, Andrew Hall wrote:
> Further to this the PATA to SATA bridge being used in this case is:
> 
> http://www.jmicron.com/JM20330.html
> 
> ..as you will see only PIO and UDMA modes are supported.

In which case their microcontroller in the middle should be masking ident
bits. Without a way to detect the presence of the device I don't see an
easy way for us to handle it automatically at all

