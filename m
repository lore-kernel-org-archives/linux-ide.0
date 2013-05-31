From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ipr: qc_fill_rtf() method should not store alternate
 status register
Date: Sat, 01 Jun 2013 02:37:00 +0400
Message-ID: <51A9260C.20504@cogentembedded.com>
References: <201305212324.22822.sergei.shtylyov@cogentembedded.com> <51A89BBB.1030705@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57121 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951Ab3EaWg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 18:36:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so2196329lbf.0
        for <linux-ide@vger.kernel.org>; Fri, 31 May 2013 15:36:56 -0700 (PDT)
In-Reply-To: <51A89BBB.1030705@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>, tj@kernel.org
Cc: JBottomley@parallels.com, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 05/31/2013 04:46 PM, Brian King wrote:

>
>> The 'ctl' field of  the 'struct ata_taskfile' is not really dual purpose, i.e.
>> it is not intended  for storing the alternate status register (which is mapped
>> at the same address in the legacy IDE controllers) in the qc_fill_rtf() method.
>> No other 'libata' driver except 'drivers/scsi/ipr.c' stores the alternate status
>> register's value in the 'ctl' field of 'qc->result_tf', hence this driver should
>> not do this as well...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Brian King <brking@linux.vnet.ibm.com>
>

     Tejun, I would prefer that this patch be merged thru the libata tree
as my future cleanup patches depend on it.

MBR, Sergei

