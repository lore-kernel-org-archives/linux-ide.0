From: Tejun Heo <htejun@gmail.com>
Subject: regarding Silicon Image 3124/3132 driver
Date: Fri, 01 Jul 2005 08:19:26 +0900
Message-ID: <42C47DFE.4050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:8481 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263091AbVF3XTf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 19:19:35 -0400
Received: by wproxy.gmail.com with SMTP id i11so211879wra
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2005 16:19:32 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


  Hello, Jeff.

  For the past few days, I've been trying to rewrite sata_sil24 driver 
to make it look better and support NCQ.  Unfortunately, I cannot figure 
out how to make sactive register work on this hardware.  Do you happen 
to know who can I contact to get some technical information (hopefully 
document, but just some tips are good too) about this chip?

  TIA.

-- 
tejun
