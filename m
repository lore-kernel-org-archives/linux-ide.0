From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH REPOST 2.6.11-rc2 14/14] ide_pci: Merges serverworks.h into serverworks.c
Date: Sun, 6 Feb 2005 14:13:56 +0100
Message-ID: <58cb370e050206051349315961@mail.gmail.com>
References: <42032014.1020606@home-tj.org>
	 <20050204071319.0ED0E132703@htj.dyndns.org>
	 <20050205000136.GA2420@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.200]:32438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261235AbVBFNOA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 08:14:00 -0500
Received: by wproxy.gmail.com with SMTP id 67so718143wri
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 05:13:56 -0800 (PST)
In-Reply-To: <20050205000136.GA2420@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 09:01:36 +0900, Tejun Heo <tj@home-tj.org> wrote:
>  Sorry, the original #14 added back SVWKS_DEBUG_DRIVE_INFO which #13
> removed.  This is the regenerated patch.
> 
> 14_ide_pci_serverworks_merge.patch
> 
>         Merges ide/pci/serverworks.h into serverworks.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied

> +/*
> + *     Table of the various serverworks capability blocks
> + */

this comment doesn't really explain anything, dropped
