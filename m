From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/8] libata: move ata_set_mode() to libata-eh.c
Date: Wed, 05 Dec 2007 10:21:54 +0900
Message-ID: <4755FD32.7070907@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593392856-git-send-email-htejun@gmail.com> <4751E921.9060108@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:22007 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbXLEBWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:22:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3394481rvb
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:22:10 -0800 (PST)
In-Reply-To: <4751E921.9060108@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Move ata_set_mode() to libata-eh.c.  ata_set_mode() is surely an EH
>> action and will be more tightly coupled with the rest of error
>> handling.  Move it to libata-eh.c.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Does this mean SET FEATURES - XFER MODE via SG_IO will be possible soon?
>  ;-)

Hopefully, yeah.

-- 
tejun
