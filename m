From: "Vladimir G. Ustinov" <v.g.ustinov@gmail.com>
Subject: WDC WD740ADFD-00NLR5
Date: Wed, 25 May 2011 15:59:56 +0700
Message-ID: <4DDCC50C.4040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1EYI76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 04:59:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so5200041fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2011 01:59:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

libata-core.c have a line
{ "WDC WD740ADFD-00NLR1", NULL,        ATA_HORKAGE_NONCQ, },
for exclude usage of NCQ for non-NCQ (TCQ) device WD740ADFD-00NLR1

I have WDC WD740ADFD-00NLR5. It is the same device with the same problem.
Please add it to exclude list.

