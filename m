From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Date: Fri, 1 Dec 2006 13:41:08 +0100
Message-ID: <20061201124108.GB11084@stusta.de>
References: <4569F703.8010209@shaw.ca> <456BF5C1.9010506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031257AbWLAMlE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 07:41:04 -0500
Content-Disposition: inline
In-Reply-To: <456BF5C1.9010506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Nicolas.Mailhot@LaPoste.net

On Tue, Nov 28, 2006 at 03:39:29AM -0500, Jeff Garzik wrote:
>...
> In the future, please use "---" not "--" as the separator your .sig, so 
> that it is not copied into the kernel changelog by git-applymbox.
>...

"-- " is the standard separator most MUAs can interpret - "---" would 
therefore be wrong.

Perhaps git-applymbox should be fixed?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

