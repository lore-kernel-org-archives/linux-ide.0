From: Tejun Heo <htejun@gmail.com>
Subject: Re: commit a258f183ee4e48e9352b408e8448467eebdc6cd2
Date: Wed, 02 Jan 2008 23:33:27 +0900
Message-ID: <477BA0B7.3030509@gmail.com>
References: <477B5AAE.7070008@gmail.com>	<20080102134859.17e75789@the-village.bc.nu>	<477B9E9E.3000104@gmail.com> <20080102141937.62d49c5e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:57331 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbYABOde (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 09:33:34 -0500
Received: by po-out-1718.google.com with SMTP id c31so4023956poi.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 06:33:33 -0800 (PST)
In-Reply-To: <20080102141937.62d49c5e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Wed, 02 Jan 2008 23:24:30 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Alan Cox wrote:
>>> On Wed, 02 Jan 2008 18:34:38 +0900
>>> Tejun Heo <htejun@gmail.com> wrote:
>>>
>>>> Happy new year, Jeff, Alan.
>>>>
>>>> I'm curious why commit a258f183 got in?  
>>> Whats that commit in real code ?
>> The attached one.
> 
> Ok I don't see how that is related to the switch to polling. The
> old IDE code found it neccessary and always did polling.

ata_host_intr() is just never traveled while executing SETXFER because
SETXFERs are executed using polling which nicely works around quirky
controllers which raises interrupt a tad bit too early during SETXFER.

-- 
tejun
