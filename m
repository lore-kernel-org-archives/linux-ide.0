From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/15] sata_sil24: separate out sil24_exec_polled_cmd()
Date: Fri, 13 Jul 2007 12:06:46 +0900
Message-ID: <4696EC46.7060308@gmail.com>
References: <11832872551258-git-send-email-htejun@gmail.com> <46968E50.9040505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:40765 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396AbXGMDKZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 23:10:25 -0400
Received: by py-out-1112.google.com with SMTP id d32so539933pye
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 20:10:24 -0700 (PDT)
In-Reply-To: <46968E50.9040505@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Separate out sil24_exec_polled_cmd() from sil24_softreset().  This
>> will be used to implement sil24_pmp_read/write().
> 
> you should order patches like these near the top of the first patchset,
> since they are so easy and quick to review and merge.

Alright, will move.

-- 
tejun
