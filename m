From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 01/14] ide_pci: Remove lousy macros from aec62xx.
Date: Sun, 6 Feb 2005 01:01:07 +0100
Message-ID: <58cb370e050205160143c11876@mail.gmail.com>
References: <42032014.1020606@home-tj.org>
	 <20050204071317.A06E013264C@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:32104 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264391AbVBFABI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2005 19:01:08 -0500
Received: by wproxy.gmail.com with SMTP id 67so679694wri
        for <linux-ide@vger.kernel.org>; Sat, 05 Feb 2005 16:01:08 -0800 (PST)
In-Reply-To: <20050204071317.A06E013264C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:17 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 01_ide_pci_aec62xx_cleanup.patch
> 
>         Removes SPLIT_BYTE, MAKE_WORD and BUSCLOCK macros which are
>         just better off directly coded from ide/pci/aec62xx driver.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied but I left BUSCLOCK() alone for now
