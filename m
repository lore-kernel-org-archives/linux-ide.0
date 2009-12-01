From: Tejun Heo <tj@kernel.org>
Subject: Re: SiI3811 PATA->SATA bridge not working on OpenRD-Base
Date: Tue, 01 Dec 2009 15:08:08 +0900
Message-ID: <4B14B2C8.6080002@kernel.org>
References: <20091113212332.GD1965@twin.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54855 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbZLAGHs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 01:07:48 -0500
Received: from htj.dyndns.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nB167rpM008754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 1 Dec 2009 06:07:55 GMT
Received: from [127.0.0.2] (htj.dyndns.org [127.0.0.2])
	by htj.dyndns.org (Postfix) with ESMTPSA id 19611100C9642
	for <linux-ide@vger.kernel.org>; Tue,  1 Dec 2009 15:08:08 +0900 (KST)
In-Reply-To: <20091113212332.GD1965@twin.sascha.silbe.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

On 11/14/2009 06:23 AM, Sascha Silbe wrote:
> Nov 13 21:05:02 flatty kernel: ata2: hard resetting link
> Nov 13 21:05:03 flatty kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
> SControl F300)

Hmmm... that's HSM violation.

> Is there a way to figure out what component is to blame? I.e. whether
> its the SATA host adapter driver (sata_mv) or something more generic?

In libata-sff.c there are several places which set AC_ERR_HSM.  They
store the reason why they're setting it using ata_eh_push_desc() but
for EH commands those messages aren't printed out (we probably need to
fix that).  Anyways, can you please conver those to printk's and see
which one is setting HSM error?

Thanks.

-- 
tejun
