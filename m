From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 2/4] libata: implement ata_link, take 5
Date: Mon, 16 Jul 2007 18:42:20 +0900
Message-ID: <469B3D7C.8060601@gmail.com>
References: <11845784783033-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:6137 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431AbXGPJm0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:42:26 -0400
Received: by py-out-1112.google.com with SMTP id d32so2171203pye
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:42:25 -0700 (PDT)
In-Reply-To: <11845784783033-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Oops, forgot one thing.

Tejun Heo wrote:
> Changes from the last take[L] are.
> 
> * ata_link_init_spd_limit() renamed to ata_link_init_spd()

* PMP link number now map to C of SCSI H:C:I:L as Jeff requested.

-- 
tejun
