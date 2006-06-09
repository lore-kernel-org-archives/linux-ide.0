From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 09 Jun 2006 11:39:01 +0800
Message-ID: <1149824341.5721.19.camel@forrest26.sh.intel.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
	 <1149820043.5721.7.camel@forrest26.sh.intel.com>
	 <4488EB4A.4050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27793 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965127AbWFIDvA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 23:51:00 -0400
In-Reply-To: <4488EB4A.4050501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

On Thu, 2006-06-08 at 23:30 -0400, Jeff Garzik wrote:
> When AHCI runs out of commands to execute, it transitions from H:Idle to 
> Ccc:SetIS.
> 

Oh, that's my misunderstanding of the spec. Thanks for your patience.

Forrest
