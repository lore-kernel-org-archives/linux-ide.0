From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] ata: ahci: Enclosure Management via LED
Date: Wed, 5 Dec 2007 11:13:53 +0000
Message-ID: <20071205111352.GB3864@ucw.cz>
References: <20071129094802.49e729ed@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1451 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753364AbXLGVVY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 16:21:24 -0500
Content-Disposition: inline
In-Reply-To: <20071129094802.49e729ed@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

>  
> +static int ahci_em_messages = 1;
> +module_param(ahci_em_messages, int, 0444);
> +/* add other LED protocol types when they become supported */
> +MODULE_PARM_DESC(ahci_em_messages,
> +	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");

Should you add line in Doc* somewhere?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
