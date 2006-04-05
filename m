From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_sil24: fixes, errata workaround and reset updates
Date: Wed, 5 Apr 2006 22:29:01 +0900
Message-ID: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.231]:9498 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751119AbWDEN3J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:09 -0400
Received: by wproxy.gmail.com with SMTP id i11so169924wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:08 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff, Carlos.

This patchset updates sata_sil24 and is composed eight patches.

#01	libata prep
#02-03	bug fix and errata workaround
#04	sil24 prep
#05	enable 64bit
#05-06	update softreset
#07	reimplement hardreset

This patchset is against...
  upstream [1]
  + libata reset updates patchset [2]

Thanks.

--
tejun

[1] c2a6585296009379e0f4eff39cdcb108b457ebf2
[2] Message-ID: <20060405131637.GB31998@htj.dyndns.org>
    (marc/gmane doesn't show the first message, don't know why)


