From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED] ahci: add "em_buffer" attribute for AHCI hosts
Date: Fri, 09 Apr 2010 10:50:52 +0900
Message-ID: <4BBE87FC.2060407@kernel.org>
References: <1268131075.2000.6.camel@harry-desktop> <1270539831.1963.29.camel@harry-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52781 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab0DIBrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 21:47:33 -0400
In-Reply-To: <1270539831.1963.29.camel@harry-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

On 04/06/2010 04:43 PM, Harry Zhang wrote:
> Subject: [PATCH] ahci: add "em_buffer" attribute for AHCI hosts
> 
> Add "em_buffer" attribute for SATA AHCI hosts to allow users accessing
> AHCI EM (enclosure management buffer) in user space if the host supports
> EM.
> 
> AHCI driver should support SGPIO EM message. But the spec does not
> define the SGPIO message format filled in EM buffer. HW vendors may have
> different definitions. The mainly purpose of "em_buffer" attribute is to
> enable SGPIO initiator control in user space rather than in kernel.
> 
> Signed-off-by: Harry Zhang <harry.zhang@amd.com>

Patch corrupted.  Doesn't apply.  Can you please repost?

-- 
tejun
