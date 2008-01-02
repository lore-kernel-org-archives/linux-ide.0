From: Tejun Heo <htejun@gmail.com>
Subject: Re: commit a258f183ee4e48e9352b408e8448467eebdc6cd2
Date: Thu, 03 Jan 2008 00:52:59 +0900
Message-ID: <477BB35B.3060309@gmail.com>
References: <477B5AAE.7070008@gmail.com>	<20080102134859.17e75789@the-village.bc.nu>	<477B9E9E.3000104@gmail.com>	<20080102141937.62d49c5e@the-village.bc.nu>	<477BA0B7.3030509@gmail.com> <20080102151831.184c8055@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:46019 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYABPxH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 10:53:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5314212rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 07:53:05 -0800 (PST)
In-Reply-To: <20080102151831.184c8055@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> ata_host_intr() is just never traveled while executing SETXFER because
>> SETXFERs are executed using polling which nicely works around quirky
>> controllers which raises interrupt a tad bit too early during SETXFER.
> 
> Ok

Okay.  Jeff, can you please revert the commit?  Thanks.

-- 
tejun
