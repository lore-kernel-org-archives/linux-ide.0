From: Jeff Garzik <jeff@garzik.org>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 23:09:00 -0500
Message-ID: <4D3E4CDC.3090409@garzik.org>
References: <20110125030410.GA24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58891 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab1AYEJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 23:09:04 -0500
Received: by vws16 with SMTP id 16so2167391vws.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 20:09:03 -0800 (PST)
In-Reply-To: <20110125030410.GA24024@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>

On 01/24/2011 10:04 PM, Herbert Poetzl wrote:
> I recently bought the WDC WD20EARS-00MVWB0 because it
> was really cheap for a drive with 64 MB cache, and I
> wanted to try out a 4k sector size disk ...
>
> Now the drive performs quite well, is rather silent
> and doesn't use much power or produce much heat, but
> at first I didn't find anything in Linux indicating
> that this drive would actually use 4k sectors.

See https://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues

