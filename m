From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 05/11] ata: replace macro with static inline in libata.h
Date: Thu, 14 Feb 2008 09:38:25 -0800
Message-ID: <1203010705.2748.46.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
	 <1202966058.2748.19.camel@brick>  <20080214120101.150a3284@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:29996 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbYBNR7d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 12:59:33 -0500
Received: by wx-out-0506.google.com with SMTP id h31so384504wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 09:59:32 -0800 (PST)
In-Reply-To: <20080214120101.150a3284@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 2008-02-14 at 12:01 +0000, Alan Cox wrote:
> On Wed, 13 Feb 2008 21:14:18 -0800
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Avoid a metric ton of sparse warnings like:
> > drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
> > drivers/ata/pata_ali.c:176:14: originally declared here
> 
> NAK that appears to be a sparse bug.
> 
> 1-4/6-10 Acked-by: Alan Cox <alan@redhat.com>
> 

No worries, for something like this it had better be obviously correct
or not applied.  I will try to come up with something more palatable.

Harvey

