From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] stop gcc warning about uninitialized 'dev' in	ata_scsi_scan_host
Date: Thu, 16 Oct 2008 11:11:51 +0900
Message-ID: <48F6A2E7.5090005@kernel.org>
References: <20081015232505.GB9272@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35831 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbYJPCNh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 22:13:37 -0400
In-Reply-To: <20081015232505.GB9272@ldl.fc.hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, jeff@redhat.com, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Alex Chiang wrote:
> Shuts up gcc-3.4.5-glibc-2.3.6 when it complains of:
> 
> drivers/ata/libata-scsi.c: In function `ata_scsi_scan_host':
> drivers/ata/libata-scsi.c:3225: warning: 'dev' might be used
> uninitialized in this function
> 
> Signed-off-by: Alex Chiang <achiang@hp.com>

Nacked-by: Tejun Heo <tj@kernel.org>

Some gcc versions complain about sata_via, others complain about
something else.  Some versions complain about some iterator usages while
not complaining about others, but none of those complaints is actually
wrong or dangerous.  I don't think adding = NULL whenever some version
of gcc complains is the right approach.

Thanks.

-- 
tejun
