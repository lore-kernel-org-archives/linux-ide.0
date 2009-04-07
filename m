From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/5] ata: Add TRIM infrastructure
Date: Mon, 06 Apr 2009 20:02:26 -0400
Message-ID: <49DA9812.2080802@garzik.org>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42371 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857AbZDGACb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 20:02:31 -0400
In-Reply-To: <1238683047-13588-3-git-send-email-willy@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

Matthew Wilcox wrote:
> This is common code shared between the IDE and libata implementations
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  include/linux/ata.h |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)

applied


