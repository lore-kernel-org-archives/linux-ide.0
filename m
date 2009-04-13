From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH] sata_mv: increate the IORDY timeout for the soc
	controllers
Date: Mon, 13 Apr 2009 16:11:01 +0300
Message-ID: <c70ff3ad0904130611u56f43d24me413e27b7bbb3b3d@mail.gmail.com>
References: <20090411160815.GA10995@deprecation.cyrius.com>
	 <49E1FCBC.5010101@rtr.ca>
	 <c70ff3ad0904130013n319510c4w5ae071076717f2bd@mail.gmail.com>
	 <49E334DF.4030703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58605 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZDMNLE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 09:11:04 -0400
Received: by fxm2 with SMTP id 2so1983143fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 06:11:01 -0700 (PDT)
In-Reply-To: <49E334DF.4030703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

>>
>> PIO mode is always used, at least for the identify command. the patch
>> works and needed for the Kirkwood SoC which runs at 200KHz.
>
> ..
>
> Errr.. IDENTIFY is often a "special case" command,
> and rarely, if ever, uses IORDY.
I think you misunderstand the EDMA IORDY timer, The EDMA IORDY
register defines the timeout when doing PIO data transfers and the
data is not ready, for example, when doing PIO read, the CPU will
access the data register to fetch the data from internal fifo, in case
that fifo is emptied for too long time (the data stopped to come), the
HW will release the CPU to prevent hanging the system.


saeed
