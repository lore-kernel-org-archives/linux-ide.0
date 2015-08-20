From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Kernel broken for some disk interface / disks combinations
Date: Fri, 21 Aug 2015 00:23:39 +0200
Message-ID: <55D6536B.2010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34642 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbHTWXn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Aug 2015 18:23:43 -0400
Received: by wicne3 with SMTP id ne3so4936336wic.1
        for <linux-ide@vger.kernel.org>; Thu, 20 Aug 2015 15:23:41 -0700 (PDT)
Received: from [192.168.1.100] (host21-54-dynamic.17-87-r.retail.telecomitalia.it. [87.17.54.21])
        by smtp.gmail.com with ESMTPSA id uo6sm7368455wjc.1.2015.08.20.15.23.40
        for <linux-ide@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2015 15:23:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

please CC me in answers.

I have recently run into an issue with a system with

- ASRock N68S motherboard with AMD Phenom(tm) II X4 920 Processor and
> NVIDIA MCP61 SATA/IDE Chipset
> - IDE drive connected as slave on ide interface where master is HL-DT-ST
> DVD-RAM GH22NP20 CDROM/DVD writer


