From: Tejun Heo <htejun@gmail.com>
Subject: Re: problem detecting ATAPI device with ahci on 2.6.21-rcx
Date: Thu, 22 Mar 2007 16:14:02 +0900
Message-ID: <46022CBA.9090209@gmail.com>
References: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:16390 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965781AbXCVHOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 03:14:08 -0400
Received: by ug-out-1314.google.com with SMTP id 44so603818uga
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 00:14:07 -0700 (PDT)
In-Reply-To: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org

Kristen Carlson Accardi wrote:
> Hi, I upgrade a machine from 2.6.20->2.6.21-rc4 and am now having problems
> with my ATAPI device getting detected properly.  Back tracking to 2.6.21-rc1,
> I find the problem existed there too, but not in 2.6.20.

Please post boot dmesg of 2.6.20.  Is your ATAPI device connected using
80c cable?

-- 
tejun
