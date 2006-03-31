From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ata_bus_probe failure handling
Date: Sat, 1 Apr 2006 01:38:17 +0900
Message-ID: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:42854 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751380AbWCaQiZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:25 -0500
Received: by zproxy.gmail.com with SMTP id o37so955013nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:23 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset is composed of 15 patches and aims to...

1. push more configuration responsibilities to higher level (from
   ata_set_mode to ata_bus_probe)
2. implement speed down mechanism to be used by ata_bus_probe and
   later by EH
3. improve ata_bus_probe such that it handles configuration failures
   better (speed down, reset & retry)

The patches can be grouped as follows.

#01-05	: misc fixes/preprations around the affected code area
#06-08  : make ata_set_mode() fail instead of disabling devices directly
#09-13	: implement SATA SPD / transfer mode speed down mechanism
#14-15	: improve probing process such that it handles failures better

#05 is identical to the previously posted version[1].  #06-08 are
reimplementaion of [2].

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9035
[2] http://article.gmane.org/gmane.linux.ide/9036


