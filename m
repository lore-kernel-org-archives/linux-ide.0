From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/3] libata: check for AN support
Date: Thu, 29 Mar 2007 10:53:10 +0900
Message-ID: <460B1C06.6040808@gmail.com>
References: <20070328230108.597741522@intel.com> <20070328164443.9fc8b924.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:36168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965889AbXC2BxS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 21:53:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so390632uga
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 18:53:17 -0700 (PDT)
In-Reply-To: <20070328164443.9fc8b924.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Kristen Carlson Accardi wrote:
> Check to see if an ATAPI device supports Asynchronous Notification.
> If so, enable it.

As supporting AN needs host interrupt handler change.  I think we need 
host-supports-AN flag; otherwise, we might end up with screaming 
interrupts in the worst case.

-- 
tejun
