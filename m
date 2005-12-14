From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/4] libata: implement ata_exec_internal()
Date: Wed, 14 Dec 2005 18:01:30 +0800
Message-ID: <439FED7A.2020405@tw.ibm.com>
References: <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org> <439E54F8.8020304@pobox.com> <439E56E1.1070109@gmail.com> <439E59C1.6090002@pobox.com> <20051213054831.GA20810@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:18918 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932133AbVLNKBg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 05:01:36 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBEA1WbA005397
	for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2005 05:01:32 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBEA0fNh141398
	for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2005 03:00:41 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBEA1V0E018570
	for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2005 03:01:31 -0700
In-Reply-To: <20051213054831.GA20810@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch implements ata_exec_internal() function which performs
> libata internal command execution.  Previously, this was done by each
> user by manually initializing a qc, issueing it, waiting for its
> completion and handling errors.  In addition to obvious code
> factoring, using ata_exec_internal() fixes the following bugs.
> 
> * qc not freed on issue failure
> * ap->qactive clearing could race with the next internal command
> * race between timeout handling and irq
> * ignoring error condition not represented in tf->status

Thanks, this fixes the "phantom slave device" problem on my machine. :)

> 
> Also, qc & hardware are not accessed anymore once it's completed,
> making internal commands more conformant with general semantics.
> ata_exec_internal() also makes it easy to issue internal commands from
> multiple threads if that becomes necessary.
> 
> This patch only implements ata_exec_internal().  A following patch
> will convert all users.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 

