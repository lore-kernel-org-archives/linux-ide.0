From: Tejun <htejun@gmail.com>
Subject: regarding ata_piix initialization trouble
Date: Thu, 23 Feb 2006 16:43:16 +0900
Message-ID: <43FD6794.8020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:34208 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750704AbWBWHn0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2006 02:43:26 -0500
Received: by wproxy.gmail.com with SMTP id 58so312449wri
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 23:43:24 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, "0602@eq.cz" <0602@eq.cz>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Jean & 0602.

I was digging ICH docs to reimplement ata_piix initialization and found 
out that 6300ESB lists high bits (the present bits) of PCS register as 
reserved. But they indiciate that the bits might change anytime just as 
in other docs. I think something went wrong with those bits in that 
particular chipset and Intel decided to ignore the bits.

I'm wondering whether your problems are related to this. Can you guys 
please run 'lspci -n' on your machines which had the piix initialization 
trouble and report the result here?

Thanks a lot.

-- 
tejun
