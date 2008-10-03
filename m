From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] sgiioc4: sgiioc4_read_status drive busy check fix
Date: Fri, 3 Oct 2008 18:49:10 +0200
Message-ID: <200810031849.11365.bzolnier@gmail.com>
References: <200809282348.52748.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:31658 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbYJCRnh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 13:43:37 -0400
Received: by gv-out-0910.google.com with SMTP id e6so296255gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 03 Oct 2008 10:43:36 -0700 (PDT)
In-Reply-To: <200809282348.52748.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

On Sunday 28 September 2008, Sergei Shtylylov wrote:
> Fix the drive non-busy criterion used by sgiioc4_read_status(): neither of the
> bits it expects to be set guarantees that the drive is not busy (and might be
> interrupting), only the BSY bit itself being zero gurantees that.
> While at it, use ATA_BUSY instead of hardcoded value everywhere...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied patches #1-2
