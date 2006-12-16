From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Missing sff fix for the PCI updates
Date: Sat, 16 Dec 2006 10:57:19 -0500
Message-ID: <4584175F.9060004@pobox.com>
References: <20061215221247.1e0313a8@localhost.localdomain> <Pine.LNX.4.64.0612151826511.3557@woody.osdl.org> <458367B2.2010907@pobox.com> <20061216115917.1d9cd814@localhost.localdomain> <45840B44.8030408@pobox.com> <20061216154658.64cb2d42@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34582 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161112AbWLPP5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 10:57:21 -0500
In-Reply-To: <20061216154658.64cb2d42@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

BTW2: if you make probe_ent per-port, rather than per-controller, we can 
trivially support all these PATA+SATA controllers.

	Jeff



