From: "Andrew Chew" <achew@nvidia.com>
Subject: RE: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 11:45:19 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95F4@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.145]:38930 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266567AbUG0SqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2004 14:46:05 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> Please fix and resubmit:
> 4) [leak] driver appears to be missing a ->host_free hook, to 
> free your 
> nv_host_t structure.
> 
> +       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);

I register a host_stop routine, nv_host_stop(), that frees the host.  Is
this not the correct way to free the nv_host?
