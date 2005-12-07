From: Tejun <htejun@gmail.com>
Subject: Re: 2.6.15-rc5-mm1 sata_sil regression
Date: Wed, 07 Dec 2005 21:48:09 +0900
Message-ID: <4396DA09.8040800@gmail.com>
References: <4396CB79.5040408@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:26439 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751020AbVLGMsV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2005 07:48:21 -0500
Received: by zproxy.gmail.com with SMTP id 13so361892nzn
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 04:48:21 -0800 (PST)
In-Reply-To: <4396CB79.5040408@bootc.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Boot <bootc@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Chris Boot wrote:
> Hi all,
> 
> I just upgraded to 2.6.15-rc5-mm1 from 2.6.15-rc2-mm1 and sata_sil 
> refused to recognise the two SATA drives that are connected to it:
> 

The sata_sil driver in the current ALL branch doesn't work due to the 
collision between pio changes and sata_sil irq handling improvements.

Jeff, maybe the sil branch shouldn't be merged into ALL for the time being?

-- 
tejun
