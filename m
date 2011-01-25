From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 23:23:23 -0500
Message-ID: <4D3E503B.40207@teksavvy.com>
References: <20110125030410.GA24024@MAIL.13thfloor.at>	<yq14o8x3c8t.fsf@sermon.lab.mkp.net>	<20110125033259.GC24024@MAIL.13thfloor.at> <yq1zkqp1vxl.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:13293 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752879Ab1AYEXY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 23:23:24 -0500
In-Reply-To: <yq1zkqp1vxl.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>, linux-ide@vger.kernel.org

On 11-01-24 10:52 PM, Martin K. Petersen wrote:
..
> If the drive had reported its block size correctly mkfs would have
> picked this information up automatically.

Apparently revision 00Z drives now show 4096 physical sector size,
with 512 for logical.  Can anyone out there confirm this first-hand?
(hdparm -I)

Thanks
