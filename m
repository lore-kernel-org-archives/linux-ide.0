From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 01/29] ide: remove adma100
Date: Thu, 3 Feb 2005 00:43:40 +0100
Message-ID: <58cb370e05020215431cda8303@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024353.GB621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.195]:3817 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262714AbVBBXns (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 18:43:48 -0500
Received: by wproxy.gmail.com with SMTP id 67so160913wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 15:43:40 -0800 (PST)
In-Reply-To: <20050202024353.GB621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:43:53 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 01_ide_remove_adma100.patch
> >
> >       Removes drivers/ide/pci/adma100.[hc].  The driver isn't
> >       compilable (missing functions) and no Kconfig actually enables
> >       CONFIG_BLK_DEV_ADMA100.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
