From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch] libata: use correct map_db values for ICH8
Date: Fri, 20 Oct 2006 18:06:53 +0900
Message-ID: <453891AD.70704@gmail.com>
References: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:61089 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932228AbWJTJHC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 05:07:02 -0400
Received: by ug-out-1314.google.com with SMTP id o38so698623ugd
        for <linux-ide@vger.kernel.org>; Fri, 20 Oct 2006 02:07:01 -0700 (PDT)
In-Reply-To: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Hello, Kristen.

Kristen Carlson Accardi wrote:
> Use valid values for ICH8 map_db.  With the old values, when the 
> controller was in Native mode, and SCC was 1 (drives configured for
> IDE), any drive plugged into a slave port was not recognized.  For
> Combined Mode (and SCC is still 1), 2 is a value value for MAP.map_value,
> and needs to be recognized.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Do you guys have doc update related to this?  The doc and spec update 
still indicate that MAP value is reserved to 00b.  Anyways, if you say 
that's right...

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
