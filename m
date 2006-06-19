From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sometimes ata_piix fails to detect second SATA disk
Date: Mon, 19 Jun 2006 11:41:58 +0900
Message-ID: <44960EF6.4090205@gmail.com>
References: <20060618140650.GA17986@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:42411 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWFSCl6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jun 2006 22:41:58 -0400
Received: by wr-out-0506.google.com with SMTP id i31so923180wra
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2006 19:41:58 -0700 (PDT)
In-Reply-To: <20060618140650.GA17986@rigacci.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Niccolo Rigacci <niccolo@rigacci.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Niccolo Rigacci wrote:
> I'm trying to debug a strange problem on an IBM xSeries 206m 
> where I installed a Debian Testing with a self-compiled Linux 
> kernel 2.6.15.

Can you try just released 2.6.17?  ata_piix probing received some 
updates during 2.6.16 devel cycle and some fixes during .17.

-- 
tejun
