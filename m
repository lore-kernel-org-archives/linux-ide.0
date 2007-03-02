From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: add missing CONFIG_PM in LLDs
Date: Fri, 02 Mar 2007 21:02:46 +0900
Message-ID: <45E81266.3060108@gmail.com>
References: <20070302083001.GK20322@htj.dyndns.org>	<20070302083126.GL20322@htj.dyndns.org> <20070302125732.2eb9e67e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:62188 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbXCBMCr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 07:02:47 -0500
Received: by py-out-1112.google.com with SMTP id a29so418521pyi
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 04:02:47 -0800 (PST)
In-Reply-To: <20070302125732.2eb9e67e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ughhhhhhhhh...
> 
> Can we not just provide dummy methods ?

I agree that it's ugly but LDDs often wrap standard routines and with
the third patch all standard routines are gone thus forcing LLDs to omit
PM functions if !CONFIG_PM.  If we supply dummy core functions, forcing
LLDs to skip private PM functions is difficult.
ata_scsi_device_suspend/resume() will disappear soon, so the clutter
will be reduced.  Any prettier ideas?

-- 
tejun
