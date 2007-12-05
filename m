From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Wed, 05 Dec 2007 10:00:34 +0900
Message-ID: <4755F832.8090709@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468192463-git-send-email-htejun@gmail.com> <475526AD.3090406@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.182]:64532 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbXLEBAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:00:45 -0500
Received: by ro-out-1112.google.com with SMTP id p4so5764396roc
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:00:44 -0800 (PST)
In-Reply-To: <475526AD.3090406@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, jens.axboe@oracle.com

Albert Lee wrote:
> Maybe we should add an additional check to atapi_pio_bytes() such
> that "DRQ asserted with bytes = 0" is considered as AC_ERR_HSM?
> (patch attached below.) Otherwise the device might keep interruping us
> with DRQ asserted + zero byte count, and we are in infinite loop...

Yeah, the check will probably look best with ireason check.  I'll add it.

Thanks.

-- 
tejun
