From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 1/13] ide hotplug mark __devinit alim15x3.c
Date: Sun, 3 Jul 2005 17:11:49 +0200
Message-ID: <58cb370e050703081118380728@mail.gmail.com>
References: <20050626164557.GI12811@sputnik.stro.at>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:9653 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVGCPLu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 11:11:50 -0400
Received: by nproxy.gmail.com with SMTP id o25so125592nfa
        for <linux-ide@vger.kernel.org>; Sun, 03 Jul 2005 08:11:49 -0700 (PDT)
In-Reply-To: <20050626164557.GI12811@sputnik.stro.at>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <janitor@sternwelten.at>
Cc: linux-ide@vger.kernel.org

Hi,

All patches except #3 merged.
[ cmd640 is not using PCI core -> patch #3 rejected ]

Thanks,
Bartlomiej

On 6/26/05, maximilian attems <janitor@sternwelten.at> wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> mark the __init section __devinit.
> Splitted up from the Debian kernel patch.
> 
> see the thread about the pci hotplug crash on a stratus box.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111930108613386&w=2
> 
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>
