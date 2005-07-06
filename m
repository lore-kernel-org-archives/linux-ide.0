From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 09:34:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507060933330.20107@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:16773 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262263AbVGFQee (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2005 12:34:34 -0400
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> -	q = blk_init_queue_node(do_ide_request, &ide_lock,
> -				pcibus_to_node(drive->hwif->pci_dev->bus));
> +	int node = 0; /* Should be -1 */

Why is this not -1?

> +		int node = 0; 
> +		if (hwif->drives[0].hwif) { 

Also needs to be -1.

