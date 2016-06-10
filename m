From: Brian King <brking@linux.vnet.ibm.com>
Subject: [RFC] [PATCH 0/3] Convert ipr to use
 ata_port_operations->error_handler
Date: Fri, 10 Jun 2016 16:33:09 -0500
Message-ID: <575B3215.5070602@linux.vnet.ibm.com>
References: <CAOS58YO65A8TpH22tEdM4SUcn8ncpY1f_YFMzomCN09OvhoRaQ@mail.gmail.com>
 <57470450.3070000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2727 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752068AbcFJVdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2016 17:33:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5ALT0NW073606
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:33:14 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23g1e5nk5x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:33:13 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 17:33:13 -0400
In-Reply-To: <57470450.3070000@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On 05/26/2016 09:12 AM, Brian King wrote:
> On 05/25/2016 02:32 PM, Tejun Heo wrote:
>> Hello, Brian.
>>
>> So, of all the ata drivers, ipr seems to be the only driver which
>> doesn't implement ata_port_opeations->error_handler and thus depends
>> on the old error handling path. I'm wondering whether it'd be possible
>> to convert ipr to implement ->error_handler and drop the old path.
>> Would that be difficult?
> 
> Last time I looked at that there were a number of challenges in doing that,
> but let me take another look and see if we can figure out a way to do that.

Here is an initial attempt to do this conversion. Probably plenty of bugs
in it, and more testing is needed before this would be ready to apply.

-Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

