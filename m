From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 2/2] fastboot: use a DMI match table to set defaults
	for port-disable
Date: Tue, 12 Aug 2008 03:09:11 +0200
Message-ID: <1218503351.25524.28.camel@californication>
References: <20080811153542.61095e5c@infradead.org>
	 <20080811153730.74599410@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753018AbYHLBJt@vger.kernel.org>
In-Reply-To: <20080811153730.74599410@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Arjan,

> Subject: [PATCH] libata: use a DMI match table to set defaults for port-disable
> 
> As suggested by Jeff:
> This patch adds a DMI table that is used for setting defaults for
> the new dont-probe-port parameter boot time optimization feature.
> 
> Initially, the table only contains the Asus EeePC 901 as this is the
> device I have for testing.

last time I had mine open, I saw that the other ATA connectors are in
theory usable. You have to do some heavy modifications, but some people
do modifications to this kind of hardware to use it for really weird
purposes. We might wanna consider adding a module parameter to disable
the magic DMI table. Or do we expect them to always compile their own
kernel and know where to fix this? Thoughts?

Regards

Marcel
