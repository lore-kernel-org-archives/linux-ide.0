From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Mon, 12 Mar 2007 17:25:32 -0500
Message-ID: <45F5D35C.6000408@linux.vnet.ibm.com>
References: <11734389353424-git-send-email-htejun@gmail.com>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48718 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932963AbXCLWZh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 18:25:37 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2CMQMqf009780
	for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 18:26:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2CMPZsL278782
	for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 18:25:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2CMPZ3K020088
	for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 18:25:35 -0400
In-Reply-To: <11734389353424-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * ipr is now the only user of ata_host_init().  Either kill it by
>   converting ipr to use ata_host_alloc() and friends or rename and
>   move it to libata-scsi.c

One of the problems with converting ipr to use ata_host_alloc and
friends is that it then forces ipr to tell libata how many "SATA ports"
are possible. On SAS, this number can't really be calculated, since
the maximum number of SATA devices which can possibly be cabled to a
SAS adapter, particularly with SAS expanders, is a very large number
and is not practical for how this is being used in the current
implementation. My guess is that aic94xx will have similar issues/concerns.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
