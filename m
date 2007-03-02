From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: add missing CONFIG_PM in LLDs
Date: Fri, 2 Mar 2007 13:19:25 +0000
Message-ID: <20070302131925.78b00f7d@lxorguk.ukuu.org.uk>
References: <20070302083001.GK20322@htj.dyndns.org>
	<20070302083126.GL20322@htj.dyndns.org>
	<20070302125732.2eb9e67e@lxorguk.ukuu.org.uk>
	<45E81266.3060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37887 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423053AbXCBMPS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 07:15:18 -0500
In-Reply-To: <45E81266.3060108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 02 Mar 2007 21:02:46 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> > Ughhhhhhhhh...
> > 
> > Can we not just provide dummy methods ?
> 
> I agree that it's ugly but LDDs often wrap standard routines and with
> the third patch all standard routines are gone thus forcing LLDs to omit
> PM functions if !CONFIG_PM.  If we supply dummy core functions, forcing
> LLDs to skip private PM functions is difficult.

If CONFIG_PM is not defined then they will not get called and they
generally wrap the functions that would become dummies ?

Am I missing something ?
